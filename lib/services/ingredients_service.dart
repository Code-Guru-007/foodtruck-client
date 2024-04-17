import 'dart:convert';

import 'package:http/http.dart' as http;

class IngredientsService {
  static Future<bool> deleteById(String id) async {
    final url = 'http://localhost:8080/api/v1/ingredient/$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> fetchGetAllIngredients() async {
    const url = 'http://localhost:8080/api/v1/ingredient/';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }
}
