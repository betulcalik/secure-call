import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:secure_call/features/registration/models/login_model.dart';
import 'package:secure_call/features/registration/models/register_model.dart';
import 'package:secure_call/features/registration/models/resend_code_model.dart';
import 'package:secure_call/features/registration/models/verify_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository {
  String url = "http://localhost:5000";

  Future<Map<String, dynamic>> register(RegisterModel model) async {
    var response = await http.post(
      Uri.parse('$url/register'),
      body: {
        'username': "${model.firstName.toLowerCase()}.${model.lastName.toLowerCase()}",
        'countryCode': model.countryCode,
        'phoneNumber': model.phoneNumber,
        'password': model.password,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String token = jsonResponse['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return {'success': true, 'message': 'Registration successful'};
    }

    if (response.body.isNotEmpty) {
      var errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'];
      return {'success': false, 'message': errorMessage};
    }

    return {'success': false, 'message': 'Unexpected error occurred'};
  }

  Future<Map<String, dynamic>> login(LoginModel model) async {
    var response = await http.post(
      Uri.parse('$url/login'),
      body: {
        'phone': model.phone,
        'password': model.password,
      },
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Login successful'};
    }

    if (response.body.isNotEmpty) {
      var errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'];
      return {'success': false, 'message': errorMessage};
    }

    return {'success': false, 'message': 'Unexpected error occurred'};
  }

  Future<void> logout() async {

  }

  Future<Map<String, dynamic>> verify(VerifyModel model) async {
    var response = await http.post(
      Uri.parse('$url/verify'),
      body: {
        'phone': model.phone,
        'code': model.code,
      },
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Verify successful'};
    }

    if (response.body.isNotEmpty) {
      var errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'];
      return {'success': false, 'message': errorMessage};
    }

    return {'success': false, 'message': 'Unexpected error occurred'};
  }

  Future<Map<String, dynamic>> resendCode(ResendCodeModel model) async {
    var response = await http.post(
      Uri.parse('$url/resendCode'),
      body: {
        'phone': model.phone
      },
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Resend code successful'};
    }

    if (response.body.isNotEmpty) {
      var errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'];
      return {'success': false, 'message': errorMessage};
    }

    return {'success': false, 'message': 'Unexpected error occurred'};
  }
}