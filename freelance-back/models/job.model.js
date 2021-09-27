const mongoose = require("mongoose");
const { Schema } = mongoose;
const slugify = require("slugify");

const jobSchema = new Schema(
    {
        title: {
            type: String,
            required: true,
            trim: true,
            min: [12, "Must be at least 12 characters, got {VALUE}"],
            max: [72, "Must be at most 72 characters, got {VALUE}"],
        },
        slug: {
            type: String,
            unique: true,
        },
        description: {
            type: String,
            required: true,
            trim: true,
            min: [32, "Must be at least 32 characters, got {VALUE}"],
            max: [4000, ["Must be at most 4000 characters, got {VALUE}"]],
        },
        address: {
            country: {
                type: String,
            },
            city: {
                type: String,
            },
        },
        type: {
            type: String,
            enum: {
                values: ["fixed-price", "contract", "hourly"],
                message: "{VALUE} is not supported",
            },
            default: "fixed-price",
        },
        experienceLevelJob: {
            type: String,
            enum: {
                values: ["entry", "intermidiate", "advanced"],
                message: "{VALUE} is not supported",
            },
            default: "entry",
        },
        status: {
            type: String,
            enum: {
                values: [
                    "open",
                    "in-progress",
                    "submitted",
                    "approved",
                    "closed",
                ],
                message: "{VALUE} is not supported",
            },
            default: "open",
        },
        // you can take this to its own model
        budget: {
            type: Number,
            required: true,
        },
        skills: [{ type: mongoose.Schema.Types.ObjectId, ref: "Skill" }],
        experiences: [
            { type: mongoose.Schema.Types.ObjectId, ref: "Experience" },
        ],
        languages: [{ type: mongoose.Schema.Types.ObjectId, ref: "Language" }],

        // proposal
        proposals: [{ type: mongoose.Schema.Types.ObjectId, ref: "Proposal" }],

        customer: { type: mongoose.Schema.Types.ObjectId, ref: "Customer" },
    },
    { timestamps: true }
);

// document middleware
jobSchema.pre("save", async function (next) {
    this.slug = slugify(this.title, { lower: true });
    await this.constructor.findOne({ slug: this.slug }, function (err, slug) {
        if (slug) {
            let s1 = slug.split(" ");
            let s2 = s1.slice(0, s1.length - 1);
            let s3 = s2.join(" ");
            this.slug = slugify(s3, { lower: true });
        }
    });
    next();
});
const Job = mongoose.model("Job", jobSchema);

module.exports = Job;
