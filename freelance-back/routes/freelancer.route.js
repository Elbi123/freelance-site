const express = require("express");
const router = express.Router();
const freelancerController = require("../controllers/freelancer.controller");
const imageController = require("../controllers/image.controller");
const checkEmptyInputMid = require("../middleware/inputValidation.middleware");
const upload = require("../middleware/imageUpload");

router.get("/freelancers", freelancerController.getAllFreelancer);
router.post(
    "/:username/freelancers",
    [checkEmptyInputMid.checkEmptyFreelancerValidation],
    freelancerController.createFreelancer
);

// upload image
router.post(
    "/:username/upload-profile-picture",
    imageController.uploadFreelanceProfilePic
);

router.patch(
    "/:username/freelancer-detail/",
    freelancerController.updateFreelancerDetail
);
router.delete(
    "/:username/freelancer-detail",
    freelancerController.deleteFreelancerDetail
);

module.exports = router;
