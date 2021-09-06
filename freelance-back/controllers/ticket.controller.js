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

exports.issueTicket = (req, res) => {
    res.status(200).json({
        status: "success",
        message: "ISSUE TICKET",
    });
};

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
