// src/routes/Categories.jsx
import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function Categories() {
  const [categories, setCategories] = useState([]);
  const [show, setShow] = useState(false);
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get("/category");
        setCategories(res.data);
      } catch (err) {
        alert("Failed to load categories");
        console.error(err);
      } finally {
        setLoading(false);
      }
    };
    fetchCategories();
  }, []);

  const addCategory = async () => {
    if (!name.trim()) return;

    try {
      const res = await api.post("/category/add", { name: name.trim() });

      // New category ko list mein add kar do
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

  if (loading) {
    return (
      <div className="text-center py-10 text-gray-600">
        Loading categories...
      </div>
    );
  }

  const deleteCategory = async (id) => {
    if (!window.confirm("Are you sure you want to delete this category?")) {
      return;
    }

    try {
      await api.delete(`/category/${id}`);

      // UI se bhi remove kar do
      setCategories((prev) => prev.filter((c) => c.id !== id));

      alert("Category deleted successfully!");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to delete category");
    }
  };


  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <h4 className="text-lg font-semibold">Categories</h4>
        <button
          onClick={() => setShow(true)}
          className="px-3 py-1 rounded bg-primary text-white"
        >
          Add New Category
        </button>
      </div>

      {categories.length === 0 ? (
        <p className="text-center text-gray-500 py-10">
          No categories found. Add one to get started!
        </p>
      ) : (
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
      )}

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
                onClick={addCategory}
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
