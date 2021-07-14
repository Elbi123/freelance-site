const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const jobRouter = require("./routes/job.route");

const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/jobs", jobRouter);

module.exports = app;
