import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_item.dart';
import 'event_details.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({
    super.key,
    required this.events,
    this.title,
    required this.onToggleFavorite,
    required this.onUpdateEvent,
    required this.isUpdateAllowed,
    required this.onDeleteEvent,
    required this.isDeleteAllowed,
  });

  final String? title;
  final List<Event> events;
  final void Function(Event event) onToggleFavorite;
  final void Function(Event event) onUpdateEvent;
  final bool isUpdateAllowed;
  final void Function(Event event) onDeleteEvent;
  final bool isDeleteAllowed;

  void selectEvent(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventDetailsScreen(
          event: event,
          onToggleFavorite: onToggleFavorite,
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
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Nothing here",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );

    if (events.isNotEmpty) {
      content = LayoutBuilder(
        builder: (ctx, constraints) {
          final bool isLargeScreen = constraints.maxWidth > 600;
          if (isLargeScreen) {
            // Use GridView for large screens
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: events.length,
              itemBuilder: (ctx, index) => EventItem(
                event: events[index],
                onSelectEvent: (event) {
                  selectEvent(context, event);
                },
                isLargeScreen: true,
              ),
            );
          } else {
            // Use ListView for small screens
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (ctx, index) => EventItem(
                event: events[index],
                onSelectEvent: (event) {
                  selectEvent(context, event);
                },
                isLargeScreen: false,
              ),
            );
          }
        },
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
