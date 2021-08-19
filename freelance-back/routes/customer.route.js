const express = require("express");
const router = express.Router();
const customerController = require("./../controllers/customer.controller");
const checkEmptyInputMid = require("../middleware/inputValidation.middleware");

router
    .get("/customers", customerController.getCustomers)
    .post(
        "/:userName/customer",
        checkEmptyInputMid.checkCustomerDetail,
        customerController.createCustomer
    );

module.exports = router;
