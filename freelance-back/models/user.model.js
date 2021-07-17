const mongoose = require("mongoose");
const validator = require("validator");

const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: [true, "First name is required"],
    },
    lastName: {
        type: String,
        required: [true, "First name is required"],
    },
    userName: {
        type: String,
        required: [true, "Username is required"],
    },
    email: {
        type: String,
        require: [true, "Email is required"],
        unique: true,
        lowercase: true,
        validate: [validator.isEmail, "Please provide a valid email"],
    },
    img: {
        type: String,
    },
    password: {
        type: String,
        required: [true, "Please provide a password"],
        minLength: 8,
    },
    passwordConfirm: {
        type: String,
        required: [true, "Please confirm your password"],
    },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
