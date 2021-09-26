const nodemailer = require("nodemailer");
const BadRequestError = require("./error");

exports.sendPasswordResetEmail = async (details) => {
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
        subject: `${details.subject}`,
        text: `${details.text}`,
    };

    await transport.sendMail(mailOptions, (error, info) => {
        if (error) {
            throw new BadRequestError("Internal Server Error", 500);
        }
    });
};
