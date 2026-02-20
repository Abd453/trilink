import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _role;
  String? _userName;
  bool _isLoggedIn = false;

  String? get role => _role;
  String? get userName => _userName;
  bool get isLoggedIn => _isLoggedIn;

  void login(String role, String name) {
    _role = role;
    _userName = name;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _role = null;
    _userName = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
