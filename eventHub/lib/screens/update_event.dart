import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../models/event.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class UpdateEventScreen extends StatefulWidget {
  const UpdateEventScreen({
    super.key,
    required this.event,
    required this.onUpdateEvent,
  });

  final Event event;
  final void Function(Event event) onUpdateEvent;

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subjectController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late String _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late OnsiteOrOnline _selectedOnsiteOrOnline;
  late String _selectedEventType;
  File? _selectedImage;
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _subjectController = TextEditingController(text: widget.event.subject);
    _locationController = TextEditingController(text: widget.event.location);
    _descriptionController = TextEditingController(text: widget.event.description);
    _imageUrlController = TextEditingController(text: widget.event.imageUrl);
    _selectedCategory = widget.event.categories;
    _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.event.date);
    _selectedTime = TimeOfDay(
      hour: int.parse(widget.event.time.split(":")[0]),
      minute: int.parse(widget.event.time.split(":")[1].split(" ")[0]),
    );
    _selectedOnsiteOrOnline = widget.event.onsiteOrOnline;
    _selectedEventType = widget.event.eventType;

    _imageUrlController.addListener(_updateImage);
    _categoriesFuture = CategoryService().fetchCategories();
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImage);
    _titleController.dispose();
    _subjectController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImage() {
    setState(() {
      // Update state to show the new image preview
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedEvent = Event(
        id: widget.event.id,
        title: _titleController.text,
        subject: _subjectController.text,
        date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
        time: _selectedTime!.format(context),
        location: _locationController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        categories: _selectedCategory,
        onsiteOrOnline: _selectedOnsiteOrOnline,
        eventType: _selectedEventType,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event Updated Successfully')),
      );
      widget.onUpdateEvent(updatedEvent);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Event'),
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
                        "Please update the form ",
                        style: TextStyle(fontSize: 25, color: Colors.grey),
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
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(labelText: 'Subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image URL';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_imageUrlController.text.isNotEmpty)
                      Image.network(_imageUrlController.text),
                    const SizedBox(height: 16),
                    FutureBuilder<List<Category>>(
                      future: _categoriesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error loading categories');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text('No categories available');
                        } else {
                          final categories = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            items: categories.map((Category category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.title),
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(labelText: 'Category'),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<OnsiteOrOnline>(
                      value: _selectedOnsiteOrOnline,
                      items: OnsiteOrOnline.values.map((OnsiteOrOnline value) {
                        return DropdownMenuItem<OnsiteOrOnline>(
                          value: value,
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      decoration: const InputDecoration(labelText: 'Onsite or Online'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOnsiteOrOnline = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedEventType,
                      items: [
                        'extracurricular',
                        'academic',
                        'social',
                        'career Development'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      decoration: const InputDecoration(labelText: 'Event Type'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedEventType = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 50,
                            child: ElevatedButton(
                              onPressed: _selectDate,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color.fromARGB(255, 5, 131, 235),
                              ),
                              child: Text(
                                _selectedDate == null
                                    ? 'Select Date'
                                    : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _selectTime,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromARGB(255, 5, 131, 235),
                            ),
                            child: Text(
                              _selectedTime == null
                                  ? 'Select Time'
                                  : _selectedTime!.format(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 5, 131, 235),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Update Event'),
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
