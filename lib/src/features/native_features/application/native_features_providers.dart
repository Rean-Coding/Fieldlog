import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/channel_native_features_repository.dart';
import '../domain/native_features_repository.dart';

part 'native_features_providers.g.dart';

@Riverpod(keepAlive: true)
NativeFeaturesRepository nativeFeaturesRepository(NativeFeaturesRepositoryRef ref) {
  return ChannelNativeFeaturesRepository();
}
