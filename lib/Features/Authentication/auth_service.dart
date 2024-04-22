import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AuthService {
  final String signUpUrl = 'https://booking.nauli.co.ke/api/v1/register';
  final String loginUrl = 'https://booking.nauli.co.ke/api/v1/login';
  String? _userToken;

  Future<Map<String, dynamic>> signUp(String phone, String firstName,
      String lastName, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return {'success': false, 'message': 'Passwords do not match'};
    }

    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Assuming the API sends the verification code upon successful registration
        return {'success': true, 'data': json.decode(response.body)};
      } else {
        return {
          'success': false,
          'message':
              'Failed to sign up with status code: ${response.statusCode}'
        };
      }
    } on SocketException {
      return {'success': false, 'message': 'No Internet connection'};
    } on HttpException {
      return {'success': false, 'message': 'Couldnt find the post'};
    } on FormatException {
      return {'success': false, 'message': 'Bad response format'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Future<Map<String, dynamic>> signIn(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _userToken = data['token']; // Save the token for future requests
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message':
              'Failed to sign in with status code: ${response.statusCode}'
        };
      }
    } on SocketException {
      return {'success': false, 'message': 'No Internet connection'};
    } on HttpException {
      return {'success': false, 'message': 'Couldnt find the post'};
    } on FormatException {
      return {'success': false, 'message': 'Bad response format'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Future<Map<String, dynamic>> verifyPhone(String phone, String code) async {
    final String verifyUrl = 'https://booking.nauli.co.ke/api/v1/verify/$phone';

    try {
      final response = await http.post(
        Uri.parse(verifyUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Use the token received upon login for authorization
          'Authorization': _userToken != null ? 'Bearer $_userToken' : '',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': json.decode(response.body)};
      } else {
        return {
          'success': false,
          'message':
              'Failed to verify phone with status code: ${response.statusCode}'
        };
      }
    } on SocketException {
      return {'success': false, 'message': 'No Internet connection'};
    } on HttpException {
      return {'success': false, 'message': 'Couldnt find the post'};
    } on FormatException {
      return {'success': false, 'message': 'Bad response format'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }
}
