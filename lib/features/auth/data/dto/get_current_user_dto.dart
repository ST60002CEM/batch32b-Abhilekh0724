import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/auth_entity.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name: "_id")
  final String id;
  final String fname;
  final String lname;
  final String phone;
  final String image;
  final String username;

  GetCurrentUserDto({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.image,
    required this.username,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      phone: phone,
      image: image,
      username: username,
      password: '', // Assuming password is not part of the user DTO and needs to be handled separately
    );
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) => _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
