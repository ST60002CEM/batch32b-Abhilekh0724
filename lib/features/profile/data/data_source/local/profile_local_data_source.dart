// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// import '../../dto/profile_dto.dart';
//
// class LocalDataSource {
//   final SharedPreferences _prefs;
//
//   LocalDataSource(this._prefs);
//
//   Future<void> saveProfile(ProfileDto profile) async {
//     final profileJson = json.encode(profile.toJson());
//     await _prefs.setString('profile', profileJson);
//   }
//
//   Future<ProfileDto?> getProfile() async {
//     final profileJson = _prefs.getString('profile');
//     if (profileJson != null) {
//       return ProfileDto.fromJson(json.decode(profileJson));
//     }
//     return null;
//   }
// }
