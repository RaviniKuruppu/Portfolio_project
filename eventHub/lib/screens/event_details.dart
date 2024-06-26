import 'package:flutter/material.dart';
import '../models/event.dart';
import 'registration_form.dart';
import 'update_event.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.onToggleFavorite,
    required this.onUpdateEvent,
    required this.isUpdateAllowed,
    required this.onDeleteEvent,
    required this.isDeleteAllowed,
  });

  final Event event;
  final void Function(Event event) onToggleFavorite;
  final void Function(Event event) onUpdateEvent;
  final bool isUpdateAllowed;
  final void Function(Event event) onDeleteEvent;
  final bool isDeleteAllowed;

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onToggleFavorite(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.width > 800 ? 400 : 300;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              Icons.star,
              color: isFavorite ? Colors.yellow : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                bool isLargeScreen = constraints.maxWidth > 800;
                return Hero(
                  tag: widget.event.id,
                  child: Image.network(
                    widget.event.imageUrl,
                    height: imageHeight,
                    width: isLargeScreen
                        ? constraints.maxWidth / 2
                        : double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
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
              widget.event.subject,
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
                  'On ${widget.event.date}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(
                    width: 10), // Add some spacing between date and time
                Text(
                  'At ${widget.event.time}',
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
              widget.event.location,
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
                widget.event.description,
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
                          builder: (ctx) =>
                              RegistrationForm(event: widget.event),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Set the background color to blue
                      foregroundColor:
                          Colors.white, // Set the text color to white
                    ),
                    child: const Text('Register Now'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Notify button action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Set the background color to blue
                      foregroundColor:
                          Colors.white, // Set the text color to white
                    ),
                    icon: const Icon(Icons.notifications),
                    label: const Text('Notify'),
                  ),
                ],
              ),
            ),
            if (widget.isUpdateAllowed)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => UpdateEventScreen(
                        event: widget.event,
                        onUpdateEvent: widget.onUpdateEvent,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue, // Set the background color to blue
                  foregroundColor: Colors.white, // Set the text color to white
                ),
                child: const Text('Update Event'),
              ),
            const SizedBox(
              height: 14,
            ),
            if (widget.isDeleteAllowed)
              ElevatedButton(
                onPressed: () async {
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor:
                          Colors.white, // Set the background color to white
                      title: const Text('Confirm Deletion'),
                      content: const Text(
                          'Are you sure you want to delete this event?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx)
                                .pop(false); // Return false when canceled
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.blue),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx)
                                .pop(true); // Return true when confirmed
                          },
                          style:
                              TextButton.styleFrom(foregroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirmDelete == true) {
                    widget.onDeleteEvent(widget.event);
                    Navigator.of(context)
                        .pop(); // Return to the previous screen
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red button for delete
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete Event'),
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
