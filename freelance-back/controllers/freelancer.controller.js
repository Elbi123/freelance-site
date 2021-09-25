const faker = require("faker");
const ObjectId = require("mongoose").Types.ObjectId;
const User = require("../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Skill = require("../models/skill.model");
const Experience = require("../models/experience.model");
const Language = require("../models/language.model");
const catchAsync = require("../utils/catchAsync");
const helpQuery = require("../utils/helpQuery");
const helpUpdate = require("../utils/helpUpdate");
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
            return next(new BadRequestHandler("Profile Already Existed", 400));
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
            message: "Profile Created Successfully",
        });
    }
});

exports.updateFreelancerDetail = catchAsync(async (req, res, next) => {
    // accept the updating data and params
    let {
        address,
        summary,
        educationalBackground,
        legalInformation,
        availableTime,
        skills,
        experiences,
        languages,
    } = { ...req.body };
    const { username, id } = req.params;

    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestHandler("User Not Found", 404));
    }
    if (!user.freelancer) {
        return next(new BadRequestHandler("No Profile Found", 404));
    }
    const profile = await Freelancer.findOne({ _id: user.freelancer });

    const idSkills = await helpUpdate(
        skills,
        Skill,
        profile,
        "skills",
        "freelancer"
    );

    const idExperiences = await helpUpdate(
        experiences,
        Experience,
        profile,
        "experiences",
        "freelancer"
    );

    const idLanguages = await helpUpdate(
        languages,
        Language,
        profile,
        "languages",
        "freelancer"
    );

    const mappedToSkills = idSkills.map((el) => {
        return ObjectId(el);
    });

    const mappedToExperiences = idExperiences.map((el) => {
        return ObjectId(el);
    });

    const mappedToLangauges = idLanguages.map((el) => {
        return ObjectId(el);
    });

    const filter = { _id: user.freelancer };
    const updated = {
        address,
        summary,
        educationalBackground,
        legalInformation,
        availableTime,
        skills: mappedToSkills,
        experiences: mappedToExperiences,
        languages: mappedToLangauges,
    };

    // work on updating the values
    await Freelancer.findOneAndUpdate(filter, updated, {
        new: true,
    });

    res.status(200).json({
        status: "sucess",
        message: "Profile Updated Successfully",
    });
});

exports.updatedImage = (req, res, next) => {
    res.status(200).json({
        status: "success",
        message: "IMAGE UPDATE IS WORKING",
    });
};

exports.deleteFreelancerDetail = catchAsync(async (req, res, next) => {
    const { username } = req.params;
    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestHandler("User Not Found", 404));
    }
    if (!user.freelancer) {
        return next(new BadRequestHandler("No Profile Found", 404));
    }

    if (user.userType === "freelancer") {
        // update the skills, experiences, languages to remove the respective user profile
        const profile = await Freelancer.findOne({ _id: user.freelancer });

        // update skills
        profile.skills.forEach(async (skill) => {
            await Skill.updateOne(
                { _id: skill._id },
                {
                    $pull: { freelancers: profile._id },
                }
            );
        });

        // update experiences
        profile.experiences.forEach(async (experience) => {
            await Experience.updateOne(
                { _id: experience._id },
                {
                    $pull: { freelancers: profile._id },
                }
            );
        });

        // update languages
        profile.languages.forEach(async (language) => {
            await Language.updateOne(
                { _id: language._id },
                {
                    $pull: { freelancers: profile._id },
                }
            );
        });

        // update for user.userType === 'freelancer', the freelancer
        await User.updateOne({ _id: user._id }, { $unset: { freelancer: "" } });

        // remove the profile
        await profile.remove((err) => {
            if (err) {
                return next(
                    new BadRequestHandler("Internal Server Error"),
                    500
                );
            }
            res.status(200).json({
                status: "success",
                message: "Profile Deleted Successfully",
            });
        });
    }
});
