import 'dart:convert';

class AuthEntity {
  final String? id;
  final String fname;
  final String lname;
  final String email;
  final String password;

  AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
    };
  }
}
