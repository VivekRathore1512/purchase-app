// server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

// Public route (no auth needed)
app.use("/api/auth", require("./routes/auth.routes"));

// Protected routes
app.use("/api/company", require("./routes/company.routes"));
app.use("/api/category", require("./routes/category.routes"));
app.use("/api/defect", require("./routes/defect.routes"));
app.use("/api/purchase", require("./routes/purchase.routes"));
app.use("/api/reports", require("./routes/reports.routes"));
app.use("/api/subcategory", require("./routes/subcategory.routes"));

app.get("/", (req, res) => {
  res.json({ message: "Purchase Backend API Running! 🚀" });
});

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
