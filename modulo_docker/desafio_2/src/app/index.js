const express = require("express");
const path = require("path");
const app = express();
const port = process.env.APP_PORT ?? 3005;

const users = [];

app.use("/", express.static(path.resolve(__dirname, "html")));

app.get("/add-user", (req, res) => {
  const { name } = req.query;
  users.push(name);
  res.json(users);
});

app.get("/list-users", (req, res) => {
  res.json(users);
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
