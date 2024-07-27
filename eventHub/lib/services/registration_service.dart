import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_registration.dart';
import '../environments/environment.dart';

class RegistrationService {
  final Environment environment = Environment();
  Future<void> register(Registration registration) async {
    final url = '${environment.localUrl}/registrations';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(registration.toJson()),
    );

    if (response.statusCode == 409) {
      throw RegistrationException('User is already registered for this event');
    } else if (response.statusCode != 201) {
      throw Exception('Failed to register for the event');
    }
  }
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);

  @override
  String toString() => message;
}
