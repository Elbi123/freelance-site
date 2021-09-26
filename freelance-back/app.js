const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const cors = require("cors");
const helmet = require("helmet");
const rateLimit = require("express-rate-limit");
const mongoSanitize = require("express-mongo-sanitize");
const hpp = require("hpp");
const xss = require("xss-clean");
const userRouter = require("./routes/user.route");
const jobRouter = require("./routes/job.route");
const authRouter = require("./routes/auth.route");
const customerRouter = require("./routes/customer.route");
const freelancerRouter = require("./routes/freelancer.route");
const proposalRouter = require("./routes/proposal.route");
const BadRequestError = require("./utils/error");
const errorController = require("./controllers/error.controller");

const app = express();

// Adds some http headers for security purpose
app.use(helmet());

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

const limiter = rateLimit({
    max: 5,
    windowMs: 60 * 60 * 1000,
    message: "Too many requests from this IP, please try again in an hour!",
});

const limiter2 = rateLimit({
    max: 100,
    windowMs: 60 * 60 * 1000,
    message: "Too many requests from this IP, please try again in an hour!",
});

// app.use("/auth", limiter);

app.use(cors());
app.use("*", cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Data sanitization against data NoSQL query injections
app.use(mongoSanitize());
// Data sanitization agains XSS
app.use(xss());

// Prevent http parameter pollution
app.use(hpp()); // can be used with whitelisting some paramenter in the options

app.use(express.static(`${__dirname}/public`));

app.use("/users", userRouter);
app.use("/", freelancerRouter);
app.use("/auth", limiter, authRouter);
app.use("/jobs", limiter2, jobRouter);
app.use("/customers", jobRouter);
app.use("/potential", customerRouter);
app.use("/potential", freelancerRouter);
app.use("/", proposalRouter);

app.get("/", (req, res) => {
    res.status(200).json({
        status: "success",
        message: "HOME PAGE",
    });
});

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
