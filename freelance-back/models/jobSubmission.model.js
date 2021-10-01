const mongoose = require("mongoose");

const jobSubmissionShema = new mongoose.Schema(
    {
        summary: {
            type: String,
        },
        filePath: {
            type: String,
        },
        freelancer: { type: mongoose.Schema.Types.ObjectId, ref: "Freelancer" },
        user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
        job: { type: mongoose.Schema.Types.ObjectId, ref: "Job" },
    },
    { timestamps: true }
);

const JobSubmission = mongoose.model("JobSubmission", jobSubmissionShema);

module.exports = JobSubmission;
