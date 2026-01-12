// src/routes/Purchase.jsx
import React, { useState, useEffect, useContext, useRef } from "react";
import api from "../utils/api";
import { AppContext } from "../App";
import { createWorker } from "tesseract.js";

export default function Purchase() {
  const { company } = useContext(AppContext);

  const [categories, setCategories] = useState([]);
  const [subcategories, setSubcategories] = useState([]);
  const [defects, setDefects] = useState([]);

  const [catId, setCatId] = useState("");
  const [subcatId, setSubcatId] = useState("");
  const [defId, setDefId] = useState("");

  const [qty, setQty] = useState("");
  const [unit, setUnit] = useState("kg");
  const [price, setPrice] = useState("");
  const [total, setTotal] = useState("");
  const [lastChanged, setLastChanged] = useState("");

  const [loading, setLoading] = useState(true);
  const [scanning, setScanning] = useState(false);
  const [error, setError] = useState("");

  const videoRef = useRef(null);
  const fileInputRef = useRef(null);
  const workerRef = useRef(null);

  /* ===== ✅ SAFE ADDITION (NO FLOW CHANGE) ===== */
  const getQtyForCalc = () => {
    const q = parseFloat(qty) || 0;
    if (unit === "quintal") return q * 100;
    if (unit === "ton") return q * 1000;
    return q; // kg
  };

  /* ===== Auto calculate Qty = Total / Price (UNIT SAFE) ===== */
  useEffect(() => {
    if (lastChanged === "qty") return;

    const t = parseFloat(total) || 0;
    const p = parseFloat(price) || 0;

    if (t > 0 && p > 0) {
      let baseQty = t / p; // qty in KG

      // convert back to selected unit
      if (unit === "quintal") baseQty = baseQty / 100;
      if (unit === "ton") baseQty = baseQty / 1000;

      setQty(baseQty.toFixed(2));
    }
  }, [total, price, unit, lastChanged]);

  /* ===== Auto calculate Qty = Total / Price (UNIT SAFE) ===== */
  useEffect(() => {
    if (lastChanged === "qty") return;

    const t = parseFloat(total) || 0;
    const p = parseFloat(price) || 0;

    if (t > 0 && p > 0) {
      let baseQty = t / p; // qty in KG

      if (unit === "quintal") baseQty = baseQty / 100;
      if (unit === "ton") baseQty = baseQty / 1000;

      setLastChanged("qty"); // ✅ IMPORTANT (loop break)
      setQty(baseQty.toFixed(2));
    }
  }, [total, price, unit, lastChanged]);

  /* ============================================ */

  // Fetch Categories
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get("/category");
        setCategories(res.data);
        if (res.data.length > 0) {
          setCatId(res.data[0].id);
        }
      } catch (err) {
        setError("Failed to load categories");
      } finally {
        setLoading(false);
      }
    };
    fetchCategories();
  }, []);

  // Fetch Subcategories
  useEffect(() => {
    if (!catId) {
      setSubcategories([]);
      setSubcatId("");
      return;
    }

    const fetchSubcategories = async () => {
      try {
        const res = await api.get(`/subcategory/${catId}`);
        setSubcategories(res.data);
        setSubcatId(res.data[0]?.id || "");
      } catch {
        setError("Failed to load subcategories");
      }
    };
    fetchSubcategories();
  }, [catId]);

  // Fetch Defects
  useEffect(() => {
    if (!subcatId) {
      setDefects([]);
      setDefId("");
      return;
    }

    const fetchDefects = async () => {
      try {
        const res = await api.get(`/defect/${subcatId}`);
        setDefects(res.data);
        setDefId(res.data[0]?.id || "");
      } catch {
        setError("Failed to load defects");
      }
    };
    fetchDefects();
  }, [subcatId]);

  /* ===== Auto calculate Total = Qty × Price (UNIT SAFE) ===== */
  useEffect(() => {
    if (lastChanged === "total") return;
    const q = getQtyForCalc();
    const p = parseFloat(price) || 0;
    if (q > 0 && p > 0) {
      setTotal((q * p).toFixed(2));
    }
  }, [qty, price, unit, lastChanged]);

  /* ===== Auto calculate Price = Total / Qty (UNIT SAFE) ===== */
  useEffect(() => {
    if (lastChanged === "qty" || lastChanged === "price") return;
    const t = parseFloat(total) || 0;
    const q = getQtyForCalc();
    if (t > 0 && q > 0) {
      setPrice((t / q).toFixed(2));
    }
  }, [total, qty, unit, lastChanged]);

  const savePurchase = async () => {
    if (!company?.id) return alert("Company not selected");
    if (!catId || !subcatId || !qty || !price || !total) {
      return alert("Please fill all required fields");
    }

    const purchase = {
      purchase_date: new Date().toISOString().split("T")[0],
      total_amount: parseFloat(total),
      company_id: company.id,
    };

    const items = [
      {
        category_id: Number(catId),
        subcategory_id: Number(subcatId),
        defect_id: defId ? Number(defId) : null,
        quantity: parseFloat(qty),
        price_per_unit: parseFloat(price),
        subtotal: parseFloat(total),
      },
    ];

    try {
      await api.post("/purchase/add", { purchase, items });
      alert("Purchase saved successfully!");

      setQty("");
      setPrice("");
      setTotal("");
      setDefId("");
      setLastChanged("");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to save purchase");
    }
  };

  if (loading)
    return (
      <div className="text-center py-10 text-gray-600">Loading form...</div>
    );

 return (
   <div className="w-full max-w-4xl mx-auto bg-white rounded-xl shadow-lg p-6">
     <h2 className="text-2xl font-bold mb-6 text-center">Add New Purchase</h2>

     {error && <p className="text-red-600 text-center mb-4">{error}</p>}

     {/* Category */}
     <div className="mb-4">
       <label className="block text-sm font-medium text-gray-700 mb-2">
         Category <span className="text-red-500">*</span>
       </label>
       <select
         value={catId}
         onChange={(e) => setCatId(e.target.value)}
         className="w-full p-3 border border-gray-300 rounded-lg"
       >
         <option value="">Select Category</option>
         {categories.map((c) => (
           <option key={c.id} value={c.id}>
             {c.name}
           </option>
         ))}
       </select>
     </div>

     {/* Subcategory */}
     <div className="mb-4">
       <label className="block text-sm font-medium text-gray-700 mb-2">
         Subcategory <span className="text-red-500">*</span>
       </label>
       <select
         value={subcatId}
         onChange={(e) => setSubcatId(e.target.value)}
         disabled={!catId}
         className="w-full p-3 border border-gray-300 rounded-lg"
       >
         <option value="">Select Subcategory</option>
         {subcategories.map((s) => (
           <option key={s.id} value={s.id}>
             {s.name}
           </option>
         ))}
       </select>
     </div>

     {/* Defect */}
     <div className="mb-4">
       <label className="block text-sm font-medium text-gray-700 mb-2">
         Defect Type (Optional)
       </label>
       <select
         value={defId}
         onChange={(e) => setDefId(e.target.value)}
         disabled={!subcatId}
         className="w-full p-3 border border-gray-300 rounded-lg"
       >
         <option value="">No Defect</option>
         {defects.map((d) => (
           <option key={d.id} value={d.id}>
             {d.name}
           </option>
         ))}
       </select>
     </div>

     {/* Quantity + Unit */}
     <div className="mb-4 flex gap-3">
       <input
         type="text"
         placeholder="Quantity"
         value={qty}
         onChange={(e) => {
           setQty(e.target.value);
           setLastChanged("qty");
         }}
         className="flex-1 p-3 border rounded-lg"
       />
       <select
         value={unit}
         onChange={(e) => setUnit(e.target.value)}
         className="w-32 p-3 border rounded-lg"
       >
         <option value="kg">kg</option>
         <option value="quintal">Quintal</option>
         <option value="ton">Ton</option>
       </select>
     </div>

     {/* Price */}
     <input
       type="text"
       placeholder="Price per Unit (₹)"
       value={price}
       onChange={(e) => {
         setPrice(e.target.value);
         setLastChanged("price");
       }}
       className="w-full p-3 border rounded-lg mb-4"
     />

     {/* Total */}
     <input
       type="text"
       placeholder="Total Amount (₹)"
       value={total}
       onChange={(e) => {
         setTotal(e.target.value);
         setLastChanged("total");
       }}
       className="w-full p-3 border rounded-lg font-bold text-xl bg-gray-50 mb-6"
     />

     <button
       onClick={savePurchase}
       className="w-full py-4 bg-green-600 text-white rounded-lg text-xl font-semibold"
     >
       Save Purchase
     </button>
   </div>
 );
}
