import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final String username;
  final String? password;

  AuthApiModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.phone,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      image: image,
      phone: phone,
      username: username,
      password: password ?? '',
    );
  }
}
