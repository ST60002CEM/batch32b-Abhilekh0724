import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider=Provider<AuthApiModel>((ref)=>AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'firstName')
  final String fname;
  @JsonKey(name: 'lastName')
  final String lname;
  final String email;
  final String? password;

  AuthApiModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
  });
  AuthApiModel.empty()
      : id = '',
        fname = '',
        lname='',
        email = '',
        password = '';

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      email: email,
      password: password ?? '',
    );
  }
  AuthApiModel fromEntity(AuthEntity entity) => AuthApiModel(
    id: id,
    fname: entity.fname,
    lname: entity.lname,
    email: entity.email,
    password: entity.password,
  );
}
