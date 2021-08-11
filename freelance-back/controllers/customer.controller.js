const faker = require("faker");
const User = require("./../models/user.model");
const Customer = require("./../models/customer.model");
const catchAsync = require("./../utils/catchAsync");
const BadRequestHandler = require("./../utils/error");

exports.getCustomers = catchAsync(async (req, res) => {
    const users = await User.find({ userType: "customer" });
    res.status(200).json({
        users,
    });
});

exports.createCustomer = catchAsync(async (req, res, next) => {
    const { customerType, address, legalInformation } = req.body;
    const { userName } = req.params;

    const user = await User.findOne({ userName });
    if (!user) {
        return next(new BadRequestHandler("User Not Found", 404));
    }

    if (user.userType === "customer" || user.userType === "company") {
        const customer = new Customer({
            customerType,
            address,
            legalInformation,
        });
        // checks if the customer exists
        if (user.customer) {
            return next(new BadRequestHandler("Customer already existed", 400));
        }

        // update the customer field on user document;
        await User.updateOne(
            { userName },
            { $set: { customer: customer._id } }
        );

        // link the customer to it's own info[USER]
        customer.user = user._id;

        // SAVE - the customer
        await customer.save();

        res.status(200).json({
            message: "Profile Created Successufully",
        });
    } else {
        next(
            new BadRequestHandler(
                "Couldn't save, check if you're customer or company",
                400
            )
        );
    }
});
