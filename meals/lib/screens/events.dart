import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_item.dart';
import 'event_details.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key, required this.events, this.title, required this.onToggleFavorite,
  required this.onUpdateEvent
  });
  final String? title;
  final List<Event> events;
  final void Function (Event event) onToggleFavorite;
  final void Function(Event event) onUpdateEvent;

  void selectEvent(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EventDetailsScreen(event: event, onToggleFavorite: onToggleFavorite, onUpdateEvent: onUpdateEvent,),
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
            "nothing here",
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
      content = ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, index) => EventItem(
          event: events[index],
          onSelectEvent: (event) {
            selectEvent(context, event);
          },
        ),
      );
    }
    if (title== null) {
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
