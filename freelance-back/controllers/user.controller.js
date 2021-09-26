const User = require("./../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Customer = require("../models/customer.model");
const Role = require("../models/role.model");
const Job = require("../models/job.model");
const Skill = require("../models/skill.model");
const Experience = require("../models/experience.model");
const Language = require("../models/language.model");
const Image = require("../models/image.model");
const BadRequestError = require("./../utils/error");
const catchAsync = require("./../utils/catchAsync");

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

exports.assignRole = catchAsync(async (req, res, next) => {
    // only the admins shown here
    const { emailOrUsername, role } = req.body;

    // find by email or username
    const existingRole = await Role.findOne({ name: role });
    const user = await User.findOne({
        email: emailOrUsername,
    });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (!role) {
        return next(new BadRequestError("Role Not Found", 404));
    }

    if (user.roles.includes(existingRole._id)) {
        res.status(302).json({
            message: "Role already existed",
        });
    } else {
        await User.updateOne(
            { _id: user._id },
            { $push: { roles: existingRole._id } }
        );
        res.status(200).json({
            status: "success",
            message: "Role assigned successfully",
        });
    }
});

exports.removeRole = catchAsync(async (req, res, next) => {
    const { emailOrUsername, role } = req.body;

    // find by email or username
    const existingRole = await Role.findOne({ name: role });
    const user = await User.findOne({
        email: emailOrUsername,
    });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (!role) {
        return next(new BadRequestError("Role Not Found", 404));
    }

    if (user.roles.includes(existingRole._id)) {
        await User.updateOne(
            { _id: user._id },
            { $pull: { roles: existingRole._id } }
        );
        res.status(200).json({
            status: "success",
            message: "Role removed successfully",
        });
    } else {
        res.status(302).json({
            message: "Role provided not found for this user",
        });
    }
});
