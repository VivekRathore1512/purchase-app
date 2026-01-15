// src/routes/Categories.jsx
import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function Categories() {
  const [categories, setCategories] = useState([]);
  const [categoryId, setCategoryId] = useState(""); // selected category
  const [subcategories, setSubcategories] = useState([]); // selected category ke subcategories

  const [show, setShow] = useState(false); // add category modal
  const [name, setName] = useState(""); // new category name
  const [loading, setLoading] = useState(true);

  // Load all categories
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get("/category");
        setCategories(res.data);

        if (res.data.length > 0) {
          setCategoryId(res.data[0].id.toString()); // default select first category
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

  // Load subcategories when selected category changes
  useEffect(() => {
    if (!categoryId) return;

    const fetchSubcategories = async () => {
      try {
        // Backend fetch
        const res = await api.get(`/subcategory/${categoryId}`);
        let subs = res.data;

        // Fallback if backend has no data
        const fallback = {
          2: [
            // Vegetables id
            { id: 101, name: "Tomato" },
            { id: 102, name: "Onion" },
            { id: 103, name: "Carrot" },
          ],
          3: [
            // Pulses id
            { id: 201, name: "Moong" },
            { id: 202, name: "Chana" },
            { id: 203, name: "Masoor" },
          ],
        };

        if (!subs || subs.length === 0) {
          subs = fallback[categoryId] || [];
        }

        setSubcategories(subs);
      } catch (err) {
        console.error(err);
        setSubcategories([]);
      }
    };

    fetchSubcategories();
  }, [categoryId]);

  // Add new category
  const addCategory = async () => {
    if (!name.trim()) return;

    try {
      const res = await api.post("/category/add", { name: name.trim() });

      setCategories((prev) => [
        ...prev,
        { id: res.data.id, name: name.trim() },
      ]);

      setName("");
      setShow(false);
      alert("Category added successfully!");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to add category");
    }
  };

  // Delete category
  const deleteCategory = async (id) => {
    if (!window.confirm("Are you sure you want to delete this category?"))
      return;

    try {
      await api.delete(`/category/${id}`);
      setCategories((prev) => prev.filter((c) => c.id !== id));
      alert("Category deleted successfully!");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to delete category");
    }
  };

  if (loading) {
    return (
      <div className="text-center py-10 text-gray-600">
        Loading categories...
      </div>
    );
  }

  return (
    <div className="space-y-6 p-6 bg-white rounded-lg shadow">
      {/* Header */}
      <div className="flex justify-between items-center">
        <h4 className="text-lg font-semibold">Categories</h4>
        <button
          onClick={() => setShow(true)}
          className="px-3 py-1 rounded bg-primary text-white"
        >
          Add New Category
        </button>
      </div>

      {/* Category Dropdown */}
      <select
        value={categoryId}
        onChange={(e) => setCategoryId(e.target.value)}
        className="w-full p-3 border rounded"
      >
        {categories.map((cat) => (
          <option key={cat.id} value={cat.id.toString()}>
            {cat.name}
          </option>
        ))}
      </select>

      {/* Subcategory Dropdown */}
      <select className="w-full p-3 border rounded">
        {subcategories.length === 0 ? (
          <option>No subcategories</option>
        ) : (
          subcategories.map((sub) => (
            <option key={sub.id} value={sub.id}>
              {sub.name}
            </option>
          ))
        )}
      </select>

      {/* Category List */}
      <ul className="space-y-2">
        {categories.map((c) => (
          <li
            key={c.id}
            className="p-3 border rounded bg-white shadow-sm flex justify-between items-center"
          >
            <span>{c.name}</span>
            <button
              onClick={() => deleteCategory(c.id)}
              className="px-3 py-1 text-sm bg-red-600 text-white rounded hover:bg-red-700"
            >
              Delete
            </button>
          </li>
        ))}
      </ul>

      {/* Add Modal */}
      {show && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/40 z-50">
          <div className="bg-white p-6 rounded-lg shadow-xl w-full max-w-sm">
            <h5 className="text-lg font-semibold mb-4">Add New Category</h5>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Category name"
              className="w-full p-3 border rounded mb-4"
              autoFocus
            />
            <div className="flex justify-end gap-3">
              <button
                onClick={() => {
                  setShow(false);
                  setName("");
                }}
                className="px-4 py-2 border rounded"
              >
                Cancel
              </button>
              <button
                onClick={addCategory}
                className="px-4 py-2 bg-primary text-white rounded"
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