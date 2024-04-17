import 'dart:convert';

import 'package:http/http.dart' as http;

class MeasurementUnitsService {
  static const String _baseUrl = 'http://localhost:8080/api/v1'; // Your API URL

  static Future<List?> fetchMeasurementUnits() async {
    final response = await http.get(Uri.parse('$_baseUrl/measurement'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      throw Exception('Failed to load measurement units');
    }
  }
}
