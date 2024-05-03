// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
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
        return {
          'success': true,
          'data': json.decode(response.body),
        };
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
        _userToken = data['bdata']['token'];
        // Store the token securely
        await secureStorage.write(key: 'userToken', value: _userToken);
        print(_userToken);
        return {'success': true, 'data': data, "Token": _userToken};
      } else {
        return {
          'success': false,
          'message':
              'Failed to sign in with status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      throw Exception('Failed to sign in with unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> verifyPhone(String phone, String code) async {
    final String verifyUrl = 'https://booking.nauli.co.ke/api/v1/verify/$phone';

    try {
      final response = await http.post(
        Uri.parse(verifyUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
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

  Future<Map<String, dynamic>> saveSelfBooking({
    String choice = "self",
    required String travel_date,
    required String to,
    required String time,
    required String seats,
    required String pick_up,
  }) async {
    // Retrieve the token from secure storage
    String? userToken = await secureStorage.read(key: 'userToken');

    var saveBookingUrl = "https://booking.nauli.co.ke/api/v1/booking/save";

    try {
      final response = await http.post(
        Uri.parse(saveBookingUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(<String, dynamic>{
          'choice': choice,
          'travel_date': travel_date,
          'to': to,
          'time': time,
          'seats': seats,
          'pick_up': pick_up
        }),
      );

      if (response.statusCode == 200) {
        // Assuming the API sends the verification code upon successful registration
        return {
          'success': true,
          'data': json.decode(response.body),
        };
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

  Future<List<Map<String, dynamic>>> fetchAllBookings() async {
    const String apiUrl = 'https://booking.nauli.co.ke/api/v1/bookings';
    String? userToken = await secureStorage.read(key: 'userToken');
    print("$userToken");

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> bookingsData = jsonResponse['bookings']['data'];

        List<Map<String, dynamic>> bookingsList = [];
        for (var booking in bookingsData) {
          Map<String, dynamic> bookingInfo = {
            'id': booking['id'],
            'number': booking['id'],
            'reference': booking['reference_no'],
            'travelDate': booking['travel_date'],
            'seats': booking['seats'],
            'amount': booking['amount'],
          };
          bookingsList.add(bookingInfo);
        }

        return bookingsList;
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> saveOtherBooking({
    String choice = "other",
    required String travel_date,
    required String to,
    required String time,
    required String seats,
    required String pick_up,
    required String first_name,
    required String last_name,
    required String phone,
  }) async {
    // Retrieve the token from secure storage
    String? userToken = await secureStorage.read(key: 'userToken');

    var saveBookingUrl = "https://booking.nauli.co.ke/api/v1/booking/save";

    try {
      final response = await http.post(
        Uri.parse(saveBookingUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(<String, dynamic>{
          'choice': choice,
          'travel_date': travel_date,
          'to': to,
          'time': time,
          'seats': seats,
          'pick_up': pick_up,
          'first_name': first_name,
          'last_name': last_name,
          'phone': phone
        }),
      );

      if (response.statusCode == 200) {
        // Assuming the API sends the verification code upon successful registration
        return {
          'success': true,
          'data': json.decode(response.body),
        };
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

  Future<void> makePayment(int bookingId) async {
    final String apiUrl =
        'https://booking.nauli.co.ke/api/v1/make_payment/$bookingId';
    String? userToken = await secureStorage.read(key: 'userToken');
    print("$userToken");

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        // Payment successful, handle response accordingly
        print('Payment successful');
      } else {
        throw Exception('Failed to make payment');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

