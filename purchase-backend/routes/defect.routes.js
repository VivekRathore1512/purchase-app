// routes/defect.routes.js (FINAL FIXED VERSION)
const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

// GET defects by SUBCATEGORY_ID (ये change जरूरी है)
router.get("/:subcategory_id", async (req, res) => {
  const { subcategory_id } = req.params;

  try {
    const [rows] = await db.query(
      "SELECT id, name FROM defects WHERE subcategory_id = ? ORDER BY name",
      [subcategory_id]
    );
    res.json(rows);
  } catch (err) {
    console.error("Error fetching defects:", err);
    res.status(500).json({ message: "Server error fetching defects" });
  }
});

// ADD new defect (subcategory_id के साथ)
router.post("/add", async (req, res) => {
  const { name, subcategory_id } = req.body;

  if (!name || !subcategory_id) {
    return res
      .status(400)
      .json({ message: "Name and subcategory_id are required" });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO defects (name, subcategory_id) VALUES (?, ?)",
      [name.trim(), subcategory_id]
    );

    res.json({ message: "Defect added successfully", id: result.insertId });
  } catch (err) {
    if (err.code === "ER_DUP_ENTRY") {
      return res
        .status(400)
        .json({ message: "This defect already exists in subcategory" });
    }
    console.error("Error adding defect:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// Optional: DELETE defect (अगर Defects page में delete button है)
router.delete("/:id", async (req, res) => {
  try {
    await db.query("DELETE FROM defects WHERE id = ?", [req.params.id]);
    res.json({ message: "Defect deleted" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
