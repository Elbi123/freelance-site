const express = require("express");
const proposalController = require("../controllers/proposal.controller");

const router = express.Router();

router.get("/proposals", proposalController.getAllProposals);
router.get("/:username/proposals", proposalController.getUserProposal);
router.post("/:username/job/:slug", proposalController.createProposal);
router.patch(
    "/jobs/:slug/proposals/:id",
    proposalController.changeProposalStatus
);
// router.post("/upload/resume", , proposalController.);

module.exports = router;
