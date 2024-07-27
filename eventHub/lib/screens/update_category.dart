import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({super.key, required this.onUpdateCategory});

  final Future<void> Function(String id, String title, String color) onUpdateCategory;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategoryId;
  final _titleController = TextEditingController();
  String _selectedColor = Category.availableColors.first;

  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().fetchCategories();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text;
      final color = _selectedColor;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category Updated Successfully')),
      );

      await widget.onUpdateCategory(_selectedCategoryId!, title, color);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Category'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: FutureBuilder<List<Category>>(
                future: _categoriesFuture,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load categories'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  } else {
                    final categories = snapshot.data!;
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              "Please select a category to update",
                              style: TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            items: categories
                                .map((category) => DropdownMenuItem<String>(
                                      value: category.id,
                                      child: Text(category.title),
                                    ))
                                .toList(),
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(labelText: 'Category'),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategoryId = value;
                                final selectedCategory = categories.firstWhere(
                                    (category) => category.id == value);
                                _titleController.text = selectedCategory.title;
                                _selectedColor = Category.colorToString(
                                    selectedCategory.color);
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'Title'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedColor,
                            items: Category.availableColors.map((String color) {
                              return DropdownMenuItem<String>(
                                value: color,
                                child: Text(color.capitalize()), // capitalize the first letter
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(labelText: 'Color'),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedColor = newValue!;
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromARGB(255, 5, 131, 235),
                            ),
                            child: const Text('Update Category'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
