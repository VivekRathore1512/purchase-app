// routes/reports.routes.js
const router = require("express").Router();
const db = require("../config/db");
const auth = require("../middleware/auth");

router.use(auth);

router.get("/", async (req, res) => {
  const { from, to, category = "all" } = req.query;

  if (!from || !to) {
    return res.status(400).json({ message: "From and to dates are required" });
  }

  try {
    let query = `
      SELECT 
        COUNT(DISTINCT p.id) AS purchases,
        COALESCE(SUM(pi.quantity), 0) AS quantity,
        COALESCE(SUM(pi.subtotal), 0) AS amount
      FROM purchases p
      JOIN purchase_items pi ON p.id = pi.purchase_id
      WHERE p.purchase_date BETWEEN ? AND ?
    `;
    let params = [from, to];

    if (category !== "all") {
      query += ` AND pi.category_id = (SELECT id FROM categories WHERE name = ?)`;
      params.push(category);
    }

    const [rows] = await db.query(query, params);

    res.json({
      purchases: rows[0].purchases || 0,
      quantity: rows[0].quantity || 0,
      amount: rows[0].amount || 0,
    });
  } catch (err) {
    console.error("Reports error:", err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;