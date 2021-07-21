const faker = require("faker");
const User = require("./../models/user.model");
const Customer = require("./../models/customer.model");
const catchAsync = require("./../utils/catchAsync");
const BadRequestHandler = require("./../utils/error");

exports.getCustomers = catchAsync(async (req, res) => {
    const users = await User.find({}).populate("customer");
    res.status(200).json({
        users,
    });
});

exports.createCustomer = catchAsync(async (req, res, next) => {
    const { customerType, address, legalInformation } = req.body;
    const { userName } = req.params;

    // for 'development' vs 'production' envs
    if (process.env.NODE_ENV === "development") {
        if (!address.country || !address.city) {
            address.country = faker.address.country();
            address.city = faker.address.cityName();
        }
    } else if (process.env.NODE_ENV === "production") {
        if (!address.country || !address.city) {
            return next(
                new BadRequestHandler("Fill your address correctly", 400)
            );
        } else if (!legalInformation.length) {
            return next(
                new BadRequestHandler("Fill you legal information details", 400)
            );
        }
    }
    const user = await User.findOne({ userName });
    if (!user) {
        return next(new BadRequestHandler("User Not Found", 404));
    }

    if (user.userType === "customer") {
        const customer = new Customer({
            customerType,
            address,
            legalInformation,
        });
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
            customer,
            user,
        });
    } else {
        next(
            new BadRequestHandler(
                "Couldn't save, check if you're customer",
                400
            )
        );
    }
});
