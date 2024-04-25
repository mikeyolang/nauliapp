// ignore_for_file: avoid_print

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
        _userToken = data['token']; // Save the token for future requests
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
          // Use the token received upon login for authorization
          // 'Authorization': _userToken != null ? 'Bearer $_userToken' : '',
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

  Future<Map<String, dynamic>> saveBookingRequest({
    String choice = 'self',
    required String travelDate,
    required String toRouteId,
    required String time,
    required String seats,
    required String pickUp,
  }) async {
    // API endpoint
    String apiUrl = 'https://booking.nauli.co.ke/api/v1/booking/save';

    // Prepare the data to be sent in the request body
    Map<String, String> requestData = {
      'choice': choice,
      'travel_date': travelDate,
      'to': toRouteId,
      'time': time,
      'seats': seats,
      'pick_up': pickUp,
    };

    // Encode the data to JSON
    String requestBody = json.encode(requestData);
    const token = "76|hW4NzC9gPzCqOBmT1Fq4pj4CdlHIhgqc0pZPUBok5d081b4f";

    try {
      // Make POST request
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Include the token in the request headers (replace `_userToken` with your token)
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      // Check the response status
      if (response.statusCode == 200) {
        print(response.body);
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        // Request failed with an error status code
        print(
            'Booking request failed with status code: ${response.statusCode}');
        print('Response: ${response.body}');
        // Handle the error (e.g., show an error message to the user)
        return {
          'success': false,
          'message':
              'Booking request failed with status code: ${response.statusCode}',
        };
      }
    } on SocketException {
      return {'success': false, 'message': 'No Internet connection'};
    } on HttpException {
      return {'success': false, 'message': 'Couldn\'t find the post'};
    } on FormatException {
      return {'success': false, 'message': 'Bad response format'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }

  Future<List<dynamic>> getBookingData() async {
    // API endpoint
    String apiUrl = 'https://booking.nauli.co.ke/api/v1/bookings';

    try {
      // Make GET request
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_userToken'
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Get booking data successful!');
        // Parse the response body
        Map<String, dynamic> responseBody = json.decode(response.body);
        // Get the list of bookings
        List<dynamic> bookings = responseBody['bookings'];
        print('Bookings: $bookings');
        return bookings;
      } else {
        // Request failed with an error status code
        print(
            'Get booking data failed with status code: ${response.statusCode}');
        print('Response: ${response.body}');
        // Handle the error (e.g., show an error message to the user)
        return [];
      }
    } catch (e) {
      print('Error getting booking data: $e');
      return [];
    }
  }
   Future<List<Map<String, dynamic>>> fetchBookings() async {
     String bearerToken =_userToken!;
    const String apiUrl = 'https://booking.nauli.co.ke/api/v1/bookings';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $bearerToken',
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

  Future<void> makePayment(int bookingId) async {
     String bearerToken = _userToken!;
    final String apiUrl =
        'https://booking.nauli.co.ke/api/v1/make_payment/$bookingId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $bearerToken',
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
