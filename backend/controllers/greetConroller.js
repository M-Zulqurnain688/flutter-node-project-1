// controllers/greetController.js

exports.getHello = (req, res) => {
  res.json({
    message: 'Hello from Node.js backend 🚀'
  });
};

exports.postGreet = (req, res) => {
  try {
    const { name } = req.body;

    // if (!name) {
    //   return res.status(400).json({ error: 'Name is required' });
    // }

    res.json({
      message: `Hello ${name}, welcome from backend 🎉`
    });
  } catch (error) {
    error.statusCode = 500;
    throw error
  }
};
