// const express = require('express');
// const cors = require('cors');
// const app = express();

// app.use(cors());
// app.use(express.json());

// app.get('/hello', (req, res) => {
//     res.json({
//         message: 'Hello from Node.js backend 🚀'
//     });
// });

// app.post('/greet', (req, res) => {
//     const { name } = req.body;

//     if (!name) {
//         return res.status(400).json({
//             error: 'Name is required'
//         });
//     }

//     res.json({
//         message: `Hello ${name}, welcome from Node.js backend 🚀`
//     });
// });

// const PORT = 3000;
// app.listen(PORT, () => {
//     console.log(`Server running on port ${PORT}`);
// });

const express = require('express');
const cors = require('cors');
require('dotenv').config();
const greetRoutes = require('./routes/greetRoutes');
const errorHandler = require('./middlewares/errorMiddleware');
const logger = require('./middlewares/loggerMiddleware');

const app = express();


app.use(cors());
app.use(express.json());

app.use(logger);

// Use routes
app.use('/', greetRoutes);

app.use(errorHandler);

const PORT = process.env.PORT;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
