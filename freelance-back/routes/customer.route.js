const express = require("express");
const router = express.Router();
const customerController = require("./../controllers/customer.controller");

router
    .get("/customers", customerController.getCustomers)
    .post("/:userName/customer", customerController.createCustomer);

module.exports = router;
