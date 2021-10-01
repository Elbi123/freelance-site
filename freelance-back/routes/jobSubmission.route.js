const express = require("express");
const jobSubmissionController = require("../controllers/jobSubmission.controller");
const router = express.Router();

router.post("/:jobId/customers/:userName", jobSubmissionController.submitJob);
router.post(
    "/:jobId/customers/:userName/payment",
    jobSubmissionController.processPayment
);

module.exports = router;
