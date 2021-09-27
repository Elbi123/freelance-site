const multer = require("multer");
const User = require("../models/user.model");
const Job = require("../models/job.model");
const Proposal = require("../models/proposal.model");
const Freelancer = require("../models/freelancer.model");
const Customer = require("../models/customer.model");
const catchAsync = require("../utils/catchAsync");
const sendEmail = require("../utils/handleSendingEmail");
const sendEmailToFreelancer = require("../utils/handleFreelancerEmail");
const generateRandomId = require("../utils/generateRandomId");
const BadRequestError = require("../utils/error");
const APIFeatures = require("../utils/apiFeatures");

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
    const features = new APIFeatures(Proposal.find({}), req.query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const proposals = await features.query;

    res.status(200).json({
        status: "success",
        proposals,
    });
};

exports.getUserProposals = catchAsync(async (req, res, next) => {
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

exports.getProposalForSingleJob = catchAsync(async (req, res, next) => {
    const { username, slug } = req.params;
    const { status } = req.query;

    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    const job = await Job.findOne({ slug });
    if (!job) {
        return next(new BadRequestError("Job Not Found", 404));
    }

    if (user.customer) {
        const customer = await Customer.findOne({ _id: user.customer });
        if (!customer) {
            return next(
                new BadRequestError("Please32 fill profile first", 403)
            );
        }
        if (customer.jobs.includes(job._id)) {
            const jobProposals = await Proposal.find({
                _id: { $in: job.proposals },
            })
                .populate({
                    path: "freelancer",
                    populate: {
                        path: "user skills experiences languages",
                    },
                })
                .populate({
                    path: "job",
                    populate: {
                        path: "skills experiences languages",
                        select: "name",
                    },
                    select: "-proposals -slug -__v",
                });
            const filteredJobProposals = jobProposals.filter((jobProposal) => {
                if (status) {
                    return jobProposal.status === status;
                } else {
                    return true;
                }
            });

            const jobProposalBaseOnStatus = {};

            const proposalKeys = [
                "jobTitle",
                "jobDescription",
                "jobBudget",
                "freelancerFirstName",
                "freelancerLastName",
                "paymentForJob",
                "finishingTime",
                "coverLetter",
            ];
            if (status === "submitted" || status === "declined" || !status) {
                filteredJobProposals.forEach((proposal) => {
                    const proposalValues = [
                        proposal.job.title,
                        proposal.job.description,
                        proposal.job.budget,
                        proposal.freelancer.user.firstName,
                        proposal.freelancer.user.lastName,
                        proposal.paymentForJob,
                        proposal.finishingTime,
                        proposal.coverLetter,
                    ];
                    for (let i = 0; i < proposalKeys.length; i++) {
                        jobProposalBaseOnStatus[proposalKeys[i]] =
                            proposalValues[i];
                    }
                });
                res.status(200).json({
                    status: "success",
                    jobProposalBaseOnStatus,
                });
            }
            if (status === "under-review") {
                proposalKeys.push("skills");
                proposalKeys.push("languages");
                proposalKeys.push("experiences");
                proposalKeys.push("educationalBackground");

                filteredJobProposals.forEach((proposal) => {
                    let freelancerSkills = [];
                    let freelancerLangauges = [];
                    let freelancerExperiences = [];
                    let freelancerEducationalBackground = [];
                    proposal.freelancer.skills.forEach((skill) => {
                        freelancerSkills.push(skill.name);
                    });
                    proposal.freelancer.languages.forEach((language) => {
                        freelancerLangauges.push(language.name);
                    });
                    proposal.freelancer.experiences.forEach((experience) => {
                        freelancerExperiences.push(experience.name);
                    });

                    proposal.freelancer.educationalBackground.forEach(
                        (experience) => {
                            freelancerEducationalBackground.push(experience);
                        }
                    );

                    const proposalValues = [
                        proposal.job.title,
                        proposal.job.description,
                        proposal.job.budget,
                        proposal.freelancer.user.firstName,
                        proposal.freelancer.user.lastName,
                        proposal.paymentForJob,
                        proposal.finishingTime,
                        proposal.coverLetter,
                        freelancerSkills,
                        freelancerLangauges,
                        freelancerExperiences,
                        freelancerEducationalBackground,
                    ];
                    for (let i = 0; i < proposalKeys.length; i++) {
                        jobProposalBaseOnStatus[proposalKeys[i]] =
                            proposalValues[i];
                    }
                });
                res.status(200).json({
                    status: "success",
                    jobProposalBaseOnStatus,
                });
            }
            if (status === "accepted") {
                proposalKeys.push("skills");
                proposalKeys.push("languages");
                proposalKeys.push("experiences");
                proposalKeys.push("educationalBackground");
                proposalKeys.push("email");
                proposalKeys.push("phoneNumber");

                filteredJobProposals.forEach((proposal) => {
                    let freelancerSkills = [];
                    let freelancerLangauges = [];
                    let freelancerExperiences = [];
                    let freelancerEducationalBackground = [];
                    proposal.freelancer.skills.forEach((skill) => {
                        freelancerSkills.push(skill.name);
                    });
                    proposal.freelancer.languages.forEach((language) => {
                        freelancerLangauges.push(language.name);
                    });
                    proposal.freelancer.experiences.forEach((experience) => {
                        freelancerExperiences.push(experience.name);
                    });

                    proposal.freelancer.educationalBackground.forEach(
                        (experience) => {
                            freelancerEducationalBackground.push(experience);
                        }
                    );

                    const proposalValues = [
                        proposal.job.title,
                        proposal.job.description,
                        proposal.job.budget,
                        proposal.freelancer.user.firstName,
                        proposal.freelancer.user.lastName,
                        proposal.paymentForJob,
                        proposal.finishingTime,
                        proposal.coverLetter,
                        freelancerSkills,
                        freelancerLangauges,
                        freelancerExperiences,
                        freelancerEducationalBackground,
                        proposal.freelancer.user.email,
                        proposal.freelancer.user.phoneNumber,
                    ];
                    for (let i = 0; i < proposalKeys.length; i++) {
                        jobProposalBaseOnStatus[proposalKeys[i]] =
                            proposalValues[i];
                    }
                });
                res.status(200).json({
                    status: "success",
                    jobProposalBaseOnStatus,
                });
            }
            if (status === "approved") {
                proposalKeys.push("skills");
                proposalKeys.push("languages");
                proposalKeys.push("experiences");
                proposalKeys.push("educationalBackground");
                proposalKeys.push("email");
                proposalKeys.push("phoneNumber");
                proposalKeys.push("summary");
                proposalKeys.push("address");
                proposalKeys.push("legalInformation");

                filteredJobProposals.forEach((proposal) => {
                    let freelancerSkills = [];
                    let freelancerLangauges = [];
                    let freelancerExperiences = [];
                    let freelancerEducationalBackground = [];
                    let freelancerLegalInfo = [];
                    proposal.freelancer.skills.forEach((skill) => {
                        freelancerSkills.push(skill.name);
                    });
                    proposal.freelancer.languages.forEach((language) => {
                        freelancerLangauges.push(language.name);
                    });
                    proposal.freelancer.experiences.forEach((experience) => {
                        freelancerExperiences.push(experience.name);
                    });

                    proposal.freelancer.educationalBackground.forEach(
                        (experience) => {
                            freelancerEducationalBackground.push(experience);
                        }
                    );
                    proposal.freelancer.legalInformation.forEach(
                        (legalInfo) => {
                            freelancerLegalInfo.push(legalInfo);
                        }
                    );

                    const proposalValues = [
                        proposal.job.title,
                        proposal.job.description,
                        proposal.job.budget,
                        proposal.freelancer.user.firstName,
                        proposal.freelancer.user.lastName,
                        proposal.paymentForJob,
                        proposal.finishingTime,
                        proposal.coverLetter,
                        freelancerSkills,
                        freelancerLangauges,
                        freelancerExperiences,
                        freelancerEducationalBackground,
                        proposal.freelancer.user.email,
                        proposal.freelancer.user.phoneNumber,
                        proposal.freelancer.summary,
                        proposal.freelancer.address,
                        freelancerLegalInfo,
                    ];
                    for (let i = 0; i < proposalKeys.length; i++) {
                        jobProposalBaseOnStatus[proposalKeys[i]] =
                            proposalValues[i];
                    }
                });
                res.status(200).json({
                    status: "success",
                    jobProposalBaseOnStatus,
                });
            }
        } else {
            return next(new BadRequestError("Job Not Found", 404));
        }
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
                sendEmail.sendEmail(details);

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

exports.changeProposalStatus = catchAsync(async (req, res, next) => {
    const { slug, id } = req.params;
    const { status } = req.body;
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
            "accepted",
            "under-review",
            "approved",
            "declined",
        ];
        if (!proposalStatuses.includes(status)) {
            return next(new BadRequestError("Status not supported", 401));
        } else {
            // the "accept" will go here
            if (status === "accepted") {
                await handleJobAccept(status, proposal, id, res, next);
            } else if (status === "under-review") {
                await handleJobUnderReview(status, proposal, id, res, next);
            } else if (status === "approved") {
                await handleJobApproved(status, proposal, id, res, job, next);
            } else if (status === "declined") {
                await handleJobDecline(status, proposal, id, res, next);
            }
        }
    } else {
        return next(
            new BadRequestError(
                "The proposal has not been submitted to this job",
                401
            )
        );
    }
});

const handleJobAccept = async (status, proposal, id, res, next) => {
    if (status === "accepted" && proposal.status === "submitted") {
        await Proposal.updateOne({ _id: id }, { status }, (err) => {
            if (err) {
                return next(
                    new BadRequestError(
                        "Error while changing proposal status",
                        401
                    )
                );
            }
            res.status(200).json({
                status: "message",
                message: `You have ${status} the proposal`,
            });
        });
    } else if (status === "accepted" && proposal.status === "accepted") {
        return next(
            new BadRequestError("You have already accepted this proposal", 401)
        );
    } else {
        return next(
            new BadRequestError(
                "Can't update the status. Make sure the proposal is in submitted status",
                401
            )
        );
    }
};

const handleJobUnderReview = async (status, proposal, id, res, next) => {
    // 1- get the job proposal id
    if (status === "under-review" && proposal.status === "accepted") {
        await Proposal.updateOne({ _id: id }, { status }, (err) => {
            if (err) {
                return next(
                    new BadRequestError(
                        "Error while changing proposal status",
                        401
                    )
                );
            }
            res.status(200).json({
                status: "message",
                message: `The proposal is ${status}`,
            });
        });
    } else if (
        status === "under-review" &&
        proposal.status === "under-review"
    ) {
        return next(
            new BadRequestError(`Your proposal is already ${status}`, 401)
        );
    } else {
        return next(
            new BadRequestError(
                "Can't update the status. Make sure you accepted the proposal",
                401
            )
        );
    }
};

const handleJobApproved = async (status, proposal, id, res, job, next) => {
    if (status === "approved" && proposal.status === "under-review") {
        await Proposal.updateOne({ _id: id }, { status }, async (err) => {
            if (err) {
                return next(
                    new BadRequestError(
                        "Error while changing proposal status",
                        401
                    )
                );
            }

            const user = await User.findOne({
                freelancer: proposal.freelancer,
            }).select("email");
            const details = {
                email: user.email,
                jobTitle: job.title,
                proposalId: proposal.id,
            };

            // // send email to freelancer while accepted
            sendEmailToFreelancer(details);

            // changing the job status to 'approved' immediately changes the job status
            // to 'in-progress'
            await Job.updateOne({ _id: job._id }, { status: "in-progress" });

            res.status(200).json({
                status: "message",
                message: `The proposal is ${status}`,
            });
        });
    } else {
        return next(
            new BadRequestError(
                "Wanna approve the proposal? Make sure your first made the proposal under-review"
            )
        );
    }
};

const handleJobDecline = async (status, proposal, id, res, next) => {
    if (status === "declined") {
        await Proposal.updateOne({ _id: id }, { status: status }, (err) => {
            if (err) {
                return next(
                    new BadRequestError(
                        "Error while changing proposal status",
                        401
                    )
                );
            }
        });
        res.status(200).json({
            status: "success",
            message: `You have ${status} the proposal`,
        });
    } else {
        return next(
            new BadRequestError(
                `You wanna decline? change proposal status to ${status}`,
                403
            )
        );
    }
};
