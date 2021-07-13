const mongoose = require("mongoose");
const dotenv = require("dotenv");

dotenv.config();

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
            console.log(err);
        }
        // db.on("error", console.error.bind(console, "connection error"));
    }
};

module.exports = connectDB;
