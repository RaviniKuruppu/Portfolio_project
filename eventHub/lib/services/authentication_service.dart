import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../models/login_model.dart';
import '../environments/environment.dart';
import '../models/signup.dart';
import '../screens/login_screen.dart';
import '../screens/tabs.dart';

class AuthService {
  final Environment environment = Environment();
  Future<void> login(BuildContext context, UserCredentials credentials) async {
    final url = '${environment.baseUrl}/login'; 

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': credentials.username,
          'password': credentials.password,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final responseData = json.decode(response.body);
        if (responseData != Null) {
          Navigator.pushReplacement(
          navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const TabsScreen ()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
        }
      } else {
        // Handle error
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  Future<void> signup(BuildContext context, SignUp credentials) async {
    final url = '${environment.baseUrl}/signup'; // Replace with your backend URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': credentials.username,
          'password': credentials.password,
          'name': credentials.name,
          'email': credentials.email,
          'role': "user"
        }),
      );

      if (response.statusCode == 201) {
        
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            // Handle successful signup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),
        );
      } else {
        // Handle error
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }



}
