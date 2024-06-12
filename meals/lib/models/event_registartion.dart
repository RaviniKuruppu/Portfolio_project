class Registration {
  final String name;
  final String email;
  final String phoneNo;
  final int eventId;

  Registration({required this.name, required this.email,required this.phoneNo, required this.eventId});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'eventId': eventId
    };
  }
}