const express = require("express");
const proposalController = require("../controllers/proposal.controller");

const router = express.Router();

router.get("/proposals", proposalController.getAllProposals);
router.get("/proposals/search", proposalController.searchProposalByStatus);
router.get("/:username/proposals", proposalController.getUserProposals);
router
    .route("/:username/jobs/:slug/")
    .get(proposalController.getProposalForSingleJob)
    .post(proposalController.createProposal);
router.patch(
    "/jobs/:slug/proposals/:id",
    proposalController.changeProposalStatus
);
// router.post("/upload/resume", , proposalController.);

module.exports = router;
