const mongoose = require("mongoose");

const skillSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    jobs: [{ type: mongoose.Schema.Types.ObjectId, ref: "Job" }],
    freelancers: [{ type: mongoose.Schema.Types.ObjectId, ref: "Freelancer" }],
});

const Skill = mongoose.model("Skill", skillSchema);

module.exports = Skill;
