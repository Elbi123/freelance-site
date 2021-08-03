const express = require("express");
const router = express.Router();
const freelancerController = require("../controllers/freelancer.controller");

router.get("/freelancers", freelancerController.getAllFreelancer);
router.post("/:username/freelancers", freelancerController.createFreelancer);

module.exports = router;
