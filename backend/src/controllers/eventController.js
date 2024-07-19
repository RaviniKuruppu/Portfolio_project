const db = require('../database/db');
const Event = require('../models/eventModel');

// Add Event
exports.addEvent = (req, res) => {
  const { categoryId, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType } = req.body;

  if (!categoryId || !title || !date || !time || !location || !onsiteOrOnline || !eventType) {
    return res.status(400).json({ message: 'Please provide all required fields' });
  }

  const query = 'INSERT INTO events (category_id, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  db.query(query, [categoryId, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    res.status(201).json({ message: 'Event added successfully', eventId: results.insertId });
  });
};

// Update Event
exports.updateEvent = (req, res) => {
  const { id } = req.params;
  const { categoryId, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType } = req.body;

  const query = 'UPDATE events SET category_id = ?, title = ?, imageUrl = ?, subject = ?, description = ?, date = ?, time = ?, location = ?, onsiteOrOnline = ?, eventType = ? WHERE id = ?';
  db.query(query, [categoryId, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType, id], (err, results) => {
    if (err) {
      console.error(err); // Log the error to the console
      return res.status(500).json({ message: 'Database error', error: err });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Event not found' });
    }
    res.status(200).json({ message: 'Event updated successfully' });
  });
};

// Delete Event
exports.deleteEvent = (req, res) => {
  const { id } = req.params;

  const query = 'DELETE FROM events WHERE id = ?';
  db.query(query, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Event not found' });
    }
    res.status(200).json({ message: 'Event deleted successfully' });
  });
};

// Get List of Events
exports.getEvents = (req, res) => {
  const query = `
    SELECT events.*, categories.title AS categoryTitle
    FROM events
    JOIN categories ON events.category_id = categories.id
  `;
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    res.status(200).json(results);
  });
};

// Get Event by ID
exports.getEventById = (req, res) => {
  const { id } = req.params;

  const query = `
    SELECT events.*, categories.title AS categoryTitle
    FROM events
    JOIN categories ON events.category_id = categories.id
    WHERE events.id = ?
  `;
  db.query(query, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.length === 0) {
      return res.status(404).json({ message: 'Event not found' });
    }
    res.status(200).json(results[0]);
  });
};
