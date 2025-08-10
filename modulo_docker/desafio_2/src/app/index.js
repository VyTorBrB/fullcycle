const express = require("express");
const app = express();
const port = process.env.APP_PORT;

app.get("/", (_req, res) => {
  res.send("<h1>Full Cycle Rocks!</h1>");
});

// Add a test API route
app.get("/api/test", (_req, res) => {
  res.json({ message: "API is working!" });
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
