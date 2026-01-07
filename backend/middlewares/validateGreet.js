const validateGreet = (req, res, next) => {
    const { name } = req.body;

    if(!name || name.trim() === '') {
        return res.status(400).json({
            error: 'Name is required and cannot be empty',
        });
    }

    next();
};

module.exports = validateGreet;