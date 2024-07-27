class Registration {
  const Registration({
    required this.eventId,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
  });

  final int eventId;
  final int userId;
  final String name;
  final String email;
  final String phone;

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      eventId: json['eventId'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
