import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/event.dart';
import '../widgets/category_grid_item.dart';
import 'events.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onTogglesFavorites,
    required this.availableEvents,
    required this.onUpdateEvent,
    required this.isUpdateAllowed,
    required this.onDeleteEvent,
    required this.isDeleteAllowed,
  });

  final void Function(Event meal) onTogglesFavorites;
  final List<Event> availableEvents;
  final void Function(Event event) onUpdateEvent;
  final bool isUpdateAllowed;
  final void Function(Event event) onDeleteEvent;
  final bool isDeleteAllowed;

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
          isUpdateAllowed: isUpdateAllowed,
          onDeleteEvent: onDeleteEvent,
          isDeleteAllowed: isDeleteAllowed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 600;
        final int crossAxisCount = isLargeScreen ? 3 : 2;

        return GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
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
      },
    );
  }
}
