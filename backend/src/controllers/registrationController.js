const db = require('../database/db');
const Registration = require('../models/registrationModel');

// Add event Registration
exports.addRegistration = (req, res) => {
  const { eventId, userId, name, email, phone } = req.body;

  if (!eventId || !userId || !name || !email || !phone) {
    return res.status(400).json({ message: 'Please provide all required fields' });
  }

  const query = 'SELECT * FROM registrations WHERE event_id = ? AND user_id = ?';
  db.query(query, [eventId, userId], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.length > 0) {
      return res.status(409).json({ message: 'User is already registered for this event' });
    }

    const insertQuery = 'INSERT INTO registrations (event_id, user_id, name, email, phone) VALUES (?, ?, ?, ?, ?)';
    db.query(insertQuery, [eventId, userId, name, email, phone], (err, results) => {
      if (err) {
        return res.status(500).json({ message: 'Database error' });
      }
      res.status(201).json({ message: 'Registration added successfully', registrationId: results.insertId });
    });
  });
};

// Update event Registration
exports.updateRegistration = (req, res) => {
  const { id } = req.params;
  const { eventId, userId, name, email, phone } = req.body;

  const query = 'UPDATE registrations SET event_id = ?, user_id = ?, name = ?, email = ?, phone = ? WHERE id = ?';
  db.query(query, [eventId, userId, name, email, phone, id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Registration not found' });
    }
    res.status(200).json({ message: 'Registration updated successfully' });
  });
};

// Delete event Registration
exports.deleteRegistration = (req, res) => {
  const { id } = req.params;

  const query = 'DELETE FROM registrations WHERE id = ?';
  db.query(query, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Registration not found' });
    }
    res.status(200).json({ message: 'Registration deleted successfully' });
  });
};

// Get List of Registrations
exports.getRegistrations = (req, res) => {
  const query = `
    SELECT registrations.*, events.title AS eventTitle, users.name AS userName
    FROM registrations
    JOIN events ON registrations.event_id = events.id
    JOIN users ON registrations.user_id = users.id
  `;
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    res.status(200).json(results);
  });
};

// Get Registration by ID
exports.getRegistrationById = (req, res) => {
  const { id } = req.params;

  const query = `
    SELECT registrations.*, events.title AS eventTitle, users.name AS userName
    FROM registrations
    JOIN events ON registrations.event_id = events.id
    JOIN users ON registrations.user_id = users.id
    WHERE registrations.id = ?
  `;
  db.query(query, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.length === 0) {
      return res.status(404).json({ message: 'Registration not found' });
    }
    res.status(200).json(results[0]);
  });
};
