import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider((ref) => AuthHiveModel.empty());

@HiveType(typeId: HiveTableConstant.UserTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String username;

  @HiveField(5)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.username,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Empty constructor
  AuthHiveModel.empty()
      : this(
    userId: '',
    fname: '',
    lname: '',
    phone: '',
    username: '',
    password: '',
  );

  // Convert Entity to Hive Object
  AuthHiveModel fromEntity(AuthEntity entity) => AuthHiveModel(
    userId: const Uuid().v4(),
    fname: entity.fname,
    lname: entity.lname,
    phone: entity.phone,
    username: entity.username,
    password: entity.password,
  );

  @override
  String toString() {
    return 'userId: $userId, fname: $fname, lname: $lname, phone: $phone, username: $username, password: $password';
  }
}
