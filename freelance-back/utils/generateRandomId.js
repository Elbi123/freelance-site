module.exports = () => {
    let id = "";
    let counter = 0;
    while (counter < 8) {
        let digit = Math.floor(Math.random() * 10);
        let toStr = digit.toString();
        id = id.concat(toStr);
        counter += 1;
    }

    return id;
};
