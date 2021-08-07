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

router.patch(
    "/:username/freelancer-detail/",
    freelancerController.updateFreelancerDetail
);

module.exports = router;
