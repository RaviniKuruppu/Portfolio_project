import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/event.dart';
import '../widgets/category_grid_item.dart';
import 'events.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onTogglesFavorites, required this.availableEvents,required this.onUpdateEvent});

  final void Function(Event meal) onTogglesFavorites;
  final List<Event> availableEvents;
  final void Function(Event event) onUpdateEvent;

  void _selectCategory(BuildContext context, Category category) {
    final filteredEvents = availableEvents.where(
      (meal) => meal.categories.contains(category.id),
    ).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventsScreen(
          events: filteredEvents,
          title: category.title,
          onToggleFavorite: onTogglesFavorites,
          onUpdateEvent: onUpdateEvent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
     
    );
  }
}
