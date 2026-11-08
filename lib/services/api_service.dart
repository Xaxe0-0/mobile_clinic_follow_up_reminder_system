import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';

  static Future<dynamic> _decodeResponse(http.Response response) async {
    final body = response.body;

    dynamic data;

    try {
      data = jsonDecode(body);
    } catch (_) {
      data = {'message': 'The server returned an invalid response.'};
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    final message = data is Map
        ? data['message']?.toString() ?? 'Request failed.'
        : 'Request failed.';

    throw Exception(message);
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = await _decodeResponse(response);

    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected login response.');
    }

    final token = data['token'];

    if (token == null) {
      throw Exception('The server did not return an authentication token.');
    }

    await _storage.write(key: _tokenKey, value: token.toString());

    return data;
  }

  static Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  static Future<dynamic> get(String endpoint) async {
    final token = await getToken();

    if (token == null) {
      throw Exception('You are not logged in.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    return _decodeResponse(response);
  }

  static Future<void> logout() async {
    final token = await getToken();

    if (token != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      await _decodeResponse(response);
    }

    await _storage.delete(key: _tokenKey);
  }
}
