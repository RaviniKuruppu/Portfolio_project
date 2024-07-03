const db = require('../database/db');
const Category = require('../models/categoryModel');

// Add Category
exports.addCategory = (req, res) => {
  const { title, color } = req.body;
  if (!title) {
    return res.status(400).json({ message: 'Title is required' });
  }

  const query = 'INSERT INTO categories (title, color) VALUES (?, ?)';
  db.query(query, [title, color || 'orange'], (err, results) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(409).json({ message: 'Title must be unique' });
      }
      return res.status(500).json({ message: 'Database error' });
    }
    res.status(201).json({ message: 'Category added successfully', categoryId: results.insertId });
  });
};

// Update Category
exports.updateCategory = (req, res) => {
  const { id } = req.params;
  const { title, color } = req.body;

  if (!title) {
    return res.status(400).json({ message: 'Title is required' });
  }

  const query = 'UPDATE categories SET title = ?, color = ? WHERE id = ?';
  db.query(query, [title, color || 'orange', id], (err, results) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(409).json({ message: 'Title must be unique' });
      }
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Category not found' });
    }
    res.status(200).json({ message: 'Category updated successfully' });
  });
};

// Delete Category by ID
exports.deleteCategoryById = (req, res) => {
  const { id } = req.params;

  const query = 'DELETE FROM categories WHERE id = ?';
  db.query(query, [id], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Category not found' });
    }
    res.status(200).json({ message: 'Category deleted successfully' });
  });
};

// Delete Category by Title
exports.deleteCategoryByTitle = (req, res) => {
  const { title } = req.params;

  const query = 'DELETE FROM categories WHERE title = ?';
  db.query(query, [title], (err, results) => {
    if (err) {
      return res.status(500).json({ message: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Category not found' });
    }
    res.status(200).json({ message: 'Category deleted successfully' });
  });
};

// Get List of Categories
exports.getCategories = (req, res) => {
    const query = 'SELECT * FROM categories';
    db.query(query, (err, results) => {
      if (err) {
        return res.status(500).json({ message: 'Database error' });
      }
      res.status(200).json(results);
    });
  };