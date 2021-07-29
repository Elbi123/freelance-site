module.exports = helpQuery = async (data, model, job) => {
    let ids = [];
    for (let i = 0; i < data.length; i++) {
        const query = await model.findOne({
            name: data[i],
        });
        if (!query) {
            // new doc
            const newDoc = new model({ name: data[i] });
            newDoc.jobs.push(job._id);
            ids.push(newDoc._id);

            // save the new one
            await newDoc.save();
        } else {
            ids.push(query._id);
            query.jobs.push(job._id);

            // save skill here
            await query.save();
        }
    }
    return ids;
};
