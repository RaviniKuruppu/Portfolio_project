import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      title: json['title'],
      color: colorFromString(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': colorToString(color),
    };
  }

  static const List<String> availableColors = [
    'red',
    'blue',
    'green',
    'yellow',
    'orange',
    'purple',
    'pink',
    'brown',
    'grey',
    // Add more colors as needed
  ];

  static const Map<String, Color> colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    // Add more colors as needed
  };

  static Color colorFromString(String colorString) {
    return colorMap[colorString.toLowerCase()] ?? Colors.orange;
  }

  static String colorToString(Color color) {
    return colorMap.entries
        .firstWhere((entry) => entry.value == color, orElse: () => const MapEntry('orange', Colors.orange))
        .key;
  }
}
