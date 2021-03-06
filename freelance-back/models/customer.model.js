const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema(
    {
        customerType: {
            type: String,
            enum: {
                values: ["customer", "individual"],
                message: "{VALUE} is not supported",
            },
            default: "individual",
        },
        address: {
            country: {
                type: String,
            },
            city: {
                type: String,
            },
        },
        legalInformation: [String],
        moneySpent: {
            type: String,
            default: 0.0,
        },
        isPaymentVerified: {
            type: Boolean,
            default: false,
        },

        tickets: [{ type: mongoose.Schema.Types.ObjectId, ref: "Ticket" }],
        jobs: [{ type: mongoose.Schema.Types.ObjectId, ref: "Job" }],
        user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    },
    { timestamps: true }
);

const Customer = mongoose.model("Customer", customerSchema);

module.exports = Customer;
