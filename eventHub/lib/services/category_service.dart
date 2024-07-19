import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environments/environment.dart';
import '../models/category.dart';

class CategoryService {
  final Environment environment = Environment();

  Future<List<Category>> fetchCategories() async {
    final url = '${environment.localUrl}/categories';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
