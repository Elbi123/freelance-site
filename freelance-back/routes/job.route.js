const express = require("express");
const jobController = require("./../controllers/job.controller");
const inputValidation = require("../middleware/inputValidation.middleware");
const router = express.Router();

router.get("/", jobController.getAllJobs);
router.get("/skills", jobController.getSkills);
router.get("/experiences", jobController.getExperiences);

router
    .get("/:userName/jobs", jobController.getCustomerJob)
    .get("/:userName/savedJobs", jobController.getSavedJobs)
    .post(
        "/:userName/jobs",
        [inputValidation.checkEmptyJobValidation],
        jobController.createJob
    );

router
    .get("/:slug", jobController.getJobBySlug)
    .post("/:username/jobs/:id", jobController.saveJobForFreelancer)
    .patch("/:username/jobs/:id", jobController.updateJob)
    .delete("/:username/jobs/:id", jobController.deleteJob);

module.exports = router;
