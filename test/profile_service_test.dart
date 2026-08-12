import 'package:flutter_test/flutter_test.dart';
import 'package:fieldlog_flutter/src/features/profile/application/profile_service.dart';
import 'package:fieldlog_flutter/src/features/profile/data/fake_profile_repository.dart';

void main() {
  group('ProfileService', () {
    test('enrol persists a profile and returns it', () async {
      final service = ProfileService(FakeProfileRepository());

      final result = await service.enrol(id: 'metrey', name: 'Metrey');

      expect(result.id, 'metrey');
      expect(result.name, 'Metrey');
      expect(result.role, 'Member');
    });

    test('find returns null for an unknown id', () async {
      final service = ProfileService(FakeProfileRepository());
      expect(await service.find('unknown'), isNull);
    });

    test('find returns the previously-enrolled profile', () async {
      final service = ProfileService(FakeProfileRepository());
      await service.enrol(id: 'metrey', name: 'Metrey');

      final found = await service.find('metrey');
      expect(found, isNotNull);
      expect(found!.name, 'Metrey');
    });
  });
}
