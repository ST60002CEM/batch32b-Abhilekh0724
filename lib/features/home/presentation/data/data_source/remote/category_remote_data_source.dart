import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dto/get_all_categories_dto.dart';

class CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSource(this.client);

  Future<GetAllCategoriesDTO> getCategories() async {
    final response = await client.get(Uri.parse('your_api_endpoint_here'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return GetAllCategoriesDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
