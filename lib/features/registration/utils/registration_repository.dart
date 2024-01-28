import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:secure_call/features/registration/models/login_model.dart';
import 'package:secure_call/features/registration/models/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository {
  String url = "http://localhost:5000";

  Future<bool> register(RegisterModel model) async {
    var response = await http.post(
      Uri.parse('$url/register'),
      body: {
        'firstName': model.firstName,
        'lastName': model.lastName,
        'phone': model.phone,
        'password': model.password,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String token = jsonResponse['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    }

    return false;
  }

  Future<bool> login(LoginModel model) async {
    var response = await http.post(
      Uri.parse('$url/login'),
      body: {
        'phone': model.phone,
        'password': model.password,
      },
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<void> logout() async {

  }
}