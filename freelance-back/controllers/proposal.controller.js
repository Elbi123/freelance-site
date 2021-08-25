const User = require("../models/user.model");
const Job = require("../models/job.model");
const Proposal = require("../models/proposal.model");
const Freelancer = require("../models/freelancer.model");
const catchAsync = require("../utils/catchAsync");
const generateRandomId = require("../utils/generateRandomId");
const BadRequestError = require("../utils/error");

exports.getAllProposals = async (req, res) => {
    const proposal = await Proposal.find({});
    res.status(200).json({
        status: "success",
        proposal,
    });
};

exports.getSingleProposal = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "Single proposal",
    });
};

exports.createProposal = catchAsync(async (req, res, next) => {
    const { username, slug } = req.params;
    const { paymentForJob, finishingTime, coverLetter } = req.body;

    const user = await User.findOne({ userName: username });
    const job = await Job.findOne({ slug });

    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }
    if (user.userType === "freelancer") {
        const freelancer = await Freelancer.findOne({ _id: user.freelancer });

        if (!freelancer) {
            return next(
                new BadRequestError("Please Create Profile First", 403)
            );
        }

        // new proposal object
        const proposal = new Proposal({
            paymentForJob,
            finishingTime,
            coverLetter,
        });

        // generate random id form proposal assign to proposal
        const proposalId = await generateRandomId();
        proposal.proposalId = proposalId;

        // add job to proposal
        proposal.job = job._id;

        // add freelancer to job
        proposal.freelancer = freelancer._id;

        // for initial submittion
        if (!freelancer.proposals.length && !job.proposals.length) {
            await Freelancer.updateOne(
                { _id: user.freelancer },
                { $push: { proposals: proposal._id } }
            );
            await Job.updateOne(
                { slug },
                { $push: { proposals: proposal._id } }
            );

            await proposal.save();

            res.status(200).json({
                status: "success",
                message: "Proposal Submitted Successfully",
            });
        } else {
            const jobProposals = await Proposal.find({
                _id: { $in: job.proposals },
            });
            const freelancerProposals = await Proposal.find({
                _id: { $in: freelancer.proposals },
            });

            // the added proposals has to be unique
            const checkJobProposal = jobProposals.every((prop) => {
                if (
                    prop.job.equals(job._id) &&
                    prop.freelancer.equals(freelancer._id)
                ) {
                    return false;
                }
                return true;
            });

            // the added proposals has to be unique
            const checkFreelancerProposal = freelancerProposals.every(
                (prop) => {
                    if (
                        prop.freelancer.equals(freelancer._id) &&
                        prop.job.equals(job._id)
                    ) {
                        return false;
                    }
                    return true;
                }
            );

            if (checkJobProposal && checkFreelancerProposal) {
                await Freelancer.updateOne(
                    { _id: user.freelancer },
                    { $push: { proposals: proposal._id } }
                );
                await Job.updateOne(
                    { slug },
                    { $push: { proposals: proposal._id } }
                );

                // save
                await proposal.save();

                return res.status(200).json({
                    status: "success",
                    message: "Proposal Submitted Successfully",
                });
            } else {
                return next(
                    new BadRequestError(
                        "You have already submitted proposal for this job",
                        403
                    )
                );
            }
        }
    } else {
        return next(
            new BadRequestError("You should be registered as freelancer", 403)
        );
    }
});

exports.uploadResume = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "Proposal declined",
    });
};

exports.underReview = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "Proposal under review",
    });
};

exports.declineProposal = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "Proposal declined",
    });
};

exports.acceptProposal = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "Proposal accepted",
    });
};
