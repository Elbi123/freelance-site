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
            required: true,
            unique: true,
        },
        description: {
            type: String,
            required: true,
            trim: true,
            min: [32, "Must be at least 32 characters, got {VALUE}"],
            max: [4000, ["Must be at most 4000 characters, got {VALUE}"]],
        },
        type: {
            type: String,
            required: true,
            enum: {
                values: ["one-time", "contract", "hourly"],
                message: "{VALUE} is not supported",
            },
            default: "one-time",
        },
        status: {
            type: String,
            required: true,
            enum: {
                values: ["open", "closed"],
                message: "{VALUE} is not supported",
            },
            default: "open",
        },
        budget: {
            type: Number,
            required: true,
        },
    },
    { timestamps: true }
);

const Job = mongoose.model("Job", jobSchema);

// document middleware
jobSchema.pre("save", async function (next) {
    await Job.find({ slug: this.slug }, (err, job) => {
        if (!job) {
            this.slug = slugify(this.title, { lower: true });
        } else {
            let s1 = this.title.split(" ");
            let s2 = s1.slice(0, s1.length - 1);
            let s3 = s2.join(" ");
            this.slug = slugify(s3, { lower: true });
        }
        next();
    });
});

module.exports = Job;
