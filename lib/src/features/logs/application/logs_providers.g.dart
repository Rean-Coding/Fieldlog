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
String _$logsDaoHash() => r'2b13b2c7763b75fb40e71b046544d1fbadbc0a4d';

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
String _$logsRepositoryHash() => r'c50b5c6b510ce3aa7f97266b31295d5d4585c6c6';

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
String _$logsServiceHash() => r'f2005a5bc1b132baeb84217db98374c5ea37b516';

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
String _$logsNotifierHash() => r'5e559cf5f4dfa8783e95f97b46622ef86f13083a';

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
