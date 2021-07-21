const faker = require("faker");
const Job = require("./../models/job.model");
const User = require("./../models/user.model");
const catchAsync = require("./../utils/catchAsync");
const BadRequestError = require("./../utils/error");

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

    let query = Job.find(JSON.parse(queryString));

    // SORTING GOES HERE
    if (req.query.sort) {
        let sortBy = req.query.sort.split(",").join(" ");
        console.log(sortBy);
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

exports.getFilteredJobs = catchAsync(async (req, res) => {
    const queryObj = { ...req.query };
    const excludedFields = ["page", "sort", "limit", "fields"];
    excludedFields.forEach((el) => delete queryObj[el]);
    let queryString = JSON.stringify(queryObj);

    // ADVANCED FITERING[SHOULD BE ADDED MORE]
    queryString = queryString.replace(
        /\b(gte|gt|lte|lt)\b/g,
        (match) => `$${match}`
    );

    let query = Job.find(JSON.parse(queryString));

    const jobs = await query;

    res.status(200).json({
        total: jobs.length,
        jobs,
    });
});

exports.getJobBySlug = (req, res) => {
    res.status(200).json({
        message: "GET JOB BY SLUG",
    });
};

exports.createJob = catchAsync(async (req, res, next) => {
    let { title, description, address, type, skillsNeeded, budget } = req.body;
    let { username } = req.params;
    // console.log(req.params);

    const user = await User.findOne({ userName: username });
    if (!user) {
        next(new BadRequestError("User not found", 404));
    } else {
        if (user.userType === "customer") {
            // 1- save the data to customer
            // save the
        }
    }

    if (process.env.NODE_ENV === "development") {
        title = faker.name.jobTitle();
        description = faker.lorem.paragraph();
        address.country = faker.address.country();
        address.city = faker.address.cityName();
        budget = faker.commerce.price();
    } else if (process.env.NODE_ENV === "production") {
        if (!title) {
            next(new BadRequestError("Title is required", 400));
        } else if (!description) {
            next(new BadRequestError("Description is required", 400));
        } else if (!address) {
            next(new BadRequestError("Address is required"));
        } else if (!skillsNeeded.length) {
            next(new BadRequestError("Need skills are required"));
        } else if (!budget) {
            next(new BadRequestError("Budget is needed"));
        }
    }
    const job = new Job({
        title,
        description,
        address,
        type,
        skillsNeeded,
        budget,
    });
    // await job.save();
    res.status(200).json({
        // message: job,
        user,
    });
});

exports.updateJob = (req, res) => {
    res.status(200).json({
        message: "UPDATE JOB MAN",
    });
};

exports.deleteJob = (req, res) => {
    res.status(200).json({
        message: "DELETE JOB MAN",
    });
};
