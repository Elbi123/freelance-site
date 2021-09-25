const express = require("express");
const authController = require("./../controllers/auth.controller");
const router = express.Router();

router.get("/users", authController.getUsers);
router.get("/users/:username", authController.getUser);
router.post("/signup", authController.checkIfRoleExists, authController.signup);
router.patch("/:username", authController.updateUserAccount);
router.delete("/:username", authController.deleteUserAccount);
module.exports = router;
