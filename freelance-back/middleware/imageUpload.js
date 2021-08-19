const multer = require("multer");
const BadRequestHandler = require("../utils/error");

exports.handleImageUpload = (req, res, next) => {
    // console.log(req.params);
};

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public");
    },
    filename: (req, file, cb) => {
        const fileExt = file.mimetype.split("/")[1];

        const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
        cb(null, `${file.fieldname}-${uniqueSuffix}.${fileExt}`);
    },
});

const multerFilter = (req, file, cb) => {
    const imageFormats = /jpg|jpeg|png/;
    const fileExt = file.mimetype.split("/")[1];
    const checkValidImageFormat = imageFormats.test(fileExt);

    if (checkValidImageFormat === true) {
        cb(null, true);
    } else {
        cb(new BadRequestHandler("Invalid image input", 401));
    }
};
const upload = multer({ storage: storage, fileFilter: multerFilter });

module.exports = upload;
