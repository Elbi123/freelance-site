const nodemailer = require("nodemailer");
const BadRequestError = require("./error");

module.exports = sendEmail = (details) => {
    const transport = nodemailer.createTransport({
        host: "smtp.mailtrap.io",
        port: 2525,
        auth: {
            user: process.env.MAILTRAP_USER,
            pass: process.env.MAILTRAP_PASSWORD,
        },
    });

    const mailOptions = {
        from: '"Example Team" <from@example.com>',
        to: `${details.email}`,
        subject: "Job submission notification",
        text: "You have submitted proposal for the job",
        html: `<b>Hey there! </b><br> You have successfully submitted proposal<br>
    Job title: ${details.jobTitle}<br>
    Proposal id: ${details.proposalId}<br>`,
    };

    transport.sendMail(mailOptions, (error, info) => {
        throw new BadRequestError("Internal Server Error", 500);
    });
};
