import 'package:flutter/material.dart';
import '../models/event.dart';
import 'registration_form.dart';
import 'update_event.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen(
      {super.key, required this.event, required this.onToggleFavorite,
      required this.onUpdateEvent
      });

  final Event event;
  final void Function(Event meal) onToggleFavorite;
  final void Function(Event event) onUpdateEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavorite(event);
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: event.id,
              child: Image.network(
                event.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Subject',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              event.subject,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
        'Date and Time',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(
        height: 14,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'On ${event.date}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(width: 10), // Add some spacing between date and time
          Text(
            'At ${event.time}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
      const SizedBox(
        height: 14,
      ),
            Text(
              'Location',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              event.location,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                event.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => RegistrationForm(event: event),
                        ),
                      );
                    },
                    child: const Text('Register Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Notify button action
                    },
                    child: const Text('Notify'),
                  ),    
                ],
              ),
            ),
            ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => UpdateEventScreen(
                            event: event,
                            onUpdateEvent: onUpdateEvent,
                          ),
                        ),
                      );
                    },
                    child: const Text('Update Event'),
                  ),
                  const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
