const nodemailer = require("nodemailer");
const BadRequestError = require("./error");

module.exports = sendEmailToFreelancer = (details) => {
    console.log("called");
    const transport = nodemailer.createTransport({
        host: "smtp.mailtrap.io",
        port: 2525,
        auth: {
            user: `${process.env.MAILTRAP_USER}`,
            pass: `${process.env.MAILTRAP_PASSWORD}`,
        },
    });

    const mailOptions = {
        from: '"Example Team" <from@example.com>',
        to: `${details.email}`,
        subject: "Job proposal acceptance notification",
        text: "Your job proposal has been accepted",
        html: `<b>Hey there! </b><br> Your have successfully submitted proposal<br>
  Job title: ${details.jobTitle}<br>
  Proposal id: ${details.proposalId}<br>`,
    };

    transport.sendMail(mailOptions, (error, info) => {
        if (error) {
            throw new BadRequestError("Internal Server Error", 500);
        }
    });
};
