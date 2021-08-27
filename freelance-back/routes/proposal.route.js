const express = require("express");
const proposalController = require("../controllers/proposal.controller");
const multer = require("multer");

const upload = multer({ dest: "public" });

const router = express.Router();

router.get("/", proposalController.getAllProposals);
router.get("/:proposalId", proposalController.getSingleProposal);
router.post("/:username/job/:slug", proposalController.createProposal);
// router.post("/upload/resume", , proposalController.);

module.exports = router;
