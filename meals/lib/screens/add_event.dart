import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/event.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key, required this.onAddEvent});

  final void Function(Event event) onAddEvent;

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {

  //final availableCategories1 = availableCategories.toList();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _selectedCategory = availableCategories.first.id;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  OnsiteOrOnline _selectedOnsiteOrOnline = OnsiteOrOnline.onsite;
  String _selectedEventType = 'extracurricular';
  File? _selectedImage;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newEvent = Event(
        id: DateTime.now().toString(),
        title: _titleController.text,
        subject: _subjectController.text,
        date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
        time: _selectedTime!.format(context),
        location: _locationController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        //imageUrl: _selectedImage != null ? _selectedImage!.path : _imageUrlController.text,
        categories: _selectedCategory,
        onsiteOrOnline: _selectedOnsiteOrOnline,
        eventType: _selectedEventType,
      );
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event Added Successful')),
    );
      widget.onAddEvent(newEvent);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: availableCategories.map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Category'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
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
                  items: ['extracurricular', 'academic', 'social', 'career Development']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Event Type'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEventType = newValue!;
                    });
                  },
                ),
                // const SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: _pickImage,
                //   child: const Text('Pick Image from the device'),
                // ),
                // if (_selectedImage != null)
                //   Image.file(
                //     _selectedImage!,
                //     height: 100,
                //     width: 100,
                //   ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _selectDate,
                        child: Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _selectTime,
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
                  child: const Text('Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
