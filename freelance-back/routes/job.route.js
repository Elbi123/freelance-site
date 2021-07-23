const express = require("express");
const jobController = require("./../controllers/job.controller");
const router = express.Router();

router
    .get("/", jobController.getAllJobs)
    .get("/:userName/jobs", jobController.getCustomerJob)
    .get("/skills", jobController.getSkill)
    .post("/:userName/jobs", jobController.createJob);

module.exports = router;
