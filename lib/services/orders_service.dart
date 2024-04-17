import 'dart:convert';

import 'package:http/http.dart' as http;

class OrdersService {
  static Future<bool> updateOrder(List orders, int selected) async {
    const url = 'http://localhost:8080/api/v1/salesorder/edit';
    final uri = Uri.parse(url);
    Map<String, dynamic> order = orders.isNotEmpty ? orders[selected] : {};

    final response = await http.post(
      uri,
      body: jsonEncode(order),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    const url = 'http://localhost:8080/api/v1/salesorder/delete';
    final uri = Uri.parse(url);

    final body = {
      "_id": id,
    };

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 201;
  }

  static Future<List?> fetchGetAllOrders() async {
    const url = 'http://localhost:8080/api/v1/salesorder/get';
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
