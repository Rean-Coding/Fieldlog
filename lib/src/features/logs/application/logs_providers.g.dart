// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$logsRepositoryHash() => r'55b1e97d36acb2ecaedc1fbaaa692559575fc2e2';

/// The Repository — fake in W5, will become DriftLogsRepository in W7.
///
/// Copied from [logsRepository].
@ProviderFor(logsRepository)
final logsRepositoryProvider = Provider<LogsRepository>.internal(
  logsRepository,
  name: r'logsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$logsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogsRepositoryRef = ProviderRef<LogsRepository>;
String _$logsServiceHash() => r'f2005a5bc1b132baeb84217db98374c5ea37b516';

/// The Service — depends on the abstract Repository.
///
/// Copied from [logsService].
@ProviderFor(logsService)
final logsServiceProvider = Provider<LogsService>.internal(
  logsService,
  name: r'logsServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogsServiceRef = ProviderRef<LogsService>;
String _$logsNotifierHash() => r'2ec02561d308cd004e1b80b55ae92fc30bec1a48';

/// AsyncNotifier exposing the user's logs.
///
/// The `build` method returns `Future<List<LogEntry>>`. Riverpod wraps this in
/// `AsyncValue<List<LogEntry>>` for us — the UI uses `.when(...)` to render
/// the four states:
///   - AsyncLoading  → skeleton
///   - AsyncData     → list (or empty state if list.isEmpty)
///   - AsyncError    → error UI with retry
///
/// Pull-to-refresh is implemented via `ref.refresh(logsNotifierProvider)`.
///
/// Copied from [LogsNotifier].
@ProviderFor(LogsNotifier)
final logsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<LogsNotifier, List<LogEntry>>.internal(
  LogsNotifier.new,
  name: r'logsNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LogsNotifier = AutoDisposeAsyncNotifier<List<LogEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
