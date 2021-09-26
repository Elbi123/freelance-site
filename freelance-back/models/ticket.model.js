const mongoose = require("mongoose");

const ticketSchema = new mongoose.Schema(
    {
        username: {
            type: String,
            required: [true, "Username is required to report"],
        },
        summary: {
            type: String,
            required: [true, "Summary is required to report"],
        },
        ticketId: {
            type: String,
        },
        status: {
            type: String,
            enum: {
                values: ["issued", "under-review", "closed"],
                message: "{VALUE} is not supported",
            },
            default: "issued",
        },
        customer: { type: mongoose.Schema.Types.ObjectId, ref: "Customer" },
        freelancer: { type: mongoose.Schema.Types.ObjectId, ref: "Freelancer" },
    },
    { timestamps: true }
);

const Ticket = mongoose.model("Ticket", ticketSchema);

module.exports = Ticket;
