const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM categories ORDER BY name");
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

router.post("/add", async (req, res) => {
  const { name } = req.body;

  if (!name) {
    return res.status(400).json({ message: "Category name is required" });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO categories (name) VALUES (?)",
      [name]
    );

    res.json({ message: "Category added", id: result.insertId });
  } catch (err) {
    if (err.code === "ER_DUP_ENTRY") {
      return res.status(400).json({ message: "Category already exists" });
    }
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
