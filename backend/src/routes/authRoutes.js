const express = require('express');
const { login, signup } = require('../controllers/authController');
const { verifyToken } = require('../middleware/authMiddleware');
const { verifyRole } = require('../middleware/roleMiddleware');
const router = express.Router();

router.post('/login', login);
router.post('/signup', signup);

// Example route that requires authentication and specific roles
router.get('/admin', verifyToken, verifyRole(['admin', 'systemadmin']), (req, res) => {
  res.status(200).json({ message: 'Welcome Admin/System Admin' });
});

module.exports = router;
