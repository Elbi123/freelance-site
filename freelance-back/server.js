const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const dotenv = require("dotenv");
const morgan = require("morgan");

dotenv.config();

const app = express();

if (process.env.NODE_ENV === "development") {
    app.use(morgan("dev"));
}

const dbString = process.env.DB_CONNECTION_STRING.replace(
    "<password>",
    process.env.DB_PASSWORD
);
const db = mongoose.connection;
const connectDB = async () => {
    try {
        await mongoose.connect(dbString, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useFindAndModify: false,
            useCreateIndex: true,
        });
        if (process.env.NODE_ENV === "development") {
            console.log(`Mongodb connected successfully from ${db.host}`);
        }
    } catch (err) {
        if (process.env.NODE_ENV === "development") {
            console.log("connection error");
        }
        // db.on("error", console.error.bind(console, "connection error"));
    }
};

connectDB();

app.get("/", (req, res) => {
    res.json({
        message: process.env,
    });
});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = process.env.PORT || 8000;

app.listen(port, () => {
    if (process.env.NODE_ENV === "development") {
        console.log(`App is listening on port ${port}`);
    }
});
