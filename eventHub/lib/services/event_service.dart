import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventService {
  static const String _baseUrl = 'http://your-backend-url.com/api/events';

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add event');
    }
  }

  Future<void> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${event.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
}
