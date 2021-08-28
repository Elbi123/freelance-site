const multer = require("multer");
const User = require("../models/user.model");
const Job = require("../models/job.model");
const Proposal = require("../models/proposal.model");
const Freelancer = require("../models/freelancer.model");
const catchAsync = require("../utils/catchAsync");
const sendEmail = require("../utils/handleSendingEmail");
const generateRandomId = require("../utils/generateRandomId");
const BadRequestError = require("../utils/error");

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/resume");
    },
    filename: (req, file, cb) => {
        const fileExt = file.mimetype.split("/")[1];

        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        cb(null, `${file.fieldname}-${uniqueSuffix}.${fileExt}`);
    },
});

const multerFilter = (req, file, cb) => {
    const imageFormats = /pdf|docx|png/;
    const fileExt = file.mimetype.split("/")[1];
    const checkValidImageFormat = imageFormats.test(fileExt);

    if (checkValidImageFormat === true) {
        cb(null, true);
    } else {
        cb(new BadRequestError("Invalid image input", 401));
    }
};
const upload = multer({ storage: storage, fileFilter: multerFilter }).single(
    "resume"
);

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
    console.log(req.body);

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
                new BadRequestError("Please Create Profile First", 400)
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

            await proposal.save((err, proposal) => {
                const details = {
                    email: user.email,
                    jobTitle: job.title,
                    proposalId: proposal.proposalId,
                };

                // send emails
                sendEmail(details);

                res.status(200).json({
                    status: "success",
                    message:
                        "Proposal Submitted Successfully. Check your email",
                });
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
                await proposal.save((err, proposal) => {
                    const details = {
                        email: user.email,
                        jobTitle: job.title,
                        proposalId: proposal.proposalId,
                    };

                    // send emails
                    sendEmail(details);

                    res.status(200).json({
                        status: "success",
                        message:
                            "Proposal Submitted Successfully. Check your email",
                    });
                });
            } else {
                return next(
                    new BadRequestError(
                        "You have already submitted proposal for this job",
                        400
                    )
                );
            }
        }
    } else {
        return next(
            new BadRequestError("You should be registered as freelancer", 400)
        );
    }
});

exports.uploadResume = catchAsync(async (req, res) => {
    console.log(req.file);
    res.status(200).json({
        status: "success",
        // message: req,
    });
});

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
