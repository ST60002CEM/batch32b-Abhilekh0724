import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../features/book/data/model/booking_model.dart';
import '../../../features/home/presentation/data/dto/get_all_categories_dto.dart';
import '../../../features/home/presentation/data/model/venue_card.dart';


class ApiService {
  static const String baseUrl = 'http://192.168.1.70:5500/api/';
  static const String bookCategoryUrl = '${baseUrl}book/book';
  static const String getCategoryByIdUrl = '${baseUrl}admin/get/';
  static const String submitReviewUrl = '${baseUrl}review/reviews';
  static const String getBookingsByCategoryUrl = '${baseUrl}book/category/';
  static const String getBookingsByUserUrl = '${baseUrl}book/bookeduser';

  static const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YjQ2OTBkYTNjMjMyM2U0NzA4NzUyNCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTcyMzIxOTg3NH0.EgJ1kPdpmKPvENy_3HeEdRlFQpaNBC5Guv7Cb1pfaSM';

  static Future<void> bookCategory(String categoryId, String userId, DateTime bookingDate) async {
    try {
      final response = await http.post(
        Uri.parse(bookCategoryUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use the provided token here
        },
        body: json.encode({
          'categoryId': categoryId,
          'userId': userId,
          'bookingDate': bookingDate.toIso8601String(),
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}'); // Print full response body for debugging

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] != true) {
          throw Exception('Failed to book category: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('Failed to book category: ${response.statusCode}');
      }
    } catch (e) {
      print('Booking Exception: $e');
      throw Exception('Failed to book category');
    }
  }

  // Fetch all categories
  static Future<GetAllCategoriesDTO> getCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}admin/get'));

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return GetAllCategoriesDTO.fromJson(jsonResponse);
      } catch (e) {
        print('JSON Parsing Exception: $e');
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Fetch category by ID
  static Future<VenueCard> getCategoryById(String id) async {
    final url = '$getCategoryByIdUrl$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return VenueCard.fromJson(jsonResponse['category']);
      } catch (e) {
        print('JSON Parsing Exception: $e');
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load category');
    }
  }

  // Submit a review
  static Future<void> submitReview(String categoryId, double rating, String comment) async {
    final response = await http.post(
      Uri.parse(submitReviewUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the token if required by the API
      },
      body: json.encode({
        'categoryId': categoryId,
        'userId': '66b4690da3c2323e47087524', // Replace with actual user ID if necessary
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode != 201) { // Check for successful creation
      throw Exception('Failed to submit review');
    }
  }

  // Get bookings by category
  static Future<List<Booking>> getBookingsByCategory(String categoryId) async {
    final response = await http.get(Uri.parse('$getBookingsByCategoryUrl$categoryId'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((bookingJson) => Booking.fromJson(bookingJson)).toList();
      } catch (e) {
        print('JSON Parsing Exception: $e');
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  // Get bookings by user
  static Future<List<Booking>> getBookingsByUser(String userId) async {
    final response = await http.get(Uri.parse('$getBookingsByUserUrl/$userId'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((bookingJson) => Booking.fromJson(bookingJson)).toList();
      } catch (e) {
        print('JSON Parsing Exception: $e');
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  // Profile API Endpoints
  static const String _uploadProfilePicUrl = '${baseUrl}profile/uploadProfilePic';
  static const String _getUserInfoUrl = '${baseUrl}profile/info';

  static Future<Map<String, dynamic>> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse(_getUserInfoUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  static Future<void> uploadProfilePic(String token, File file) async {
    final request = http.MultipartRequest('POST', Uri.parse(_uploadProfilePicUrl))
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('profilePic', file.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to upload profile picture');
    }
  }
}
