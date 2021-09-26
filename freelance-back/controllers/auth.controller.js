const User = require("./../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Customer = require("../models/customer.model");
const Job = require("../models/job.model");
const Skill = require("../models/skill.model");
const Experience = require("../models/experience.model");
const Language = require("../models/language.model");
const Role = require("./../models/role.model");
const BadRequestError = require("./../utils/error");
const Image = require("../models/image.model");
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
    console.log(user.userType);
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

exports.getUsers = catchAsync(async (req, res, next) => {
    await User.find({})
        .populate({
            path: "customer",
            select: "-user -_id -__v",
            populate: {
                path: "jobs",
                select: "-_id -__v",
                populate: {
                    path: "skills experiences languages",
                    select: "-_id name",
                },
            },
        })
        .populate({
            path: "freelancer",
            populate: {
                path: "skills experiences languages",
                select: "name -_id",
            },
            select: "-_id -__v",
        })
        .select("-_id -__v -password")
        .exec(function (err, users) {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
            if (users) {
                res.json({
                    total: users.length,
                    users,
                });
            }
        });
});

exports.getUser = catchAsync(async (req, res, next) => {
    const user = await User.findOne({ userName: req.params.username })
        .populate("user")
        .populate({
            path: "customer freelancer user",
            select: "-user -_id -__v",
            populate: {
                path: "skills experiences jobs languages",
                select: "name -_id",
            },
        })
        .select("-_id -__v -password");
    if (!user) {
        next(new BadRequestError("User not found", 404));
    }

    let image = await Image.findOne({ _id: user.freelancer.image }).select(
        "path"
    );
    if (!image) {
        return next(new BadRequestError("Image Not Found", 404));
    }

    let img = image.path.split("/")[1];
    image.path = img;

    user.freelancer.image = image;

    res.status(200).json({
        user,
    });
});

exports.updateUserAccount = catchAsync(async (req, res, next) => {
    const { firstName, lastName, email, phoneNumber } = req.body;
    const username = req.params.username;
    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    let userName = email.split("@")[0];
    const newData = { firstName, lastName, email, phoneNumber, userName };
    await User.updateOne({ _id: user._id }, newData);
    res.status(200).json({
        status: "success",
        message: "Account Successfully Updated",
    });
});

exports.deleteUserAccount = catchAsync(async (req, res, next) => {
    const username = req.params.username;
    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "freelancer") {
        const freelancer = await Freelancer.findOne({
            _id: user.freelancer,
        });
        if (!freelancer) {
            await user.remove((err) => {
                if (err) {
                    return next(
                        new BadRequestError("Internal Server Error", 500)
                    );
                }
            });
            return res.status(200).json({
                status: "success",
                message: "Your Account Deleted Successfully",
            });
        }
        freelancer.skills.forEach(async (id) => {
            await Skill.updateOne(
                {
                    _id: id,
                },
                { $pull: { freelancers: freelancer._id } }
            );
        });
        freelancer.experiences.forEach(async (id) => {
            await Experience.updateOne(
                { _id: id },
                { $pull: { freelancers: freelancer._id } }
            );
        });
        freelancer.languages.forEach(async (id) => {
            await Language.updateOne(
                { _id: id },
                { $pull: { freelancers: freelancer._id } }
            );
        });
        // remove freelancer profile
        await freelancer.remove((err) => {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
        });
        // remove the user
        await user.remove((err) => {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
            res.status(200).json({
                status: "success",
                message: "Your Account Deleted Permanently",
            });
        });
    } else if (user.userType === "customer" || user.userType === "company") {
        const customer = await Customer.findOne({ _id: user.customer });
        if (!customer) {
            await user.remove((err) => {
                if (err) {
                    return next(
                        new BadRequestError("Internal Server Error", 500)
                    );
                }
            });
            return res.status(200).json({
                status: "success",
                message: "Your Account Deleted Successfully",
            });
        }

        customer.jobs.forEach(async (id) => {
            const job = await Job.findOne({ _id: id });
            if (!job) {
                return next(new BadRequestError("Job Not Found", 404));
            }

            job.skills.forEach(async (id) => {
                await Skill.updateOne(
                    { _id: id },
                    { $pull: { jobs: job._id } }
                );
            });
            job.experiences.forEach(async (id) => {
                await Experience.updateOne(
                    { _id: id },
                    { $pull: { jobs: job._id } }
                );
            });
            job.languages.forEach(async (id) => {
                await Language.updateOne(
                    { _id: id },
                    { $pull: { jobs: job._id } }
                );
            });

            // remove each job
            await job.remove((err) => {
                if (err) {
                    return next(
                        new BadRequestError("Internal Server Error", 500)
                    );
                }
            });
        });

        // remove customer profile
        await customer.remove((err) => {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
        });

        // remove the user then
        await user.remove((err) => {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
        });

        res.status(200).json({
            status: "success",
            message: "Your Account Deleted Successfully",
        });
    }
});
