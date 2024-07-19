enum OnsiteOrOnline {
  onsite,
  online,
}

class Event {
  const Event({
    required this.id,
    required this.categoryId,
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
  final String categoryId;
  final String title;
  final String imageUrl;
  final String subject;
  final String description;
  final String date;
  final String time;
  final String location;
  final OnsiteOrOnline onsiteOrOnline;
  final String eventType;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      categoryId: json['category_id'].toString(),
      title: json['title'],
      imageUrl: json['imageUrl'],
      subject: json['subject'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      onsiteOrOnline: json['onsiteOrOnline'] == 'onsite'
          ? OnsiteOrOnline.onsite
          : OnsiteOrOnline.online,
      eventType: json['eventType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'imageUrl': imageUrl,
      'subject': subject,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'onsiteOrOnline': onsiteOrOnline.toString().split('.').last,
      'eventType': eventType,
    };
  }
}
