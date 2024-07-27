class Registration {
  constructor(id, eventId, userId, name, email, phone) {
    this.id = id;
    this.eventId = eventId;
    this.userId = userId;
    this.name = name;
    this.email = email;
    this.phone = phone;
  }

  static fromJson(json) {
    return new Registration(
      json.id,
      json.eventId,
      json.userId,
      json.name,
      json.email,
      json.phone
    );
  }

  toJson() {
    return {
      id: this.id,
      eventId: this.eventId,
      userId: this.userId,
      name: this.name,
      email: this.email,
      phone: this.phone,
    };
  }
}

module.exports = Registration;
