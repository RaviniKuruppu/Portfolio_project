const express = require('express');
const bodyParser = require('body-parser');
const db = require('./src/database/db');
const authRoutes = require('./src/routes/authRoutes');
const categoryRoutes = require('./src/routes/categoryRoutes');
const eventRoutes = require('./src/routes/eventRoutes');
const registrationRoutes = require('./src/routes/registrationRoutes');
const cors = require('cors');


const app = express();
app.use(cors());

app.use(bodyParser.json());


app.use('/api/auth', authRoutes); // this route is for login and signup
app.use('/api', categoryRoutes); // this route is for event categories
app.use('/api', eventRoutes);
app.use('/api', registrationRoutes); // this route is for event resigration- users regitering to events

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
