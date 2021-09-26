const express = require("express");
const ticketController = require("../controllers/ticket.controller");
const ticketMiddleware = require("../middleware/inputValidation.middleware");
const router = express.Router();

router.route("/").get(ticketController.getAllTickets);

router.post(
    "/:username/create-ticket",
    ticketMiddleware.checkEmptyTicketValidation,
    ticketController.issueTicket
);

router
    .route("/:username/ticket/:ticketId")
    .get(ticketController.getTicketByTicketId)
    .delete(ticketController.deleteTicket);

router.route("/:username/ticket").patch(ticketController.assignTicket);

// send response back[handle this in any way]
// either you could have another model for response or just handle it in ticket model
// router.route("/:id");

module.exports = router;
