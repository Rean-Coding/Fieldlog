// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'96b544ff7ce456f0fc1edbdafdf332306a9affed';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$logsDaoHash() => r'ec9982cf81ae6dc801b283166e389a17ea093bfc';

/// See also [logsDao].
@ProviderFor(logsDao)
final logsDaoProvider = Provider<LogsDao>.internal(
  logsDao,
  name: r'logsDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogsDaoRef = ProviderRef<LogsDao>;
String _$logsRepositoryHash() => r'e0de54dc0030970dc444c9caed5a40ed7e87c9de';

/// See also [logsRepository].
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogsRepositoryRef = ProviderRef<LogsRepository>;
String _$logsServiceHash() => r'20ccb2d481b44ca72d920d1030dc3acb0daee875';

/// See also [logsService].
@ProviderFor(logsService)
final logsServiceProvider = Provider<LogsService>.internal(
  logsService,
  name: r'logsServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogsServiceRef = ProviderRef<LogsService>;
String _$syncServiceHash() => r'11773556ef428e3bca7928ceeeb67bee199480a9';

/// W9: the SyncService is a long-lived Service. KeepAlive ensures it lives
/// for the lifetime of the app — the documented S2 exception.
///
/// Copied from [syncService].
@ProviderFor(syncService)
final syncServiceProvider = Provider<SyncService>.internal(
  syncService,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncServiceRef = ProviderRef<SyncService>;
String _$logsNotifierHash() => r'7b93edcb9904110c37cf7403087cfd9866a04b12';

/// See also [LogsNotifier].
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
