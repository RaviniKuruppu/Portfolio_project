import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/event.dart';
import '../widgets/category_grid_item.dart';
import 'events.dart';
import '../services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
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

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().fetchCategories();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredEvents = widget.availableEvents.where(
      (meal) => meal.categories.contains(category.id),
    ).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventsScreen(
          events: filteredEvents,
          title: category.title,
          onToggleFavorite: widget.onTogglesFavorites,
          onUpdateEvent: widget.onUpdateEvent,
          isUpdateAllowed: widget.isUpdateAllowed,
          onDeleteEvent: widget.onDeleteEvent,
          isDeleteAllowed: widget.isDeleteAllowed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load categories'));
        } else {
          final categories = snapshot.data!;
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
                  for (final category in categories)
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
      },
    );
  }
}
