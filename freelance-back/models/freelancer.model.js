const mongoose = require("mongoose");

const freelancerSchema = new mongoose.Schema(
    {
        address: {
            country: String,
            city: String,
            required: [true, "Address required"],
        },
        summary: {
            type: String,
            required: [true, "Freelancer summary required"],
        },
        eduBackground: {
            type: [String],
            require: [true, "Educational background required"],
            default: "Self-Taught",
        },
        img: String,
        legalInformation: {
            type: [String],
            required: [true],
        },
        // you might take to the user model
        isActive: {
            type: Boolean,
            default: true,
        },
        moneyEarned: {
            type: Number,
            default: 0.0,
        },
        availableTime: {
            type: String,
            required: [true, "Available time required"],
        },
        skills: [{ type: mongoose.Schema.Types.ObjectId, ref: "Skill" }],
        experiences: [
            { type: mongoose.Schema.Types.ObjectId, ref: "Experience" },
        ],
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
        },
    },
    { timestamps: true }
);

const Freelancer = mongoose.model("Freelancer", freelancerSchema);

module.exports = Freelancer;
