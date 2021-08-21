const faker = require("faker");
const ObjectId = require("mongoose").Types.ObjectId;
const Job = require("../models/job.model");
const User = require("../models/user.model");
const Customer = require("../models/customer.model");
const Skill = require("../models/skill.model");
const Experience = require("../models/experience.model");
const Language = require("../models/language.model");
const catchAsync = require("./../utils/catchAsync");
const BadRequestError = require("./../utils/error");
const helpQuery = require("../utils/helpQuery");
const helpUpdate = require("../utils/helpUpdate");

exports.getAllJobs = catchAsync(async (req, res, next) => {
    const queryObj = { ...req.query };
    const excludedFields = ["page", "sort", "limit", "fields"];
    excludedFields.forEach((el) => delete queryObj[el]);
    let queryString = JSON.stringify(queryObj);

    // ADVANCED FITERING[SHOULD BE ADDED MORE]
    queryString = queryString.replace(
        /\b(gte|gt|lte|lt)\b/g,
        (match) => `$${match}`
    );

    let query = Job.find(JSON.parse(queryString))
        .populate(
            "customer",
            "-skills -isPaymentVerified -experiences -languages -jobs -legalInformation -user -createAt -_id -__v -updatedAt "
        )
        .populate({ path: "skills experiences languages", select: "name -_id" })
        .select("-_id -__v -updatedAt");

    // SORTING GOES HERE
    if (req.query.sort) {
        let sortBy = req.query.sort.split(",").join(" ");
        query = query.sort(sortBy);
    } else {
        query = query.sort("-createdAt");
    }

    // PAGINATION
    const page = req.query.page * 1 || 1;
    const limit = req.query.limit * 1 || 50;
    const skip = (page - 1) * limit;

    query = query.skip(skip).limit(limit);

    if (req.query.page) {
        const numberOfJobs = await Job.countDocuments();
        if (skip >= numberOfJobs)
            next(new BadRequestError("Page doesn't exist", 404));
    }

    const jobs = await query;

    res.status(200).json({
        total: jobs.length,
        jobs,
    });
});

exports.getJobBySlug = catchAsync(async (req, res, next) => {
    const slug = req.params.slug;
    await Job.findOne({ slug })
        .populate({ path: "skills experiences languages", select: "name -_id" })
        .select("-__v")
        // populate: { path: "skills experiences" },
        .exec(function (err, job) {
            if (err) {
                return next(new BadRequestError("Internal Server Error", 500));
            }
            if (!job) {
                return next(new BadRequestError("Job Not Found0", 404));
            }
            res.status(200).json({
                job,
            });
        });
});

exports.createJob = catchAsync(async (req, res, next) => {
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
    let { userName } = req.params;

    const user = await User.findOne({ userName: userName });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    } else {
        if (user.userType === "customer") {
            const customer_id = user.customer;
            const customer = await Customer.findOne({ _id: customer_id });
            if (!customer) {
                return next(new BadRequestError("Customer Not Found", 404));
            }

            let constructJob = {
                title,
                description,
                address,
                type,
                budget,
            };

            // create job here
            const job = new Job(constructJob);

            // helps querying
            const idSkillsNeeded = await helpQuery(
                skillsNeeded,
                Skill,
                job,
                "job"
            );
            const idExperiences = await helpQuery(
                experienceLevel,
                Experience,
                job,
                "job"
            );
            const idLanguages = await helpQuery(
                languages,
                Language,
                job,
                "job"
            );

            // maintain 1-M
            customer.jobs.push(job._id);

            // maintain 1-1
            job.customer = customer._id;

            // add skills to job
            job.skills = idSkillsNeeded;

            // add experiences
            job.experiences = idExperiences;

            // add languages
            job.languages = idLanguages;

            // save job
            await job.save();

            // save customer with added jobs
            await customer.save();

            res.status(200).json({
                status: "success",
                message: "Job created successfully",
            });
        }
    }
});

exports.getCustomerJob = async (req, res) => {
    const user = await User.findOne({ userName: req.params.userName });
    if (!user) {
        return next(new BadRequestError("User Not Found"));
    }
    const customer = await Customer.findOne({ _id: user.customer }).populate(
        "user jobs"
    );
    if (!customer) {
        return next(new BadRequestError("Customer Not Found", 404));
    }
    res.json({
        customer,
    });
};

exports.updateJob = catchAsync(async (req, res, next) => {
    const id = req.params.id;
    const {
        title,
        description,
        address,
        type,
        skillsNeeded,
        experienceLevel,
        budget,
        languages,
    } = req.body;
    const job = await Job.findOne({ _id: id });
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }

    // helpQuery(skillsNeeded, Skill, job);
    const idSkill = await helpUpdate(skillsNeeded, Skill, job, "skills", "job");
    const idExperience = await helpUpdate(
        experienceLevel,
        Experience,
        job,
        "experiences",
        "job"
    );
    const idLanguage = await helpUpdate(
        languages,
        Language,
        job,
        "languages",
        "job"
    );

    // string into ObjectId data-type
    const mappedToSkills = idSkill.map((el) => {
        return ObjectId(el);
    });
    const mappedToExperiences = idExperience.map((el) => {
        return ObjectId(el);
    });

    const mappedToLangauge = idLanguage.map((el) => {
        return ObjectId(el);
    });

    // filter;
    const filter = { _id: id };
    const update = {
        title,
        description,
        address,
        type,
        budget,
        skills: mappedToSkills,
        experiences: mappedToExperiences,
        languages: mappedToLangauge,
    };
    const updatedJob = await Job.findOneAndUpdate(filter, update, {
        new: true,
    });
    res.status(200).json({
        // replace this with message
        updatedJob,
    });
});

exports.getSkills = async (req, res) => {
    await Skill.find({}).exec((err, skills) => {
        res.json({ skills });
    });
};

exports.getExperiences = async (req, res) => {
    await Experience.find({}).exec((err, skills) => {
        res.json({ skills });
    });
};

exports.deleteJob = catchAsync(async (req, res, next) => {
    const { username, id } = req.params;

    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "customer") {
        const customer = await Customer.findOne({ _id: user.customer });
        if (!customer) {
            return next(new BadRequestError("Customor Not Found", 404));
        }
        const job = await Job.findOne({ _id: id });
        if (!job) {
            return next(new BadRequestError("Job Not Found", 404));
        }
        // update skill.jobs
        job.skills.forEach(async (id) => {
            // id - skill id in job
            await Skill.updateOne(
                { _id: id },
                {
                    $pull: { jobs: job._id },
                }
            );
        });
        // update experience.jobs
        job.experiences.forEach(async (id) => {
            await Experience.updateOne(
                { _id: id },
                {
                    $pull: { jobs: job._id },
                }
            );
        });

        // update language.jobs
        job.languages.forEach(async (id) => {
            await Language.updateOne(
                { _id: id },
                {
                    $pull: { jobs: job._id },
                }
            );
        });

        // update the customer.job list by using $pull
        const filteredJobs = customer.jobs.filter((el) => {
            return !el.equals(id);
        });
        await Customer.updateOne(
            { _id: user.customer },
            { jobs: filteredJobs }
        );

        await Job.findByIdAndDelete({ _id: id }, (err) => {
            if (err) {
                next(new BadRequestError("Internal Server Error", 500));
            }
            res.status(200).json({
                status: "success",
                message: "Job Successfully Deleted",
            });
        });
    }
});
