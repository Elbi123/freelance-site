const User = require("../models/user.model");
const catchAsync = require("../utils/catchAsync");

exports.getAllFreelancer = catchAsync(async (req, res) => {
    const users = await User.find({ userType: "freelancer" });
    res.status(200).json({
        users,
    });
});

exports.getSingleFreelancerDetail = (req, res) => {
    res.status(200).json({
        status: "sucess",
        message: "GET SINGLE FREELANCER",
    });
};

exports.createFreelancer = (req, res) => {
    res.status(200).json({
        status: "sucess",
        message: "CREATE FREELANCER DETAIL",
    });
};

exports.updateFreelancerDetail = (req, res) => {
    res.status(200).json({
        status: "sucess",
        message: "UPDATE FREELANCER DETAIL",
    });
};

exports.deleteFreelancerDetail = (req, res) => {
    res.status(200).json({
        status: "sucess",
        message: "DELETE FREELANCER DETAIL",
    });
};
