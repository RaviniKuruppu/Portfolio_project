import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/category.dart';
import '../services/event_service.dart';
import '../services/category_service.dart';
import '../widgets/event_drawer.dart';
import 'add_category.dart';
import 'add_event.dart';
import 'categories.dart';
import 'events.dart';
import 'filters.dart';

const kInitialFilter = {
  Filter.academic: false,
  Filter.extracurricular: false,
  Filter.careerDevelopment: false,
  Filter.social: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Event> _favoriteEvent = [];
  Map<Filter, bool> _selectFilters = kInitialFilter;
  bool _isUpdateAllowed = false;
  bool _isDeleteAllowed = false;
  late Future<List<Event>> _eventsFuture;
  late Future<List<Category>> _categoriesFuture;
  final EventService _eventService = EventService();
  final CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    _eventsFuture = _eventService.fetchEvents();
    _categoriesFuture = _categoryService.fetchCategories();
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleEventFavoriteStatus(Event event) {
    final isExisting = _favoriteEvent.contains(event);

    if (isExisting) {
      setState(() {
        _favoriteEvent.remove(event);
      });
      _showInfoMessage('Event is no longer a favorite.');
    } else {
      setState(() {
        _favoriteEvent.add(event);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> _addEvent(Event event) async {
    try {
      await _eventService.addEvent(event);
      setState(() {
        _eventsFuture = _eventService.fetchEvents();
      });
      _showInfoMessage('Event added successfully.');
    } catch (error) {
      _showInfoMessage('Failed to add event.');
    }
  }

  Future<void> _addCategory(String title, String color) async {
    try {
      await _categoryService.addCategory(title, color);
      setState(() {
        _categoriesFuture = _categoryService.fetchCategories();
      });
      _showInfoMessage('Category added successfully.');
    } catch (error) {
      print('Failed to add category: $error');
      _showInfoMessage('Failed to add category.');
    }
  }

  Future<void> _updateEvent(Event updatedEvent) async {
    try {
      await _eventService.updateEvent(updatedEvent);
      setState(() {
        _eventsFuture = _eventService.fetchEvents();
      });
      _showInfoMessage('Event updated successfully.');
    } catch (error) {
      _showInfoMessage('Failed to update event.');
    }
  }

  Future<void> _deleteEvent(Event eventToDelete) async {
    try {
      await _eventService.deleteEvent(eventToDelete.id);
      setState(() {
        _eventsFuture = _eventService.fetchEvents();
      });
      _showInfoMessage('Event deleted successfully.');
    } catch (error) {
      _showInfoMessage('Failed to delete event.');
    }
  }

  void _setScreen(String identifier, bool isLargeScreen) async {
    if (!isLargeScreen) {
      Navigator.of(context).pop(); // Close the drawer for small screens
    }

    if (identifier == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            currentFilter: _selectFilters,
          ),
        ),
      );

      setState(() {
        _selectFilters = result ?? kInitialFilter;
      });
    } else if (identifier == 'addEvent') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddEventScreen(
            onAddEvent: _addEvent,
          ),
        ),
      );
    } else if (identifier == 'addCategory') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddCategoryScreen(
            onAddCategory: _addCategory,
          ),
        ),
      );
    } else if (identifier == 'updateEvent') {
      setState(() {
        _isUpdateAllowed = true;
        _isDeleteAllowed = false;
      });
    } else if (identifier == 'deleteEvent') {
      setState(() {
        _isDeleteAllowed = true;
        _isUpdateAllowed = false;
      });
    } else {
      // Update the selected page index for large screens
      setState(() {
        if (identifier == 'events') {
          _selectedPageIndex = 0;
        } else if (identifier == 'favorites') {
          _selectedPageIndex = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 600;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Events'),
          ),
          drawer: isLargeScreen
              ? null
              : MainDrawer(
                  onSelectScreen: (identifier) =>
                      _setScreen(identifier, isLargeScreen),
                ),
          body: FutureBuilder<List<Event>>(
            future: _eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load events'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No events available'));
              } else {
                final availableEvents = snapshot.data!.where((event) {
                  if (_selectFilters[Filter.academic]! &&
                      !(event.eventType == 'academic')) {
                    return false;
                  }
                  if (_selectFilters[Filter.extracurricular]! &&
                      !(event.eventType == 'extracurricular')) {
                    return false;
                  }
                  if (_selectFilters[Filter.careerDevelopment]! &&
                      !(event.eventType == 'careerDevelopment')) {
                    return false;
                  }
                  if (_selectFilters[Filter.social]! &&
                      !(event.eventType == 'social')) {
                    return false;
                  }
                  return true;
                }).toList();

                Widget activePage = CategoriesScreen(
                  onTogglesFavorites: _toggleEventFavoriteStatus,
                  availableEvents: availableEvents,
                  onUpdateEvent: _updateEvent,
                  isUpdateAllowed: _isUpdateAllowed,
                  onDeleteEvent: _deleteEvent,
                  isDeleteAllowed: _isDeleteAllowed,
                  categoriesFuture: _categoriesFuture, // Pass the Future
                );
                var activePageTitle = 'Categories';

                if (_selectedPageIndex == 1) {
                  activePage = EventsScreen(
                    events: _favoriteEvent,
                    onToggleFavorite: _toggleEventFavoriteStatus,
                    onUpdateEvent: _updateEvent,
                    isUpdateAllowed: _isUpdateAllowed,
                    onDeleteEvent: _deleteEvent,
                    isDeleteAllowed: _isDeleteAllowed,
                  );
                  activePageTitle = 'Your Favorites';
                }

                return Row(
                  children: [
                    if (isLargeScreen)
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: MainDrawer(
                          onSelectScreen: (identifier) =>
                              _setScreen(identifier, isLargeScreen),
                        ),
                      ),
                    Expanded(child: activePage),
                  ],
                );
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.set_meal), label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
            ],
          ),
        );
      },
    );
  }
}
