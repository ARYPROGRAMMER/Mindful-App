const express = require('express');
const meditationRoutes = require('./adapters/routes/meditationRoutes');
const songRoutes = require('./adapters/routes/songRoutes');

const app = express();
const port = process.env.PORT || 6000;

app.use('/meditation', meditationRoutes);
app.use('/songs', songRoutes);

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
    }
);

