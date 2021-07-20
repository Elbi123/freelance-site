const dotenv = require("dotenv");
const connectDB = require("./config/db.config");

dotenv.config();

// db connection config
connectDB();

// express app
const app = require("./app");
const port = process.env.PORT || 8000;

app.listen(port, () => {
    // if (process.env.NODE_ENV === "development") {
    console.log(`App is listening on port ${port}`);
    // }
});
