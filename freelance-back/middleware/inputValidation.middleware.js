const faker = require("faker");
const BadRequestError = require("../utils/error");

exports.checkEmptyFreelancerValidation = (req, res, next) => {
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
            return next(new BadRequestError("Address required", 400));
        } else if (!summary) {
            return next(new BadRequestError("Employer summary required", 400));
        } else if (!educationalBackground.length) {
            return next(
                new BadRequestError("Educational background required", 400)
            );
        } else if (!availableTime) {
            return next(new BadRequestError("Available time required", 400));
        } else if (!skills.length) {
            return next(new BadRequestError("Skill required", 400));
        } else if (!experiences.length) {
            return next(new BadRequestError("Experience required", 400));
        } else if (!languages.length) {
            return next(new BadRequestError("Language required"));
        }
    }

    const freelancerDetail = {
        address,
        summary,
        educationalBackground,
        imgUrl,
        legalInformation,
        availableTime,
        skills,
        experiences,
        languages,
    };

    req.body = freelancerDetail;
    next();
};

exports.checkEmptyJobValidation = (req, res, next) => {
    let {
        title,
        description,
        address,
        type,
        skillsNeeded,
        experienceLevel,
        budget,
        languages,
    } = req.body;

    // env = 'development'
    if (process.env.NODE_ENV === "development") {
        title = faker.name.jobTitle();
        description = faker.lorem.paragraph();
        address.country = faker.address.country();
        address.city = faker.address.cityName();
        budget = faker.commerce.price();

        // env = 'production'
    } else if (process.env.NODE_ENV === "production") {
        if (!title) {
            next(new BadRequestError("Title is required", 400));
        } else if (!description) {
            next(new BadRequestError("Description is required", 400));
        } else if (!address) {
            next(new BadRequestError("Address is required"));
        } else if (!skillsNeeded.length) {
            next(new BadRequestError("Needed skills are required"));
        } else if (!budget) {
            next(new BadRequestError("Budget is needed"));
        }
    }

    jobDetail = {
        title,
        description,
        address,
        type,
        skillsNeeded,
        experienceLevel,
        budget,
        languages,
    };

    req.body = jobDetail;
    next();
};
