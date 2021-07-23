const express = require("express");
const jobController = require("./../controllers/job.controller");
const router = express.Router();

router
    .get("/", jobController.getAllJobs)
    .get("/filtered", jobController.getFilteredJobs)
    .get("/:userName/jobs", jobController.getCustomerJob)
    .post("/:userName/jobs", jobController.createJob);

module.exports = router;
