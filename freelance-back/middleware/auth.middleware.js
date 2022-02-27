const jwt = require("jsonwebtoken");
const User = require("./../models/user.model");
const Role = require("./../models/role.model");
const BadRequestError = require("./../utils/error");
const catchAsync = require("./../utils/catchAsync");

exports.verifyToken = async (req, res, next) => {
    let token = req.headers["x-access-token"];
    if (!token) {
        return next(new BadRequestError("No Token Provided", 400));
    }
    await jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            return next(new BadRequestError("Unauthorized", 403));
        }
        req.userId = decoded.id;
    });

    next();
};

exports.allowAdminOrSuperAdmin = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.userId);
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }

    const roles = await Role.find({ _id: { $in: user.roles } });
    if (!roles.length) {
        return next(new BadRequestError("Roles Not Found"));
    }

    for (let i = 0; i < roles.length; i++) {
        if (roles[i].name === "admin" || roles[i].name === "super-admin") {
            return next();
        }
    }
    return next(new BadRequestError("Unauthorized action", 403));
});

exports.isFreelancer = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.userId);
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "freelancer") {
        next();
    }
    return next(new BadRequestError("Unauthorized action", 403));
});

exports.isCustomerOrClient = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.userId);
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "customer" || user.userType === "client") {
        next();
    }
    return next(new BadRequestError("Unauthorized action", 403));
});
