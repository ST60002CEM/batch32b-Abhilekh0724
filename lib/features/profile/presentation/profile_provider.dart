// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/networking/local/api_service.dart'; // Adjust the import as necessary
//
// final profileProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
//   final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YjQ2OTBkYTNjMjMyM2U0NzA4NzUyNCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTcyMzIxOTg3NH0.EgJ1kPdpmKPvENy_3HeEdRlFQpaNBC5Guv7Cb1pfaSM'; // Fetch the token from your secure storage
//   if (token.isEmpty) {
//     throw Exception('Token not found');
//   }
//
//   try {
//     final userInfo = await ApiService.getUserInfo(token);
//     return userInfo;
//   } catch (e) {
//     throw Exception('Failed to fetch user info');
//   }
// });
