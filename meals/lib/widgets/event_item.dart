import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event, required this.onSelectEvent});

  final Event event;
  final void Function(Event event) onSelectEvent;

  // String get complexityTest {
  //   return event.complexity.name[0].toUpperCase() +
  //       event.complexity.name.substring(1);
  // }

  String get onsiteOrOnlineTest {
    return event.onsiteOrOnline.name[0].toUpperCase() +
        event.onsiteOrOnline.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectEvent(event);
        },
        child: Stack(
          children: [
            Hero(
              tag: event.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(event.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      event.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EventItemTrait(
                          icon: Icons.calendar_month_outlined,
                          label: 'On ${event.date}',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        EventItemTrait(
                          icon: Icons.schedule,
                          label: 'At ${event.time}',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EventItemTrait(
                          icon: Icons.place,
                          label: onsiteOrOnlineTest,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
