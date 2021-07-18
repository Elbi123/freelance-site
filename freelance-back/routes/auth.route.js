const express = require("express");
const authController = require("./../controllers/auth.controller");
const router = express.Router();

router.get("/users", authController.getUsers);
router.post("/signup", authController.checkIfRoleExists, authController.signup);
module.exports = router;
