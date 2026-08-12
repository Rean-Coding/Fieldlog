// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'f452f578caea2f9452afdbdd5c63cde2a4cbd6a5';

/// The Repository — for now a fake. In W7 this returns a DriftProfileRepository
/// (and nothing else in the app changes).
///
/// Copied from [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider = Provider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = ProviderRef<ProfileRepository>;
String _$profileServiceHash() => r'e0a31502e298ba0af0fec189b17f4c8cdc902c44';

/// The Service. Depends on the abstract Repository — never on the concrete.
///
/// Copied from [profileService].
@ProviderFor(profileService)
final profileServiceProvider = Provider<ProfileService>.internal(
  profileService,
  name: r'profileServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileServiceRef = ProviderRef<ProfileService>;
String _$profileNotifierHash() => r'ecd701d11ef8b98f06c22cc4eab396abe01c7245';

/// Notifier — the application-layer holder of UI state for the profile feature.
/// `Notifier` returns the *current* state synchronously; AsyncNotifier (W5)
/// handles loading/error/data states.
///
/// This notifier exposes the user's enrolment result. It calls into the
/// Service for actual work — the Notifier does no business logic.
///
/// Copied from [ProfileNotifier].
@ProviderFor(ProfileNotifier)
final profileNotifierProvider =
    AutoDisposeNotifierProvider<ProfileNotifier, Profile?>.internal(
  ProfileNotifier.new,
  name: r'profileNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProfileNotifier = AutoDisposeNotifier<Profile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
