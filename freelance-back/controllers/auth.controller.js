const jwt = require("jsonwebtoken");
const User = require("./../models/user.model");
const Role = require("./../models/role.model");
const BadRequestError = require("./../utils/error");
const catchAsync = require("./../utils/catchAsync");

exports.checkIfRoleExists = catchAsync(async (req, res, next) => {
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
    let user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        userName: req.body.userName,
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
