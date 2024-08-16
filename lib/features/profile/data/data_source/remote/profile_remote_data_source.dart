// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import '../../dto/profile_dto.dart';
//
// class RemoteDataSource {
//   final http.Client client;
//   final String baseUrl;
//
//   RemoteDataSource(this.client, this.baseUrl);
//
//   // URL for uploading profile picture
//   String get uploadProfilePicUrl => "$baseUrl/profile/uploadProfilePic";
//   // URL for getting user info
//   String get getUserInfoUrl => "$baseUrl/profile/info";
//
//   Future<ProfileDto> getProfile() async {
//     final uri = Uri.parse(getUserInfoUrl);
//     final response = await client.get(uri);
//
//     if (response.statusCode == 200) {
//       return ProfileDto.fromJson(json.decode(response.body));
//     } else {
//       // Print detailed error information for debugging
//       print('Request URL: $uri');
//       print('Response Body: ${response.body}');
//       throw Exception('Failed to load profile, status code: ${response.statusCode}');
//     }
//   }
//
//   Future<void> uploadProfilePic(XFile file) async {
//     final uri = Uri.parse(uploadProfilePicUrl);
//     final request = http.MultipartRequest('POST', uri)
//       ..files.add(await http.MultipartFile.fromPath('file', file.path));
//
//     final response = await request.send();
//     if (response.statusCode != 200) {
//       // Print response details for debugging
//       print('Request URL: $uri');
//       print('Response Status Code: ${response.statusCode}');
//       throw Exception('Failed to upload profile picture');
//     }
//   }
// }
