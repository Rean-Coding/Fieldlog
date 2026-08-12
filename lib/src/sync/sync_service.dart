import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/app_database.dart';

// ─────────────────────────────────────────────────────────────
// Week 9: SyncService — a documented long-lived Service.
//
// This is the documented exception to Rule S2 (stateless services). The
// SyncService holds:
//   - a long-lived StreamSubscription to connectivity changes
//   - a "is currently draining the queue" boolean
//   - a retry-backoff timer
//
// All other Service rules still apply:
//   S1 ✓ one per cross-cutting concern (sync)
//   S3 ✓ returns domain types (Future<void> for fire-and-forget)
//   S4 ✓ depends on abstractions (the database accessor below could be
//        an abstract SyncableRepository in production)
//   S5 ✓ no Flutter import beyond `foundation` for `kDebugMode`
//   S6 ✓ orchestrates only — does not render anything
//
// Real implementations integrate `connectivity_plus`. For the sample we
// expose a `triggerSync()` method that students can call from the UI to
// simulate connectivity returning.
// ─────────────────────────────────────────────────────────────

class SyncService {
  SyncService(this._db);

  final AppDatabase _db;
  final Random _random = Random();

  bool _draining = false;
  Duration _backoff = const Duration(seconds: 1);
  static const _maxBackoff = Duration(seconds: 8);

  /// Drains the PendingSync queue. Idempotent — calling it while a drain is
  /// in progress is a no-op. In production, hook this up to
  /// `Connectivity().onConnectivityChanged`.
  Future<void> triggerSync() async {
    if (_draining) return;
    _draining = true;
    try {
      while (true) {
        final pending = await _db.select(_db.pendingSync).get();
        if (pending.isEmpty) break;
        for (final row in pending) {
          final ok = await _syncOne(row);
          if (!ok) {
            _bumpBackoff();
            return; // retry later
          }
        }
        _resetBackoff();
      }
    } finally {
      _draining = false;
    }
  }

  /// Simulates uploading one queued entry. 80% success.
  /// In production this becomes a `Dio` call to your sync endpoint.
  Future<bool> _syncOne(PendingSyncData row) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final ok = _random.nextInt(10) < 8;
    if (ok) {
      await _db.transaction(() async {
        await (_db.update(_db.logEntries)
              ..where((t) => t.id.equals(row.logEntryId)))
            .write(const LogEntriesCompanion(isPending: Value(false)));
        await (_db.delete(_db.pendingSync)
              ..where((t) => t.id.equals(row.id)))
            .go();
      });
      return true;
    } else {
      await (_db.update(_db.pendingSync)
            ..where((t) => t.id.equals(row.id)))
          .write(PendingSyncCompanion(
        retryCount: Value(row.retryCount + 1),
        lastAttemptAt: Value(DateTime.now()),
      ));
      if (kDebugMode) {
        debugPrint('Sync failed for ${row.id}; will retry');
      }
      return false;
    }
  }

  void _bumpBackoff() {
    final next = _backoff * 2;
    _backoff = next > _maxBackoff ? _maxBackoff : next;
  }

  void _resetBackoff() => _backoff = const Duration(seconds: 1);
}
