const crypto = require("crypto");
const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const BadRequestError = require("../utils/error");

const userSchema = new mongoose.Schema(
    {
        firstName: {
            type: String,
            required: [true, "First name is required"],
        },
        lastName: {
            type: String,
            required: [true, "Last name is required"],
            validate: {
                validator: function (el) {
                    return el !== this.firstName;
                },
                message: "First Name has to be different from Last Name",
            },
        },
        companyName: {
            type: String,
            required: [true, "Company name is required"],
        },
        companyPhone: {
            type: String,
            required: [true, "Phone Number required"],
        },
        email: {
            type: String,
            required: [true, "Email is required"],
            unique: true,
            lowercase: true,
            validate: [validator.isEmail, "Please provide a valid email"],
        },
        userName: {
            type: String,
        },
        phoneNumber: {
            type: String,
            required: [true, "Phone is required"],
            unique: true,
            validate: [validator.isMobilePhone],
        },
        userType: {
            type: String,
            enum: {
                values: ["customer", "company", "freelancer", "user"],
                message: "{VALUE} is not supported",
            },
            default: "user",
        },
        password: {
            type: String,
            required: [true, "Please provide a password"],
            minLength: 8,
            // helps to not leak the password when retrieving
            select: false,
        },
        passwordConfirm: {
            type: String,
            validate: {
                // This only works on CREATE and SAVE
                validator: function (el) {
                    return el === this.password;
                },
                message: "Password doesn't match",
            },
        },
        passwordResetToken: String,
        passwordResetExpires: Date,
        roles: [{ type: mongoose.Schema.Types.ObjectId, ref: "Role" }],
        customer: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Customer",
        },
        freelancer: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Freelancer",
        },
    },
    { timestamps: true }
);

userSchema.pre("save", function (next) {
    if (this.userType === "freelancer" || this.userType === "user") {
        this.customer = undefined;
        this.companyName = undefined;
        this.companyPhone = undefined;
    } else if (this.userType === "customer" || this.userType === "user") {
        this.freelancer = undefined;
        this.companyName = undefined;
        this.companyPhone = undefined;
        // this.userType === 'user'
    } else if (this.userType === "company") {
        this.freelancer = undefined;
        this.firstName = undefined;
        this.lastName = undefined;
        this.phoneNumber = undefined;
    }

    next();
});

userSchema.pre("save", async function (next) {
    if (!this.isModified("password")) return next();

    this.password = await bcrypt.hash(this.password, 12);

    this.passwordConfirm = undefined;

    next();
});

// userSchema.pre("save", async function (next) {
//     if (this.userName) {
//         await this.constructor.findOne(
//             { userName: this.userName },
//             function (err, user) {
//                 if (user) {
//                     next(
//                         new BadRequestError("Username has already been taken")
//                     );
//                 }
//             }
//         );
//     } else {
//         this.userName = this.email.split("@")[0];
//     }
//     next();
// });

// use instance method to work with comparing password using bcrypt
userSchema.methods.correctPassword = async function (
    candidatePassword,
    userPassword
) {
    return await bcrypt.compare(candidatePassword, userPassword);
};

userSchema.methods.createPasswordResetToken = function () {
    // 1- generate plain token
    const resetToken = crypto.randomBytes(32).toString("hex");

    // 2- hash the generated token
    this.passwordResetToken = crypto
        .createHash("sha256")
        .update(resetToken)
        .digest("hex");

    console.log({ resetToken }, this.passwordResetToken);
    this.passwordResetExpires = Date.now() + 10 * 60 * 1000;

    return resetToken;
};

// userSchema.pre("save", async function (next) {
//     await this.constructor.findOne({ email: this.email }, function (err, user) {
//         if (user) {
//             next(new BadRequestError("Email has already been taken"));
//         }
//     });
//     next();
// });

const User = mongoose.model("User", userSchema);

module.exports = User;
