import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<Object> register(String phone, String firstName, String lastName,
      String password, String confirmPassword) async {
    if (password == confirmPassword) {
      return await _authService.signUp(
        phone,
        firstName,
        lastName,
        password,
        confirmPassword,
      );
    } else {
      return false; // Passwords do not match
    }
  }

  Future<Object> logIn(String phone, String password) async {
    return await _authService.signIn(
      phone,
      password,
    );
  }

  Future<Object> verifyPhone(String phone, String code) async {
    return await _authService.verifyPhone(
      phone,
      code,
    );
  }
}
