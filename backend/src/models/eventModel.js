class Event {
    constructor(id, categoryId, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType) {
      this.id = id;
      this.categoryId = categoryId;
      this.title = title;
      this.imageUrl = imageUrl;
      this.subject = subject;
      this.description = description;
      this.date = date;
      this.time = time;
      this.location = location;
      this.onsiteOrOnline = onsiteOrOnline;
      this.eventType = eventType;
    }
  }
  
  module.exports = Event;
  