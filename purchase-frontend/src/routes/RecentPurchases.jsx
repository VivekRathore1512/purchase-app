// src/routes/RecentPurchases.jsx
import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function RecentPurchases() {
  const [purchases, setPurchases] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPurchases = async () => {
      try {
        const res = await api.get("/purchase");
        // Latest 5 purchases (backend DESC order mein bhej raha hai)
        const last5 = res.data.slice(0, 5);
        setPurchases(last5);
      } catch (err) {
        console.error(err);
        alert("Failed to load recent purchases");
      } finally {
        setLoading(false);
      }
    };

    fetchPurchases();
  }, []);

  if (loading) {
    return (
      <div className="text-center py-8 text-gray-600">
        Loading recent purchases...
      </div>
    );
  }

  return (
    <div>
      <h4 className="text-lg font-semibold mb-4">Last 5 Purchases</h4>

      {purchases.length === 0 ? (
        <p className="text-center text-gray-500 py-10">
          No purchases yet. Add your first purchase to see it here!
        </p>
      ) : (
        <ul className="space-y-3">
          {purchases.map((p) => (
            <li
              key={p.id}
              className="p-4 border rounded bg-white shadow-sm flex justify-between items-center"
            >
              <div>
                <div className="font-medium">
                  {p.company_name || "Unknown Company"}
                </div>
                <div className="text-sm text-gray-500">
                  {new Date(p.purchase_date || p.created_at).toLocaleDateString(
                    "en-IN"
                  )}
                </div>
              </div>
              <div className="text-right">
                <div className="text-xl font-semibold">
                  ₹ {Number(p.total_amount).toFixed(2)}
                </div>
              </div>
            </li>
          ))}
        </ul>
      )}

      <div className="mt-6 text-center">
        <button className="px-4 py-2 border rounded hover:bg-gray-100">
          View All Purchases
        </button>
      </div>
    </div>
  );
}