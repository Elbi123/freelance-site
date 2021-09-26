const express = require("express");
const userController = require("./../controllers/user.controller");
const authMiddleware = require("./../middleware/auth.middleware");
const router = express.Router();

// by admin and super-admin
router
    .route("/")
    .get(
        [authMiddleware.verifyToken, authMiddleware.allowAdminOrSuperAdmin],
        userController.getUsers
    );

// by registered users only
router.route("/:username").get(userController.getUser);

// by registered users only
router.route("/:username").patch(userController.updateUserAccount);

// by super-admin
router.route("/roles/assign-role").patch(userController.assignRole);

// by super-admin
router.route("/roles/remove-role").patch(userController.removeRole);

// by registered users only
router.route("/:username").delete(userController.deleteUserAccount);

module.exports = router;
