const mongoose = require("mongoose");

const langSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    jobs: [{ type: mongoose.Schema.Types.ObjectId, ref: "Job" }],
});

const Language = mongoose.model("Language", langSchema);

module.exports = Language;
