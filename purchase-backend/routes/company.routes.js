const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM companies ORDER BY company_name"
    );
    res.json(rows);
  } catch (err) {
    console.error("Error fetching companies:", err);
    res.status(500).json({ message: "Server error" });
  }
});

router.post("/add", async (req, res) => {
  const { company_name, gst_number, phone, address } = req.body;

  if (!company_name) {
    return res.status(400).json({ message: "Company name is required" });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO companies (company_name, gst_number, phone, address) VALUES (?, ?, ?, ?)",
      [company_name, gst_number || null, phone || null, address || null]
    );

    res.json({ message: "Company added successfully", id: result.insertId });
  } catch (err) {
    console.error("Error adding company:", err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
