const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const Job = require("../models/job.model");
const User = require("../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Customer = require("../models/customer.model");
const Proposal = require("../models/proposal.model");
const JobSubmission = require("../models/jobSubmission.model");
const catchAsync = require("../utils/catchAsync");
const BadRequestError = require("../utils/error");

exports.submitJob = catchAsync(async (req, res, next) => {
    const { jobId, userName } = req.params;
    const { summary, filePath } = req.body;
    const job = await Job.findOne({ _id: jobId });
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }
    const user = await User.findOne({ userName });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "freelancer") {
        const freelancer = await Freelancer.findOne({ _id: user.freelancer });
        if (!freelancer) {
            return next(new BadRequestError("Please fill profile first", 401));
        }
        let checkProposal = [];
        for (let i = 0; i < job.proposals.length; i++) {
            for (let j = 0; j < freelancer.proposals.length; j++) {
                if (job.proposals[i].equals(freelancer.proposals[j])) {
                    checkProposal.push(job.proposals[i]);
                }
            }
        }

        // this means that the proposal is submitted for the job by the freelancer
        if (checkProposal.length > 0) {
            if (job.status === "in-progress") {
                // submit the job submission
                const customer = await Customer.findOne({ _id: job.customer });
                if (!customer) {
                    return next(new BadRequestError("Customer"));
                }
                const submissionDetail = new JobSubmission({
                    summary,
                    filePath,
                });
                submissionDetail.freelancer = freelancer._id;
                submissionDetail.job = jobId;
                submissionDetail.user = customer.user;

                // console.log(submissionDetail);

                await Job.updateOne({ _id: job._id }, { status: "submitted" });

                await submissionDetail.save();

                res.status(200).json({
                    status: "success",
                    message: "Job has been submitted successfully",
                });
            } else {
                return next(
                    new BadRequestError(
                        "Proposal has not been approved yet",
                        401
                    )
                );
            }
        } else {
            return next(
                new BadRequestError(
                    "You have not added proposal to this job",
                    401
                )
            );
        }
    } else {
        return next(
            new BadRequestError("You should first register as freelancer")
        );
    }
});

exports.processPayment = catchAsync(async (req, res, next) => {
    const { jobId, userName } = req.params;
    const job = await Job.findOne({ _id: jobId });
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }
    const user = await User.findOne({ userName });
    if (!user) {
        return next(new BadRequestError("User Not Found"));
    }

    if (user.userType === "customer" || user.userType === "client") {
        const jProposal = await JobSubmission.findOne({ job: job._id });
        if (!jProposal) {
            return next(new BadRequestError("Prosposal Not Found", 404));
        }
        const uProposal = await JobSubmission.findOne({ user: user._id });
        if (!uProposal) {
            return next(new BadRequestError("Probnposal Not Found", 404));
        }
        if (uProposal && jProposal) {
            if (job.status === "submitted") {
                // stripe.customers.
            } else {
                return next(new BadRequestError("Job has not been submitted"));
            }
            res.status(200).json({
                status: "success",
                job,
                user,
            });
        }
    } else {
        return next(new BadRequestError("Register as customer or client", 401));
    }
});
