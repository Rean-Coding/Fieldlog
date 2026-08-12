/// Domain entity for a user profile.
///
/// Immutable. No Flutter import. No serialization. The pure shape of the
/// concept "Profile" in the domain language of FieldLog.
final class Profile {
  const Profile({
    required this.id,
    required this.name,
    required this.role,
  });

  final String id;
  final String name;
  final String role;

  Profile copyWith({String? id, String? name, String? role}) => Profile(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile && id == other.id && name == other.name && role == other.role;

  @override
  int get hashCode => Object.hash(id, name, role);

  @override
  String toString() => 'Profile(id: $id, name: $name, role: $role)';
}
