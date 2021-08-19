const mongoose = require("mongoose");

const imageShema = new mongoose.Schema(
    {
        path: {
            type: String,
            required: [true, "Image path required"],
        },
    },
    {
        timestamps: true,
    }
);

const Image = mongoose.model("Image", imageShema);

module.exports = Image;
