const express = require("express");
const proposalController = require("../controllers/proposal.controller");

const router = express.Router();

router.get("/", proposalController.getAllProposals);
router.get("/:proposalId", proposalController.getSingleProposal);
router.post("/:username/job/:slug", proposalController.createProposal);
module.exports = router;
