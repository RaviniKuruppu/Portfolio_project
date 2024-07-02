import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  int? _userId;
  String? _role;

  int? get userId => _userId;
  String? get role => _role;

  Future<void> setUserIdAndRole(int userId, String role) async {
    _userId = userId;
    _role = role;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('role', role);
  }

  Future<void> loadUserIdAndRole() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userId');
    _role = prefs.getString('role');
    notifyListeners();
  }

  Future<void> clearUserIdAndRole() async {
    _userId = null;
    _role = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('role');
  }
}
