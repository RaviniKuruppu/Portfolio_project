const express = require('express');
const { addRegistration, updateRegistration, deleteRegistration, getRegistrations, getRegistrationById } = require('../controllers/registrationController');
const { verifyToken } = require('../middleware/authMiddleware');
const { verifyRole } = require('../middleware/roleMiddleware');
const router = express.Router();

router.post('/registrations',addRegistration);
router.put('/registrations/:id',updateRegistration);
router.delete('/registrations/:id',  deleteRegistration);
router.get('/registrations', getRegistrations);
router.get('/registrations/:id', getRegistrationById);

module.exports = router;
