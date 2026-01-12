// src/routes/Subcategories.jsx
import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function Subcategories() {
  const [categories, setCategories] = useState([]);
  const [categoryId, setCategoryId] = useState("");
  const [subcategories, setSubcategories] = useState([]);
  const [show, setShow] = useState(false);
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(true);

  // Load categories
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get("/category");
        setCategories(res.data);
        if (res.data.length > 0) {
          setCategoryId(res.data[0].id);
        }
      } catch (err) {
        alert("Failed to load categories");
        console.error(err);
      } finally {
        setLoading(false);
      }
    };
    fetchCategories();
  }, []);

  // Load subcategories when category changes
  useEffect(() => {
    if (!categoryId) return;

    const fetchSubcategories = async () => {
      try {
        const res = await api.get(`/subcategory/${categoryId}`);
        setSubcategories(res.data);
      } catch (err) {
        alert("Failed to load subcategories");
        console.error(err);
      }
    };
    fetchSubcategories();
  }, [categoryId]);

  const addSubcategory = async () => {
    if (!name.trim() || !categoryId) return;

    try {
      const res = await api.post("/subcategory/add", {
        name: name.trim(),
        category_id: categoryId,
      });

      // New subcategory list mein add
      setSubcategories((prev) => [
        ...prev,
        { id: res.data.id, name: name.trim() },
      ]);

      setName("");
      setShow(false);
      alert("Subcategory added successfully!");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to add subcategory");
    }
  };

  if (loading) {
    return <div className="text-center py-10 text-gray-600">Loading...</div>;
  }

  const currentCategoryName =
    categories.find((c) => c.id === Number(categoryId))?.name || "";

  return (
    <div className="p-6 bg-white rounded-lg shadow">
      <div className="flex items-center justify-between mb-6">
        <h2 className="text-xl font-semibold">Subcategories</h2>
        <button
          onClick={() => setShow(true)}
          className="px-4 py-2 bg-primary text-white rounded hover:opacity-90"
        >
          Add Subcategory
        </button>
      </div>

      {/* Category Selector */}
      <select
        value={categoryId}
        onChange={(e) => setCategoryId(e.target.value)}
        className="w-full p-3 border rounded mb-6"
      >
        {categories.map((cat) => (
          <option key={cat.id} value={cat.id}>
            {cat.name}
          </option>
        ))}
      </select>

      {/* Subcategories List */}
      {subcategories.length === 0 ? (
        <p className="text-center text-gray-500 py-10">
          No subcategories yet. Add one!
        </p>
      ) : (
        <ul className="space-y-3">
          {subcategories.map((sub) => (
            <li
              key={sub.id}
              className="p-4 border rounded bg-gray-50 flex justify-between items-center"
            >
              {sub.name}
              {/* Delete if needed */}
            </li>
          ))}
        </ul>
      )}

      {/* Add Modal */}
      {show && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/40 z-50">
          <div className="bg-white p-6 rounded-lg shadow-xl w-full max-w-sm">
            <h5 className="text-lg font-semibold mb-4">
              Add Subcategory for {currentCategoryName}
            </h5>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Subcategory name"
              className="w-full p-3 border rounded mb-4 focus:outline-none focus:ring-2 focus:ring-primary"
              autoFocus
            />
            <div className="flex justify-end gap-3">
              <button
                onClick={() => {
                  setShow(false);
                  setName("");
                }}
                className="px-4 py-2 border rounded hover:bg-gray-100"
              >
                Cancel
              </button>
              <button
                onClick={addSubcategory}
                className="px-4 py-2 bg-primary text-white rounded hover:opacity-90"
              >
                Save
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
