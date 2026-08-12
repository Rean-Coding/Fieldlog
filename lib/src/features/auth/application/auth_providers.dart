import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../networking/dio_provider.dart';
import '../../logs/domain/failure.dart';
import '../../logs/domain/result.dart';
import '../data/secure_auth_repository.dart';
import '../domain/auth_repository.dart';
import 'auth_service.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    SecureAuthRepository(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) =>
    AuthService(ref.watch(authRepositoryProvider));

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() => ref.read(authServiceProvider).isSignedIn;

  Future<Failure?> signIn({required String email, required String password}) async {
    final r = await ref.read(authServiceProvider).signIn(email: email, password: password);
    return switch (r) {
      Success<void>() => () { state = true; return null; }(),
      Failed<void>(:final failure) => failure,
    };
  }

  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
    state = false;
  }
}
