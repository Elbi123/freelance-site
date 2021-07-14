exports.getAllJobs = (req, res) => {
    res.status(200).json({
        message: "GET ALL JOB HERE",
    });
};

exports.getJobBySlug = (req, res) => {
    res.status(200).json({
        message: "GET JOB BY SLUG",
    });
};

exports.createJob = (req, res) => {
    res.status(200).json({
        message: "CREATE JOB MAN",
    });
};

exports.updateJob = (req, res) => {
    res.status(200).json({
        message: "UPDATE JOB MAN",
    });
};

exports.deleteJob = (req, res) => {
    res.status(200).json({
        message: "DELETE JOB MAN",
    });
};
