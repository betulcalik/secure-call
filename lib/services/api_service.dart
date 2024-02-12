import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {

  static String baseURL = "https://ac75-88-230-155-88.ngrok-free.app";

  static Future<dynamic> get(String url) async {
    try {
      var response = await http.get(
        Uri.parse('$baseURL/$url'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode ==  200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred during the GET request');
    }
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      var response = await http.post(
        Uri.parse('$baseURL/$url'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode !=  200 && response.statusCode !=  201) {
        throw Exception('Failed to make POST request');
      }

      return response;
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred during the POST request');
    }
  }

}