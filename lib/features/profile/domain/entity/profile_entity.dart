import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class AuthEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String profilePic; // Add this field

  AuthEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePic = '', // Default to empty string if no profile picture
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);
}
