const faker = require("faker");
const User = require("../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Skill = require("../models/skill.model");
const Experience = require("../models/experience.model");
const Language = require("../models/language.model");
const catchAsync = require("../utils/catchAsync");
const helpQuery = require("../utils/helpQuery");
const BadRequestHandler = require("../utils/error");

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

exports.createFreelancer = catchAsync(async (req, res, next) => {
    const username = req.params.username;
    let {
        address,
        summary,
        educationalBackground,
        imgUrl,
        legalInformation,
        availableTime,
        skills,
        experiences,
        languages,
    } = req.body;
    if (process.env.NODE_ENV === "development") {
        if (!address.country || !address.city || !summary) {
            address.country = faker.address.country();
            address.city = faker.address.cityName();
            summary = faker.lorem.paragraph();
        }
    } else if (process.env.NODE_ENV === "production") {
        if (!address.country || !address.city) {
            return next(new BadRequestHandler("Address required", 400));
        } else if (!summary) {
            return next(
                new BadRequestHandler("Employer summary required", 400)
            );
        } else if (!educationalBackground.length) {
            return next(
                new BadRequestHandler("Educational background required", 400)
            );
        } else if (!availableTime) {
            return next(new BadRequestHandler("Available time required", 400));
        } else if (!skills.length) {
            return next(new BadRequestHandler("Skill required", 400));
        } else if (!experiences.length) {
            return next(new BadRequestHandler("Experience required", 400));
        } else if (!languages.length) {
            return next(new BadRequestHandler("Language required"));
        }
    }

    const user = await User.findOne({ userName: username });

    // check if the user exists using the username
    if (!user) {
        return next(new BadRequestHandler("User Not Found", 404));
    }

    // check the user type
    if (user.userType === "freelancer") {
        let freelancer = new Freelancer({
            address,
            summary,
            imgUrl,
            educationalBackground,
            legalInformation,
            availableTime,
        });

        // check if the user has freelancer detail
        if (user.freelancer) {
            return next(
                new BadRequestHandler("Freelancer Already Existed", 400)
            );
        }

        // maintain 1 - 1 Relationship
        await User.updateOne(
            { userName: username },
            { $set: { freelancer: freelancer._id } }
        );
        freelancer.user = user._id;

        const skillIds = await helpQuery(
            skills,
            Skill,
            freelancer,
            "freelancer"
        );

        const experienceIds = await helpQuery(
            experiences,
            Experience,
            freelancer,
            "freelancer"
        );

        const languageIds = await helpQuery(
            languages,
            Language,
            freelancer,
            "freelancer"
        );

        // freelancer - skills
        freelancer.skills = skillIds;

        // freelancer - experiences
        freelancer.experiences = experienceIds;

        // freelancer - languages
        freelancer.languages = languageIds;

        // save freelancer
        await freelancer.save();

        res.status(200).json({
            status: "sucess",
            freelancer,
        });
    }
});

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
