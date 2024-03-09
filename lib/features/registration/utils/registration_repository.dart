import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:secure_call/features/registration/models/login_model.dart';
import 'package:secure_call/features/registration/models/register_model.dart';
import 'package:secure_call/features/registration/models/resend_code_model.dart';
import 'package:secure_call/features/registration/models/verify_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/api_service.dart';

class RegistrationRepository {

  Future<Map<String, dynamic>> register(RegisterModel model) async {
    Map<String, String> body = {
      'username': "${model.firstName.toLowerCase()}.${model.lastName.toLowerCase()}",
      'countryCode': model.countryCode,
      'phoneNumber': model.phoneNumber,
      'password': model.password,
    };

    try {
      http.Response response = await APIService.post("register", body);

      if (response.statusCode ==  200 || response.statusCode ==  201) {
        var jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return {'success': true, 'message': 'Registration successful'};
      } else {
        return {'success': false, 'message': 'Unexpected error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>> login(LoginModel model) async {
    Map<String, String> body = {
      'phone': model.phone,
      'password': model.password,
    };

    try {
      http.Response response = await APIService.post("login", body);

      if (response.statusCode ==  200 || response.statusCode ==  201) {
        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': 'Unexpected error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': e};
    }
  }

  Future<void> logout() async {

  }

  Future<Map<String, dynamic>> verify(VerifyModel model) async {
    Map<String, String> body = {
      'phone': model.phone,
      'code': model.code,
    };

    try {
      http.Response response = await APIService.post("verify", body);

      if (response.statusCode ==  200 || response.statusCode ==  201) {
        return {'success': true, 'message': 'Verify successful'};
      } else {
        return {'success': false, 'message': 'Unexpected error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>> resendCode(ResendCodeModel model) async {
    Map<String, String> body = {
      'phone': model.phone,
    };

    try {
      http.Response response = await APIService.post("resendCode", body);

      if (response.statusCode ==  200 || response.statusCode ==  201) {
        return {'success': true, 'message': 'Resend code successful'};
      } else {
        return {'success': false, 'message': 'Unexpected error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': e};
    }
  }
}