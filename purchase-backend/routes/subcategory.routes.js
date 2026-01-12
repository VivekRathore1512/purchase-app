// routes/subcategory.routes.js
const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

// GET subcategories by category_id
router.get("/:category_id", async (req, res) => {
  const { category_id } = req.params;

  try {
    const [rows] = await db.query(
      "SELECT id, name FROM subcategories WHERE category_id = ? ORDER BY name",
      [category_id]
    );
    res.json(rows);
  } catch (err) {
    console.error("Error fetching subcategories:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// POST add new subcategory
router.post("/add", async (req, res) => {
  const { name, category_id } = req.body;

  if (!name || !category_id) {
    return res
      .status(400)
      .json({ message: "Name and category_id are required" });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO subcategories (name, category_id) VALUES (?, ?)",
      [name.trim(), category_id]
    );

    res.json({ message: "Subcategory added", id: result.insertId });
  } catch (err) {
    if (err.code === "ER_DUP_ENTRY") {
      return res
        .status(400)
        .json({ message: "Subcategory already exists in this category" });
    }
    console.error("Error adding subcategory:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// Optional: DELETE subcategory (अगर frontend में delete चाहिए)
router.delete("/:id", async (req, res) => {
  try {
    await db.query("DELETE FROM subcategories WHERE id = ?", [req.params.id]);
    res.json({ message: "Subcategory deleted" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;