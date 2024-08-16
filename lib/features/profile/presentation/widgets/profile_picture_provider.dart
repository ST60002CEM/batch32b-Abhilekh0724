import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../core/networking/local/api_service.dart'; // Adjust the import as necessary

final profilePictureProvider = FutureProvider.autoDispose<void>((ref) async {
  final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YjQ2OTBkYTNjMjMyM2U0NzA4NzUyNCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTcyMzIxOTg3NH0.EgJ1kPdpmKPvENy_3HeEdRlFQpaNBC5Guv7Cb1pfaSM'; // Fetch the token from your secure storage
  final file = File(''); // Fetch the file from your image picker

  if (token.isEmpty || file == null) {
    throw Exception('Token or file not found');
  }

  try {
    await ApiService.uploadProfilePic(token, file);
    // Optionally, you can refetch user info or update the state here
  } catch (e) {
    throw Exception('Failed to upload profile picture');
  }
});
