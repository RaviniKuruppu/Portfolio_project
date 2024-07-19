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

  Future<void> addCategory(Category category) async {
    final url = '${environment.localUrl}/categories';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add category');
    }
  }

  Future<void> updateCategory(Category category) async {
    final url = '${environment.localUrl}/categories/${category.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(String id) async {
    final url = '${environment.localUrl}/categories/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete category');
    }
  }
}
