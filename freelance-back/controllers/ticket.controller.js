const catchAsync = require("../utils/catchAsync");
const User = require("../models/user.model");
const Customer = require("../models/customer.model");
const Freelancer = require("../models/freelancer.model");
const Ticket = require("../models/ticket.model");
const generateRandomId = require("../utils/generateRandomId");
const sendTicketEmail = require("../utils/handleSendingEmail").sendTicketEmail;
const BadRequestError = require("../utils/error");

exports.getAllTickets = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "GET ALL TICKETS",
    });
};

// depending on customer
exports.getTicketByTicketId = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "GET TICKET BY TICKET ID",
    });
};

exports.issueTicket = catchAsync(async (req, res, next) => {
    const username = req.params.username;
    const { inputUsername, summary } = req.body;
    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "customer" && !user.customer) {
        return next(new BadRequestError("Fill your profile first", 400))();
    } else if (user.userType === "freelancer" && !user.freelancer) {
        return next(new BadRequestError("Fill your profile first", 400))();
    }
    const ticketId = generateRandomId();
    const ticket = new Ticket({ summary, ticketId: ticketId });

    const checkUsername = await User.findOne({ userName: inputUsername });

    if (!checkUsername) {
        return next(new BadRequestError("Username Not Found", 404));
    }

    if (user.userType === "freelancer") {
        if (checkUsername.customer) {
            ticket.username = inputUsername;
            ticket.freelancer = user.freelancer;

            await Freelancer.updateOne(
                { _id: user.freelancer },
                { $push: { tickets: ticket._id } }
            );
        } else if (checkUsername.freelancer) {
            return next(
                new BadRequestError("Operation couldn't be executed", 401)
            );
        }
    } else if (user.userType === "customer") {
        if (checkUsername.freelancer) {
            ticket.username = inputUsername;
            ticket.customer = user.customer;
            await Customer.updateOne(
                { _id: user.customer },
                { $push: { tickets: ticket._id } }
            );
        } else if (checkUsername.customer) {
            return next(
                new BadRequestError("Operation couldn't be executed", 401)
            );
        }
    }

    await ticket.save((err, ticket) => {
        // email, ticketId, username
        const ticketDetail = {
            email: user.email,
            ticketId,
            username: inputUsername,
            summary,
            status: ticket.status,
        };
        if (err) {
            return next(new BadRequestError("Internal Server Error", 500));
        }
        sendTicketEmail(ticketDetail);
        res.status(200).json({
            status: "message",
            message: "You have reported. check your email",
        });
    });
});

exports.deleteTicket = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "DELETE TICKET",
    });
};

exports.assignTicketToAdmins = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "ASSIGN TICKET TO ADMIN",
    });
};

exports.sendNotification = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "SEND NOTIFICATION",
    });
};

exports.suspendAccount = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "SUSPEND ACCOUNT",
    });
};
