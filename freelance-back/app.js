const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");

const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

app.get("/", (req, res) => {
    res.json({
        message: process.env,
    });
});

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

module.exports = app;
