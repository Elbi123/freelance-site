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
        req.body.roles = ["user"];
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
    if (user.userType === "customer" || user.userType === "freelancer") {
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

exports.signup = catchAsync(async (req, res) => {
    let body = { ...req.body };
    delete body.roles;

    const userRoles = req.body.roles;

    let newUser = new User(body);

    await Role.find({ name: { $in: userRoles } }, async (err, roles) => {
        if (err) {
            res.json({
                res,
            });
        }
        newUser.roles = roles.map((role) => role._id);
    });

    await newUser.save().then((user) => {
        res.json({
            user,
        });
    });
});

exports.getUsers = catchAsync(async (req, res, next) => {
    await User.find({})
        .populate({
            path: "customer freelancer",
            populate: {
                path: "jobs skills experiences languages",
                select: "-_id -__v -user -customer",
                populate: {
                    path: "skills experiences languages",
                    select: "name -_id",
                },
            },
        })
        .select("-_id -__v")
        .exec(function (err, users) {
            if (err) {
                return next(new BadRequestError("Unknown error", 500));
            }
            if (users) {
                res.json({
                    total: users.length,
                    message: users,
                });
            }
        });
});

exports.getUser = catchAsync(async (req, res, next) => {
    const user = await User.findOne({ _id: req.params.id });
    if (!user) {
        next(new BadRequestError("User not found", 404));
    }
    res.status(200).json({
        user,
    });
});
