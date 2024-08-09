import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../features/home/presentation/data/dto/get_all_categories_dto.dart';
import '../../../features/home/presentation/data/model/venue_card.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.1.70:5500/api/';
  static const String _getAllCategoriesUrl = '${_baseUrl}admin/get';
  static const String _getCategoryByIdUrl = '${_baseUrl}admin/get/';

  static Future<GetAllCategoriesDTO> getCategories() async {
    final response = await http.get(Uri.parse(_getAllCategoriesUrl));

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}'); // Print raw response

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Decoded JSON: $jsonResponse'); // Print decoded JSON
        return GetAllCategoriesDTO.fromJson(jsonResponse);
      } catch (e) {
        print('JSON Parsing Exception: $e'); // Debugging line
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<VenueCard> getCategoryById(String id) async {
    final url = '$_getCategoryByIdUrl$id';
    final response = await http.get(Uri.parse(url));

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}'); // Print raw response

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Decoded JSON: $jsonResponse'); // Print decoded JSON
        return VenueCard.fromJson(jsonResponse); // Adjust according to your model
      } catch (e) {
        print('JSON Parsing Exception: $e'); // Debugging line
        throw Exception('Failed to parse JSON');
      }
    } else {
      throw Exception('Failed to load category');
    }
  }
}
