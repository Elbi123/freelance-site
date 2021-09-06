const express = require("express");
const ticketController = require("../controllers/ticket.controller");
const router = express.Router();

router
    .route("/")
    .get(ticketController.getAllTickets)
    .post(ticketController.issueTicket);

router
    .route("/:id")
    .get(ticketController.getTicketByTicketId)
    .patch(ticketController.assignTicketToAdmins)
    .delete(ticketController.deleteTicket);

// send response back[handle this in any way]
// either you could have another model for response or just handle it in ticket model
// router.route("/:id");

module.exports = router;
