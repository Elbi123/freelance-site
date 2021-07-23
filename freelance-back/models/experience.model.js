const mongoose = require("mongoose");

const experienceSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    jobs: [{ type: mongoose.Schema.Types.ObjectId, ref: "Job" }],
});

const Experience = mongoose.model("Experience", experienceSchema);

module.exports = Experience;
