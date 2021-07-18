const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const jobRouter = require("./routes/job.route");
const authRouter = require("./routes/auth.route");
const BadRequestError = require("./utils/error");
const errorController = require("./controllers/error.controller");

const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/auth", authRouter);
app.use("/jobs", jobRouter);

// error middleware - unhadled route
app.use("*", (req, res, next) => {
    next(
        new BadRequestError(
            `Can't find ${req.originalUrl} on this server!`,
            404
        )
    );
});

// global error handler
app.use(errorController);

module.exports = app;
