const express = require("express");
const router = express.Router();
const freelancerController = require("../controllers/freelancer.controller");
const checkEmptyInputMid = require("../middleware/inputValidation.middleware");

router.get("/freelancers", freelancerController.getAllFreelancer);
router.post(
    "/:username/freelancers",
    [checkEmptyInputMid.checkEmptyFreelancerValidation],
    freelancerController.createFreelancer
);

module.exports = router;
