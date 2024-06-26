import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../main.dart';
import '../../widgets/error_dialog.dart';
import '../environments/environment.dart';
import '../models/login_model.dart';
import '../screens/login_screen.dart';
import '../screens/tabs.dart';

class AuthService {
  final Environment environment = Environment();
  final storage = const FlutterSecureStorage();
  late Dio _dio;

  AuthService() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await storage.read(key: 'access_token');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          await _refreshToken();
          String? accessToken = await storage.read(key: 'access_token');
          String? refreshToken = await storage.read(key: 'refresh_token');

          if (accessToken == null && refreshToken == null) {
            // Both tokens are expired, navigate to login page
            if (navigatorKey.currentContext != null) {
              Navigator.pushReplacement(
                navigatorKey.currentContext!,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            } else {
              throw Exception(
                  'Error: Unable to access context for navigation.');
            }
            return;
          }

          // Construct new options with updated headers
          Options options = Options(
            headers: error.requestOptions.headers,
            contentType: error.requestOptions.contentType,
          );
          if (accessToken != null) {
            options.headers!['Authorization'] = 'Bearer $accessToken';
          }

          // Retry the original request with the updated options
          return _dio
              .request(
                error.requestOptions.path,
                options: options,
              )
              .then((value) => handler.resolve(value));
        } else if (error.response?.statusCode == 403) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return const ErrorDialog(
                title: 'Incorrect Username or Password',
                message: 'Please enter the correct username and password',
              );
            },
          );
        }
        return handler.next(error);
      },
    ));
  }

  Future<void> login(BuildContext context, UserCredentials credentials) async {
    try {
      final response = await _dio.post(
        '${environment.baseUrl}/login',
        data: jsonEncode(<String, String>{
          'username': credentials.username,
          'password': credentials.password
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        await storage.write(key: 'access_token', value: data['access_token']);
        await storage.write(key: 'refresh_token', value: data['refresh_token']);
        Navigator.pushReplacement(
          navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const TabsScreen ()),
        );
      } 
      else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> register(
      BuildContext context, String username, String password) async {
    try {
      final response = await _dio.post(
        '${environment.baseUrl}/register',
        data: jsonEncode(
            <String, String>{'username': username, 'password': password}),
      );

      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        Navigator.pushReplacement(
          navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
    Navigator.pushReplacement(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<bool> isTokenExpired(String key) async {
    String? token = await storage.read(key: key);
    if (token != null) {
      Map<String, dynamic> payload = jsonDecode(token);
      if (payload.containsKey('exp')) {
        int expiryTimeInSeconds = payload['exp'];
        DateTime expiryDateTime =
            DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);
        return expiryDateTime.isBefore(DateTime.now());
      }
    }
    return true;
  }

  Future<void> _refreshToken() async {
    String? refreshToken = await storage.read(key: 'refresh_token');
    bool isRefreshExpired = await isTokenExpired('refresh_token');
    if (refreshToken != null && !isRefreshExpired) {
      final response = await _dio.post(
        '${environment.baseUrl}/refresh-token',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        String newAccessToken = data['access_token'];
        await storage.write(key: 'access_token', value: newAccessToken);
      }
    } else if (refreshToken != null && isRefreshExpired) {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
    }
  }

  Future<void> checkTokenExpiration(BuildContext context) async {
    bool isAccessExpired = await isTokenExpired('access_token');
    bool isRefreshExpired = await isTokenExpired('refresh_token');

    if (isAccessExpired && isRefreshExpired) {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
      Navigator.pushReplacement(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (isAccessExpired) {
      await _refreshToken();
    }
  }
}
