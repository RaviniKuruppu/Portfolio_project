import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environments/environment.dart';
import '../models/event.dart';

class EventService {
  final Environment environment = Environment();

  Future<List<Event>> fetchEvents() async {
    final url = '${environment.localUrl}/events';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> addEvent(Event event) async {
    final url = '${environment.localUrl}/events';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add event');
    }
  }

  Future<void> updateEvent(Event event) async {
    final url = '${environment.localUrl}/events';
    final response = await http.put(
      Uri.parse('$url/${event.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(int id) async {
    final url = '${environment.localUrl}/events';
    final response = await http.delete(Uri.parse('$url/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
}
