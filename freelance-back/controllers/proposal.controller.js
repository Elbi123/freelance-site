const multer = require("multer");
const User = require("../models/user.model");
const Job = require("../models/job.model");
const Proposal = require("../models/proposal.model");
const Freelancer = require("../models/freelancer.model");
const catchAsync = require("../utils/catchAsync");
const sendEmail = require("../utils/handleSendingEmail");
const sendEmailToFreelancer = require("../utils/handleFreelancerEmail");
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
    const imageFormats = /pdf|docx/;
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
    const { status } = req.query;
    let proposals;
    if (status) {
        proposals = await Proposal.find({ status });
    } else {
        proposals = await Proposal.find({});
    }
    res.status(200).json({
        status: "success",
        proposals,
    });
};

exports.getUserProposal = catchAsync(async (req, res, next) => {
    const { status } = req.query;
    const { username } = req.params;

    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "freelancer") {
        let proposals;
        if (status) {
            proposals = await Proposal.find({
                $and: [{ freelancer: user.freelancer }, { status }],
            });
        } else {
            proposals = await Proposal.find({ freelancer: user.freelancer });
        }
        if (!proposals) {
            res.status(200).json({
                status: "success",
                message: "No proposal has been submitted",
            });
        }
        res.status(200).json({
            status: "sucess",
            proposals,
        });
    } else if (user.userType === "customer" || user.userType === "company") {
        const jobs = await Job.find({ customer: user.customer });

        let proposals;
        for (let i = 0; i < jobs.length; i++) {
            if (status) {
                proposals = await Proposal.find({
                    $and: [{ _id: { $in: jobs[i].proposals } }, { status }],
                })
                    .populate({
                        path: "job",
                        select: "title description budget -_id",
                    })
                    .select("-_id")
                    .populate({
                        path: "freelancer",
                        select: "skills languages experiences user -_id",
                        populate: {
                            path: "skills languages experiences user",
                            select: "name firstName lastName -_id",
                            populate: { path: "user" },
                        },
                    })
                    .select("-__v");
            } else {
                proposals = await Proposal.find({
                    _id: { $in: jobs[i].proposals },
                })
                    .populate({
                        path: "job",
                        select: "title description budget -_id",
                    })
                    .select("-_id")
                    .populate({
                        path: "freelancer",
                        select: "skills languages experiences user -_id",
                        populate: {
                            path: "skills languages experiences user",
                            select: "name firstName lastName -_id",
                            populate: { path: "user" },
                        },
                    })
                    .select("-__v");
            }
        }

        res.status(200).json({
            status: "sucess",
            proposals,
        });
    }
});

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
    res.status(200).json({
        status: "success",
        // message: req,
    });
});

// for three status: declined, accepted, under-review
exports.changeProposalStatus = catchAsync(async (req, res, next) => {
    const { slug, id } = req.params;
    const { ustatus } = req.query;
    const job = await Job.findOne({ slug });
    const proposal = await Proposal.findOne({ _id: id });
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }
    if (!proposal) {
        return next(new BadRequestError("Proposal Not Found", 404));
    }

    if (job.proposals.includes(id)) {
        const proposalStatuses = [
            "submitted",
            "under-review",
            "accepted",
            "declined",
        ];
        if (!proposalStatuses.includes(ustatus)) {
            return next(new BadRequestError("Status not supported", 401));
        } else {
            if (ustatus === "accepted" && proposal.status !== "accepted") {
                await Proposal.updateOne(
                    { _id: id },
                    { status: ustatus },
                    (err) => {
                        if (err) {
                            return next(
                                new BadRequestError(
                                    "Error while changing proposal status",
                                    401
                                )
                            );
                        }
                    }
                );
                const user = await User.findOne({
                    freelancer: proposal.freelancer,
                }).select("email");
                const details = {
                    email: user.email,
                    jobTitle: job.jobTitle,
                    proposalId: proposal.id,
                };

                // send email to freelancer while accepted
                sendEmailToFreelancer(details);

                res.status(200).json({
                    status: "success",
                    message: "You have accepted the proposal",
                });
            } else if (
                ustatus === "accepted" &&
                proposal.status === "accepted"
            ) {
                return next(
                    new BadRequestError(
                        "You have already accepted this proposal",
                        401
                    )
                );
            }

            if (
                ustatus === "under-review" &&
                proposal.status !== "under-review"
            ) {
                await Proposal.updateOne(
                    { _id: id },
                    { status: ustatus },
                    (err) => {
                        if (err) {
                            return next(
                                new BadRequestError(
                                    "Error while changing proposal status",
                                    401
                                )
                            );
                        }
                    }
                );
                res.status(200).json({
                    status: "success",
                    message: "Proposal is being reviewed",
                });
            } else if (
                ustatus === "under-review" &&
                proposal.status === "under-review"
            ) {
                return next(
                    new BadRequestError(
                        "You have are already reviewing the proposal",
                        401
                    )
                );
            }

            if (ustatus === "declined" && proposal.status !== "declined") {
                await Proposal.updateOne(
                    { _id: id },
                    { status: ustatus },
                    (err) => {
                        if (err) {
                            return next(
                                new BadRequestError(
                                    "Error while changing proposal status",
                                    401
                                )
                            );
                        }
                    }
                );
                res.status(200).json({
                    status: "success",
                    message: "You have declined the proposal",
                });
            } else if (
                ustatus === "declined" &&
                proposal.status === "declined"
            ) {
                return next(
                    new BadRequestError(
                        "You have already declined this proposal",
                        401
                    )
                );
            }
        }
    } else {
        return next(
            new BadRequestError(
                "This Proposal has not been submitted to this job",
                401
            )
        );
    }
});
