import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/event.dart';
import '../widgets/event_drawer.dart';
import 'add_event.dart';
import 'categories.dart';
import 'events.dart';
import 'filters.dart';
//import 'update_event.dart';


const kInitialFilter =
  {
    Filter.academic: false,
    Filter.extracurricular: false,
    Filter.careerDevelopment: false,
    Filter.social: false
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

  void _updateEvent(Event updatedEvent) {
  setState(() {
    final index = dummyEvents.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      dummyEvents[index] = updatedEvent;
    }
  });
}

  

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
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

      //print(result);
    } else if (identifier == 'addEvent') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddEventScreen(
            onAddEvent: (event) {
              setState(() {
                dummyEvents.add(event);
              });
            },
          ),
        ),
      );
    } 
  }



  @override
  Widget build(BuildContext context) {
    final availableEvents = dummyEvents.where((event) {
      if (_selectFilters[Filter.academic]! && !(event.eventType == 'academic')) {
        return false;
      }
      if (_selectFilters[Filter.extracurricular]! && !(event.eventType == 'extracurricular')) {
        return false;
      }
      if (_selectFilters[Filter.careerDevelopment]! && !(event.eventType == 'careerDevelopment')) {
        return false;
      }
      if (_selectFilters[Filter.social]! && !(event.eventType == 'social')) {
        return false;
      }
      return true;

    }).toList();

    Widget activePage = CategoriesScreen(
      onTogglesFavorites: _toggleEventFavoriteStatus,
      availableEvents: availableEvents,
      onUpdateEvent: _updateEvent,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = EventsScreen(
        events: _favoriteEvent,
        onToggleFavorite: _toggleEventFavoriteStatus,
        onUpdateEvent: _updateEvent,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
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
  }
}
