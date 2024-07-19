const express = require('express');
const { addEvent, updateEvent, deleteEvent, getEvents, getEventById } = require('../controllers/eventController');
const { verifyToken } = require('../middleware/authMiddleware');
const { verifyRole } = require('../middleware/roleMiddleware');
const router = express.Router();

router.post('/events',  addEvent);
router.put('/events/:id',  updateEvent);
router.delete('/events/:id',  deleteEvent);
router.get('/events',  getEvents);
router.get('/events/:id',  getEventById);

module.exports = router;
