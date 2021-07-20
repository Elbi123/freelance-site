const BadRequestError = require("./../utils/error");

const handleCastErrorDB = (err) => {
    const message = `Invalid ${err.path}: ${err.value}`;
    return new BadRequestError(message, 400);
};

const handleValidationError = (err) => {
    const errors = Object.values(err.errors).map((el) => el.message);

    const message = `Invalid input data. ${errors.join(". ")}`;
    return new BadRequestError(message, 400);
};

// error: development
const sendErrorDev = (err, res) => {
    res.status(err.statusCode).json({
        status: err.status,
        error: err,
        message: err.message,
        stack: err.stack,
    });
};

// error: production
const sendErrorProd = (err, res) => {
    // Operational, trusted errors goes here
    if (err.isOperational) {
        res.status(err.statusCode).json({
            status: err.status,
            message: err.message,
        });

        // Programming, third party error goes here
        // [don't leak error]
    } else {
        res.status(500).json({
            status: "error",
            message: "Something went very wrong",
        });
    }
};

module.exports = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    err.status = err.status || "error";

    if (process.env.NODE_ENV === "development") {
        sendErrorDev(err, res);
    } else if (process.env.NODE_ENV === "production") {
        let error = { ...err };

        // handle mongoose cast error
        if (err.name === "CastError") error = handleCastErrorDB(err);

        // handle validator error
        if (err.name === "ValidationError") error = handleValidationError(err);

        // handle duplicate key error
        // if (err.code === 11000) error = handleDuplicateErrorDB(err);
        sendErrorProd(error, res);
    }
};
