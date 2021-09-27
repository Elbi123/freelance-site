const mongoose = require("mongoose");

const proposalSchema = new mongoose.Schema({
    proposalId: {
        type: Number,
        required: [true],
    },
    paymentForJob: {
        type: String,
        required: [true, "Provide how much you bid for this job"],
    },
    finishingTime: {
        type: String,
        required: [true, "How long does it take to accomplish this job?"],
    },
    coverLetter: {
        type: String,
        required: [true, "Tell us why you think you're eligible to this job"],
    },
    status: {
        type: String,
        enum: {
            values: [
                "submitted",
                "under-review",
                "accepted",
                "approved",
                "declined",
            ],
            message: "{VALUE} is not supported",
        },
        // [difference between submitted and under-review]
        // if the customer wants to see the details... can put the status under review or else can decline from the start
        default: "submitted",
    },
    resume: {
        type: String,
    },
    job: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Job",
    },
    freelancer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Freelancer",
    },
});

proposalSchema.index({ status: "text", coverLetter: "text" });

const Proposal = mongoose.model("Proposal", proposalSchema);

module.exports = Proposal;
