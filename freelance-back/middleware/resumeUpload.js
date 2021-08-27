const multer = require("multer");
const BadRequestHandler = require("../utils/error");

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "resume");
    },
    filename: (req, file, cb) => {
        const fileExt = file.mimetype.split("/")[1];

        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        cb(null, `${file.fieldname}-${uniqueSuffix}.${fileExt}`);
    },
});

const multerFilter = (req, file, cb) => {
    const imageFormats = /pdf|docx/;
    const fileExt = file.mimetype.split("/")[1];
    const checkValidImageFormat = imageFormats.test(fileExt);

    if (checkValidImageFormat === true) {
        cb(null, true);
    } else {
        cb(new BadRequestHandler("Invalid file input", 401));
    }
};
const upload = multer({ storage: storage, fileFilter: multerFilter }).single(
    "resume"
);

module.exports = upload;
