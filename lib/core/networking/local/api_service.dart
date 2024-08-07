import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../features/home/presentation/data/dto/get_all_categories_dto.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.1.70:5500/api/admin/get';

  static Future<GetAllCategoriesDTO> getCategories() async {
    final response = await http.get(Uri.parse(_baseUrl));

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
}
