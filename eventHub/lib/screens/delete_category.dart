import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class DeleteCategoryScreen extends StatefulWidget {
  const DeleteCategoryScreen({super.key, required this.onDeleteCategory});

  final Future<void> Function(String id) onDeleteCategory;

  @override
  State<DeleteCategoryScreen> createState() => _DeleteCategoryScreenState();
}

class _DeleteCategoryScreenState extends State<DeleteCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategoryId;

  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().fetchCategories();
  }

  void _submitForm() async {
    if (_selectedCategoryId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category Deleted Successfully')),
      );
      await widget.onDeleteCategory(_selectedCategoryId!);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category to delete.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Category'),
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
                boxShadow: const [
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
                              "Please select a category to delete",
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
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromARGB(255, 235, 87, 87),
                            ),
                            child: const Text('Delete Category'),
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
