const User = require("../models/user.model");
const Freelancer = require("../models/freelancer.model");
const Image = require("../models/image.model");
const BadRequestError = require("../utils/error");
const catchAsync = require("../utils/catchAsync");
const multer = require("multer");

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
const upload = multer({ storage: storage, fileFilter: multerFilter }).single(
    "image"
);

exports.uploadFreelanceProfilePic = catchAsync(async (req, res, next) => {
    const username = req.params.username;
    const user = await User.findOne({ userName: username });
    if (!user) {
        return next(new BadRequestError("User Not Found", 404));
    }
    if (user.userType === "freelancer") {
        const freelancer = await Freelancer.findOne({ _id: user.freelancer });
        if (!freelancer) {
            return next(new BadRequestError("Freelancer Not Found", 404));
        }
        if (freelancer.image) {
            return next(new BadRequestError("Image already uploaded", 401));
        } else {
            upload(req, res, async (err) => {
                const imagePath = req.file.path;
                if (!req.file) {
                    return next(
                        new BadRequestError("Please Upload Image", 401)
                    );
                }
                if (err instanceof multer.MulterError) {
                    return next(
                        new BadRequestError(
                            "A Multer error occurred when uploading",
                            401
                        )
                    );
                } else if (err) {
                    return next(
                        new BadRequestError("Internal Server Error", 500)
                    );
                }

                const newImage = new Image({
                    path: imagePath,
                });

                await Freelancer.updateOne(
                    { _id: user.freelancer },
                    { image: newImage._id }
                );
                await newImage.save((err) => {
                    if (err) {
                        next(new BadRequestError("Internal Server Error", 500));
                    }
                    res.status(200).json({
                        status: "success",
                        message: "Image uploaded",
                    });
                });
            });
        }
    } else {
        return next(
            new BadRequestError("You should register as freelancer", 403)
        );
    }
});
