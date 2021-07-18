const User = require("./../models/user.model");
const Role = require("./../models/role.model");
const BadRequestError = require("./../utils/error");

exports.checkIfRoleExists = async (req, res, next) => {
    if (req.body.roles) {
        for (let i = 0; i < req.body.roles.length; i++) {
            const role = await Role.findOne({ name: req.body.roles[i] });
            if (!role) {
                next(
                    new BadRequestError(
                        `Role ${req.body.roles[i]} doesn't exist`
                    )
                );
            }
        }
    } else {
        req.body.roles = ["user"];
    }
    const user = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        userName: req.body.userName,
        email: req.body.email,
        password: req.body.password,
        passwordConfirm: req.body.passwordConfirm,
        phoneNumber: req.body.phoneNumber,
        img: req.body.img,
        roles: req.body.roles,
    };
    req.body = user;
    next();
};

exports.signup = async (req, res) => {
    let body = { ...req.body };
    delete body.roles;

    const userRoles = req.body.roles;

    let newUser = new User(body);

    await Role.find({ name: { $in: userRoles } }, async (err, roles) => {
        if (err) {
            res.json({
                res,
            });
        }
        newUser.roles = roles.map((role) => role._id);
    });

    await newUser.save().then((user) => {
        res.json({
            user,
        });
    });
};

exports.getUsers = async (req, res) => {
    await User.find({}, (err, users) => {
        res.json({
            users,
        });
    });
};
