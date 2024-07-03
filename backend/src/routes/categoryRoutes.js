const express = require('express');
const { addCategory, updateCategory, deleteCategoryById, deleteCategoryByTitle, getCategories } = require('../controllers/categoryController');
const { verifyToken } = require('../middleware/authMiddleware');
const { verifyRole } = require('../middleware/roleMiddleware');
const router = express.Router();

router.post('/categories',  addCategory);
router.put('/categories/:id', updateCategory);
router.delete('/categories/:id', deleteCategoryById);
router.delete('/categories/title/:title',  deleteCategoryByTitle);
router.get('/categories',getCategories);

module.exports = router;
