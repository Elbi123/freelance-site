const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const User = require("./../models/user.model");
const Role = require("./../models/role.model");
const BadRequestError = require("./../utils/error");
const catchAsync = require("./../utils/catchAsync");
const sendEmail = require("../utils/handlePasswordResetEmail");

exports.checkIfRoleExists = catchAsync(async (req, res, next) => {
    let username = req.body.userName;
    if (req.body.roles) {
        for (let i = 0; i < req.body.roles.length; i++) {
            const role = await Role.findOne({ name: req.body.roles[i] });
            if (!role) {
                next(
                    new BadRequestError(
                        `Role ${req.body.roles[i]} doesn't exist`,
                        404
                    )
                );
            }
        }
    } else {
        req.body.roles = ["user", req.body.userType];
    }
    if (username) {
        const user = await User.findOne({ userName: req.body.userName });
        if (user) {
            return next(new BadRequestError("Username has been taken", 401));
        }
    } else {
        username = req.body.email.split("@")[0];
    }
    let user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        userName: username,
        userType: req.body.userType,
        companyName: req.body.companyName,
        companyPhone: req.body.companyPhone,
        email: req.body.email,
        password: req.body.password,
        passwordConfirm: req.body.passwordConfirm,
        phoneNumber: req.body.phoneNumber,
        userType: req.body.userType,
        img: req.body.img,
        roles: req.body.roles,
    };
    if (
        user.userType === "customer" ||
        user.userType === "freelancer" ||
        user.userType === "user"
    ) {
        user.companyName = "company-name";
        user.companyPhone = "0909090909";
    } else if (user.userType === "company") {
        user.firstName = "None";
        user.lastName = "None 2";
        user.phoneNumber = "0909090909";
    }
    req.body = user;
    next();
});

// generate token
const signToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN,
    });
};

// user signup
exports.signup = catchAsync(async (req, res, next) => {
    let body = { ...req.body };
    delete body.roles;

    const userRoles = req.body.roles;

    let newUser = new User(body);

    await Role.find({ name: { $in: userRoles } }, async (err, roles) => {
        if (err) {
            return next(new BadRequestError("Internal Server Error", 500));
        }
        newUser.roles = roles.map((role) => role._id);
    });

    await newUser.save().then((user) => {
        res.json({
            user,
        });
    });
});

// login users
exports.login = catchAsync(async (req, res, next) => {
    // 1- accept the credentials
    const { emailOrUsername, password } = req.body;

    // 2- check if empty
    if (!emailOrUsername || !password) {
        return next(
            new BadRequestError("Please provide email and password", 400)
        );
    }

    // 3- check if user exists and if password is correct
    const user = await User.findOne({
        $or: [{ email: emailOrUsername }, { userName: emailOrUsername }],
    }).select("+password");

    if (!user || !(await user.correctPassword(password, user.password))) {
        if (emailOrUsername.includes("@")) {
            return next(
                new BadRequestError("Incorrect email or password", 401)
            );
        } else {
            return next(
                new BadRequestError("Incorrect username or password", 401)
            );
        }
    }

    // 4- generate token
    const token = signToken(user._id);

    res.status(200).json({
        status: "success",
        token,
    });
});

exports.forgotPassword = catchAsync(async (req, res, next) => {
    const { email } = req.body;
    if (!email) {
        return next(new BadRequestError("Please provide email", 400));
    }
    // 1- Get user based on POST email
    const user = await User.findOne({ email });
    if (!user) {
        return next(new BadRequestError("No user with that email", 404));
    }

    // 2- Generate random reset token
    const resetToken = user.createPasswordResetToken();

    await user.save({ validateBeforeSave: false });

    // 3- Sent the token via email to user
    const resetUrl = `${req.protocol}://${req.get(
        "host"
    )}/auth/reset-password/${resetToken}`;

    const message = `Forgot your password? Follow ${resetUrl} this link to reset your password.\n If you didn't forget your password, please ignore this email`;

    const emailDetails = {
        email: user.email,
        subject: "Password Reset Notification[VALID FOR 10 MINUTES]",
        text: message,
    };

    try {
        await sendEmail.sendPasswordResetEmail(emailDetails);
    } catch (err) {
        user.passwordResetToken = undefined;
        user.passwordResetToken = undefined;
        await user.save({ validateBeforeSave: false });

        return next(
            new BadRequestError(
                "There was an error sending the email. Try again later",
                500
            )
        );
    }

    res.status(200).json({
        status: "success",
        messsag: "Password reset email has been sent",
    });
});

exports.resetPassword = catchAsync(async (req, res, next) => {
    const password = req.body.password;
    const passwordConfirm = req.body.passwordConfirm;
    if (!password || !passwordConfirm) {
        return next(new BadRequestError("Please fill the fields", 400));
    }
    if (password !== passwordConfirm) {
        return next(new BadRequestError("Password should match", 400));
    }
    // 1- get user based on token
    const hashedToken = crypto
        .createHash("sha256")
        .update(req.params.token)
        .digest("hex");
    const user = await User.findOne({
        passwordResetToken: hashedToken,
        passwordResetToken: { $gt: Date.now() },
    });
    // 2- if the token has not expired and if there is user, set the new password
    if (!user) {
        return next(
            new BadRequestError("Token is invalid or has expired", 400)
        );
    }

    user.password = password;
    user.passwordConfirm = passwordConfirm;

    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;

    await user.save({ validateBeforeSave: false });
    // 3- update changePassswordAt property for the user
    // 4- log the user in, send JWT
    const token = signToken(user._id);

    res.status(200).json({
        status: "success",
        token,
    });
});
