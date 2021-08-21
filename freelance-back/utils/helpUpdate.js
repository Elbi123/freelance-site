const ObjectId = require("mongoose").Types.ObjectId;

const compuateSkill = (job, type) => {};

module.exports = helpUpdate = async (data, model, job, arr, type) => {
    let idSkill = [];

    for (let i = 0; i < data.length; i++) {
        const query = await model.findOne({
            name: data[i],
        });
        if (!query) {
            // create new skill
            const newSkill = new model({ name: data[i] });

            // add job to new skill
            if (type === "job") {
                newSkill.jobs.push(job._id);
            } else if (type === "freelancer") {
                newSkill.freelancers.push(job._id);
            }
            // add to idSkill array
            idSkill.push(ObjectId(newSkill._id).toString());

            // save new skill
            await newSkill.save();
        } else {
            // add job to skill
            if (type === "job") {
                const objectToString = query.jobs.map((el) => {
                    return ObjectId(el);
                });

                if (!objectToString.includes(ObjectId(job._id))) {
                    query.jobs.push(job._id);
                }
            } else if (type === "freelancer") {
                const objectToString = query.freelancers.map((el) => {
                    return ObjectId(el);
                });

                if (!objectToString.includes(ObjectId(job._id))) {
                    query.freelancers.push(job._id);
                }
            }

            // add if idSkill has no duplicate ids
            idSkill.push(ObjectId(query._id).toString());

            // save query
            await query.save();
        }
    }

    // loop the job skill for re-mapping the skill and job
    if (arr === "skills") {
        job.skills.forEach(async (skill) => {
            if (!idSkill.includes(ObjectId(skill).toString())) {
                // convert to ObjectId
                const skill_id = ObjectId(skill);

                // find if skill exists
                const uSkill = await model.findOne({ _id: skill_id });

                // return array with with new skill
                if (!uSkill) {
                    console.log("Doesn't work");
                }
                if (type === "job") {
                    const newSkillIds = uSkill.jobs.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.jobs = newSkillIds;
                } else if (type === "freelancer") {
                    const newSkillIds = uSkill.freelancers.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.freelancers = newSkillIds;
                }

                // save the skill
                await uSkill.save();
            }
        });
    } else if (arr === "experiences") {
        job.experiences.forEach(async (skill) => {
            if (!idSkill.includes(ObjectId(skill).toString())) {
                // convert to ObjectId
                const skill_id = ObjectId(skill);

                // find if skill exists
                const uSkill = await model.findOne({ _id: skill_id });

                // return array with with new skill
                if (!uSkill) {
                    console.log("Doesn't work");
                }
                if (type === "job") {
                    const newSkillIds = uSkill.jobs.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.jobs = newSkillIds;
                } else if (type === "freelancer") {
                    const newSkillIds = uSkill.freelancers.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.freelancers = newSkillIds;
                }

                // save the skill
                await uSkill.save();
            }
        });
    } else if (arr === "languages") {
        job.languages.forEach(async (skill) => {
            if (!idSkill.includes(ObjectId(skill).toString())) {
                // convert to ObjectId
                const skill_id = ObjectId(skill);

                // find if skill exists
                const uSkill = await model.findOne({ _id: skill_id });

                // return array with with new skill
                if (!uSkill) {
                    console.log("Doesn't work");
                }
                if (type === "job") {
                    const newSkillIds = uSkill.jobs.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.jobs = newSkillIds;
                } else if (type === "freelancer") {
                    const newSkillIds = uSkill.freelancers.filter((el) => {
                        return !el.equals(job._id);
                    });

                    // change the skill's job with the new job
                    uSkill.freelancers = newSkillIds;
                }

                // save the skill
                await uSkill.save();
            }
        });
    }

    return idSkill;
};
