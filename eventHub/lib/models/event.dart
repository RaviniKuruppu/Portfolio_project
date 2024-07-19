
enum OnsiteOrOnline {
  onsite,
  online,
}

class Event {
  const Event({
    required this.id,
    required this.category_id,
    required this.title,
    required this.imageUrl,
    required this.subject,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.onsiteOrOnline,
    required this.eventType,
  });

  final int id;
  final String category_id;
  final String title;
  final String imageUrl;
  final String subject;
  final String description;
  final String date;
  final String time;
  final String location;
  final OnsiteOrOnline onsiteOrOnline;
  final String eventType;
}