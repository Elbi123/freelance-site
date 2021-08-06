const mongoose = require("mongoose");

const freelancerSchema = new mongoose.Schema(
    {
        address: {
            country: {
                type: String,
                required: [true, "Address required"],
            },
            city: {
                type: String,
                required: [true, "City required"],
            },
        },
        summary: {
            type: String,
            required: [true, "Freelancer summary required"],
        },

        // this can move to its own model [may be]
        educationalBackground: {
            type: [String],
            required: [true, "Educational background required"],
            default: "Self-Taught",
        },
        imgUrl: {
            type: String,
        },
        legalInformation: {
            type: [String],
            required: [true, "Legal information is required"],
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
        languages: [{ type: mongoose.Schema.Types.ObjectId, ref: "Language" }],
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
        },
    },
    { timestamps: true }
);

const Freelancer = mongoose.model("Freelancer", freelancerSchema);

module.exports = Freelancer;
