// routes/purchase.routes.js (updated)
const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

router.post("/add", async (req, res) => {
  const { purchase, items } = req.body;

  if (!purchase || !items || items.length === 0) {
    return res.status(400).json({ message: "Purchase and items are required" });
  }

  // Validation: हर item में subcategory_id होना चाहिए
  if (!items.every((item) => item.subcategory_id)) {
    return res
      .status(400)
      .json({ message: "Subcategory is required for each item" });
  }

  try {
    await db.query("START TRANSACTION");

    const [purchaseResult] = await db.query(
      "INSERT INTO purchases (purchase_date, total_amount, company_id, user_id) VALUES (?, ?, ?, ?)",
      [
        purchase.purchase_date || new Date().toISOString().split("T")[0],
        purchase.total_amount,
        purchase.company_id,
        req.user.id, // user_id add किया (security के लिए)
      ]
    );

    const purchaseId = purchaseResult.insertId;

    // Item values with subcategory_id
    const itemValues = items.map((item) => [
      purchaseId,
      item.category_id,
      item.subcategory_id, // नया column
      item.defect_id || null,
      item.quantity,
      item.price_per_unit,
      item.subtotal || item.quantity * item.price_per_unit,
    ]);

    await db.query(
      `INSERT INTO purchase_items 
       (purchase_id, category_id, subcategory_id, defect_id, quantity, price_per_unit, subtotal) 
       VALUES ?`,
      [itemValues]
    );

    await db.query("COMMIT");

    res.json({
      message: "Purchase saved successfully",
      purchase_id: purchaseId,
    });
  } catch (err) {
    await db.query("ROLLBACK");
    console.error("Error saving purchase:", err);
    res.status(500).json({ message: "Failed to save purchase" });
  }
});

// GET remains same
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT p.*, c.company_name 
      FROM purchases p 
      LEFT JOIN companies c ON p.company_id = c.id 
      ORDER BY p.created_at DESC
    `);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching purchases:", err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
