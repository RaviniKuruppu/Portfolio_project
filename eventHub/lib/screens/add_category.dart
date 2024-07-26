import 'package:flutter/material.dart';
import '../models/category.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key, required this.onAddCategory});

  final Future<void> Function(String title, String color) onAddCategory;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _selectedColor = Category.availableColors.first;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text;
      final color = _selectedColor;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category Added Successfully')),
      );

      await widget.onAddCategory(title, color);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Please fill the form ",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      child: const Text('Add Category'),
                    ),
                  ],
                ),
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
