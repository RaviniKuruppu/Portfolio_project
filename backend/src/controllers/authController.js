const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');
const db = require('../database/db');

exports.login = (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Please provide a username and password' });
  }

  const query = 'SELECT * FROM user WHERE username = ?';
  db.query(query, [username], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.length === 0) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    const user = results[0];
    bcrypt.compare(password, user.password, (err, isMatch) => {
      if (err) {
        return res.status(500).json({ message: 'Error checking password' });
      }
      if (!isMatch) {
        return res.status(401).json({ message: 'Invalid username or password' });
      }

      const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '1h' });
      res.status(200).json({ message: 'Login successful', token });
    });
  });
};

exports.signup = (req, res) => {
  const { username, password, name, email, role } = req.body;

  if (!username || !password || !name || !email || !role) {
    return res.status(400).json({ message: 'Please provide all required fields' });
  }

  const query = 'SELECT * FROM user WHERE username = ? OR email = ?';
  db.query(query, [username, email], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.length > 0) {
      return res.status(409).json({ message: 'Username or email already exists' });
    }

    bcrypt.hash(password, 10, (err, hash) => {
      if (err) {
        return res.status(500).json({ message: 'Error hashing password' });
      }

      const insertQuery = 'INSERT INTO user (username, password, name, email, role) VALUES (?, ?, ?, ?, ?)';
      db.query(insertQuery, [username, hash, name, email, role], (err, results) => {
        if (err) {
          return res.status(500).json({ message: 'Database error' });
        }
        res.status(201).json({ message: 'User registered successfully' });
      });
    });
  });
};
