const express = require("express");
const authController = require("./../controllers/auth.controller");
const router = express.Router();

router
    .route("/signup")
    .post(authController.checkIfRoleExists, authController.signup);
router.route("/login").post(authController.login);

router.route("/forgot-password").post(authController.forgotPassword);
router.route("/reset-password/:token").patch(authController.resetPassword);

module.exports = router;
