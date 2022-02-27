const express = require("express");
const router = express.Router();
const freelancerController = require("../controllers/freelancer.controller");
const authMiddleware = require("../middleware/auth.middleware");
const imageController = require("../controllers/image.controller");
const checkEmptyInputMid = require("../middleware/inputValidation.middleware");
const upload = require("../middleware/imageUpload");

router.get(
    "/freelancers",
    [authMiddleware.verifyToken, authMiddleware.allowAdminOrSuperAdmin],
    freelancerController.getAllFreelancer
);
router.post(
    "/:username/freelancers",
    [
        checkEmptyInputMid.checkEmptyFreelancerValidation,
        // authMiddleware.verifyToken,
        // authMiddleware.isFreelancer,
    ],
    freelancerController.createFreelancer
);

// upload image
router.post(
    "/:username/upload-profile-picture",
    [authMiddleware.verifyToken, authMiddleware.isFreelancer],
    imageController.uploadFreelanceProfilePic
);

router.patch(
    "/:username/freelancer-detail/",
    // [authMiddleware.verifyToken, authMiddleware.isFreelancer],
    freelancerController.updateFreelancerDetail
);
router.delete(
    "/:username/freelancer-detail",
    [authMiddleware.verifyToken, authMiddleware.isFreelancer],
    freelancerController.deleteFreelancerDetail
);

module.exports = router;
