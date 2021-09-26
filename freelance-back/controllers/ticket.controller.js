const catchAsync = require("../utils/catchAsync");
const User = require("../models/user.model");
const Customer = require("../models/customer.model");
const Freelancer = require("../models/freelancer.model");
const Ticket = require("../models/ticket.model");
const Role = require("../models/role.model");
const generateRandomId = require("../utils/generateRandomId");
const sendTicketEmail = require("../utils/handleSendingEmail").sendTicketEmail;
const BadRequestError = require("../utils/error");
const APIFeatures = require("../utils/apiFeatures");

// for super-admin
exports.getAllTickets = catchAsync(async (req, res) => {
    console.log(req.query);
    const features = new APIFeatures(Ticket.find(), req.query).filter().sort();
    const tickets = await features.query;
    res.status(200).json({
        status: "success",
        tickets,
    });
});

// depending on customer
// for admins
// accessed by ticket - [admin, freelancer, customer, client]
exports.getTicketByTicketId = catchAsync(async (req, res, next) => {
    const { username, ticketId } = req.params;
    const user = await User.findOne({ userName: username });
    const ticket = await Ticket.findOne({ ticketId });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }

    if (!ticket) {
        return next(new BadRequestError("Ticket Not Found", 404));
    }

    const userType = ["freelancer", "customer", "company", "admin"];
    if (userType.includes(user.userType)) {
        if (user.userType === "freelancer" && ticket.freelancer) {
            const freelancer = await Freelancer.findOne({
                _id: user.freelancer,
            });

            if (!freelancer) {
                return next(
                    new BadRequestError("Fill Your Profile First", 403)
                );
            }

            const filterdTicketIds = freelancer.tickets.filter((id) => {
                return id.equals(ticket._id);
            });

            if (filterdTicketIds.length > 0) {
                const ticket = await Ticket.findOne({
                    _id: filterdTicketIds[0],
                });
                res.status(200).json({
                    status: "success",
                    ticket,
                    freelancer: user.freelancer,
                    ticketF: ticket.freelancer,
                });
            } else if (!filterdTicketIds.length) {
                res.status(200).json({
                    status: "success",
                    message: "You have no ticket with that ticket id",
                });
            }
        }
        if (
            (user.userType === "customer" || user.userType === "client") &&
            ticket.customer
        ) {
            const customer = await Customer.findOne({ _id: user.customer });
            if (!customer) {
                return next(
                    new BadRequestError("Fill Your Profile First", 403)
                );
            }

            const filterdTicketIds = customer.tickets.filter((id) => {
                return id.equals(ticket._id);
            });

            if (filterdTicketIds.length > 0) {
                const ticket = await Ticket.findOne({
                    _id: filterdTicketIds[0],
                });
                res.status(200).json({
                    status: "success",
                    ticket,
                });
            } else if (!filterdTicketIds.length) {
                res.status(200).json({
                    status: "success",
                    message: "You have no ticket with that ticket id",
                });
            }
        }

        if (user.userType === "admin") {
            const filterdTicketIds = user.tickets.filter((id) => {
                return id.equals(ticket._id);
            });
            if (filterdTicketIds.length > 0) {
                const ticket = await Ticket.findOne({
                    _id: filterdTicketIds[0],
                });
                res.status(200).json({
                    status: "success",
                    ticket,
                });
            } else if (!filterdTicketIds.length) {
                res.status(200).json({
                    status: "success",
                    message: "Ticket with ticket id has not be assigned yet",
                });
            }
        }
    } else {
        return next(new BadRequestError("Register first", 403));
    }
});

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

// by super-admin | admin if role here is like [agent] may be
exports.assignTicket = catchAsync(async (req, res, next) => {
    const { username } = req.params;
    const { ticketId, status } = req.query;
    const statuses = ["issued", "under-review", "closed"];
    if (!ticketId || !status) {
        return next(
            new BadRequestError("Provide the ticket id or status", 404)
        );
    }

    if (!statuses.includes(status)) {
        return next(new BadRequestError("Invalid Status", 404));
    }

    const user = await User.findOne({ userName: username });
    const ticket = await Ticket.findOne({ ticketId });

    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (!ticket) {
        return next(new BadRequestError("Ticket Not Found", 404));
    }

    const customer = await Customer.findOne({ _id: ticket.customer });
    const freelancer = await Freelancer.findOne({ _id: ticket.freelancer });

    // change the status of ticket -> "under-review"
    if (ticket.status === "issued") {
        ticket.status = "under-review";
    } else if (ticket.status === "closed" || ticket.status === "under-review") {
        return next(new BadRequestError("Provide the status correctly", 403));
    }
    let ticketDetail = {};
    if (customer) {
        const userCustomer = await User.find({ _id: customer.user });
        ticketDetail["status"] = ticket.status;
        ticketDetial["username"] = userCustomer.username;
        ticketDetail["userEmail"] = userCustomer.email;
        ticketDetail["ticketId"] = ticket.ticketId;
        ticketDetail["summary"] = ticket.summary;
    } else if (freelancer) {
        const userFreelancer = await User.findOne({ _id: freelancer.user });
        ticketDetail["status"] = ticket.status;
        ticketDetail["username"] = userFreelancer.userName;
        ticketDetail["email"] = userFreelancer.email;
        ticketDetail["ticketId"] = ticket.ticketId;
        ticketDetail["summary"] = ticket.summary;
    }

    // works the assignment by updating
    const roles = await Role.find({ _id: { $in: user.roles } });
    roles.forEach(async (role) => {
        if (role.name === "admin" && user.userType === "admin") {
            await User.updateOne(
                { _id: user._id },
                { $push: { tickets: ticket._id } }
            );
        }
    });

    await ticket.save((err) => {
        if (err) {
            return next(
                new BadRequestError("Error while assigning ticket", 500)
            );
        }
        sendTicketEmail(ticketDetail);

        res.status(200).json({
            status: "success",
            message: "Ticket assigned successfully",
        });
    });

    // change the status
});

exports.sendNotification = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "SEND NOTIFICATION",
    });
};

// revoke the token
exports.suspendAccount = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "SUSPEND ACCOUNT",
    });
};
