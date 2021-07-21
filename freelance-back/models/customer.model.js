const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema(
    {
        customerType: {
            type: String,
            enum: {
                values: ["company", "individual"],
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
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
        },
        jobs: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Job",
            },
        ],
    },
    { timestamps: true }
);

customerSchema.pre("save", function (next) {
    this.constructor.findOne({ _id: this._id }, (err, customer) => {
        if (customer) {
            next(new Error("Customer already existed"));
        }
        next();
    });
});

const Customer = mongoose.model("Customer", customerSchema);

module.exports = Customer;
