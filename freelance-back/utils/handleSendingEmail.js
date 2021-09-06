const nodemailer = require("nodemailer");
const BadRequestError = require("./error");

const transport = nodemailer.createTransport({
    host: "smtp.mailtrap.io",
    port: 2525,
    auth: {
        user: process.env.MAILTRAP_USER,
        pass: process.env.MAILTRAP_PASSWORD,
    },
});

exports.sendEmail = (details) => {
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

exports.sendTicketEmail = (details) => {
    const mailOptions = {
        from: '"Example Team" <from@example.com>',
        to: `${details.email}`,
        subject: "Submitted Report",
        text: "You have submitted complaint report",
        html: `<b>
        Hey there! </b><br> You have successfully reported<br>
        Report ID: ${details.ticketId}<br>
        Report Status: ${details.status}<br>
        On User: ${details.username}<br>
        Your summary: ${details.summary}<br>
        `,
    };

    transport.sendMail(mailOptions, (error, info) => {
        throw new BadRequestError("Internal Server Error", 500);
    });
};
