const express = require('express');
const bodyParser = require('body-parser');
const db = require('./src/database/db');
const authRoutes = require('./src/routes/authRoutes');
const categoryRoutes = require('./src/routes/categoryRoutes');
const eventRoutes = require('./src/routes/eventRoutes');
const cors = require('cors');


const app = express();
app.use(cors());

app.use(bodyParser.json());


app.use('/api/auth', authRoutes);
app.use('/api', categoryRoutes);
app.use('/api', eventRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
