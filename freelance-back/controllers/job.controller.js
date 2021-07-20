const faker = require("faker");
const Job = require("./../models/job.model");
const catchAsync = require("./../utils/catchAsync");
exports.getAllJobs = catchAsync(async (req, res) => {
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
        if (skip >= numberOfJobs) throw new Error("Page doesn't exist");
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

exports.createJob = catchAsync(async (req, res) => {
    let { title, description, budget } = req.body;
    if (!title || !description || !budget) {
        title = faker.name.jobTitle();
        description = faker.lorem.paragraph();
        budget = faker.commerce.price();
    }
    const job = new Job({
        title,
        description,
        budget,
    });
    await job.save();
    res.status(200).json({
        message: job,
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
