const mongoose = require("mongoose");
const dotenv = require("dotenv");

const Role = require("./../models/role.model");

dotenv.config();

const dbLocal = process.env.DB_LOCAL;
const dbRemote = process.env.DB_CONNECTION_STRING.replace(
    "<password>",
    process.env.DB_PASSWORD
);

const db = mongoose.connection;
const connectDB = async () => {
    try {
        await mongoose.connect(dbRemote, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useFindAndModify: false,
            useCreateIndex: true,
        });

        // init function
        entry();

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

function entry() {
    Role.estimatedDocumentCount((err, count) => {
        if (!err && count == 0) {
            new Role({
                name: "user",
            }).save((err) => {
                if (err) {
                    throw new Error(err);
                }
            });

            new Role({
                name: "client",
            }).save((err) => {
                if (err) {
                    throw new Error(err);
                }
            });

            new Role({
                name: "freelancer",
            }).save((err) => {
                if (err) {
                    throw new Error(err);
                }
            });

            new Role({
                name: "admin",
            }).save((err) => {
                if (err) {
                    throw new Error(err);
                }
            });

            new Role({
                name: "super-admin",
            }).save((err) => {
                if (err) {
                    throw new Error(err);
                }
            });
        }
    });
}

module.exports = connectDB;
