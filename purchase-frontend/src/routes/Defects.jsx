// src/routes/Defects.jsx (UPDATED - subcategory based)
import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function Defects() {
  const [categories, setCategories] = useState([]);
  const [subcategories, setSubcategories] = useState([]);
  const [catId, setCatId] = useState("");
  const [subcatId, setSubcatId] = useState("");
  const [defects, setDefects] = useState([]);
  const [show, setShow] = useState(false);
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get("/category");
        setCategories(res.data);
        if (res.data.length > 0) setCatId(res.data[0].id);
      } catch (err) {
        alert("Failed to load categories");
      } finally {
        setLoading(false);
      }
    };
    fetchCategories();
  }, []);

  // Load subcategories when category changes
  useEffect(() => {
    if (!catId) {
      setSubcategories([]);
      setSubcatId("");
      return;
    }
    const fetchSubcats = async () => {
      try {
        const res = await api.get(`/subcategory/${catId}`);
        setSubcategories(res.data);
        if (res.data.length > 0) setSubcatId(res.data[0].id);
        else setSubcatId("");
      } catch (err) {
        console.error(err);
      }
    };
    fetchSubcats();
  }, [catId]);

  // Load defects when subcategory changes
  useEffect(() => {
    if (!subcatId) {
      setDefects([]);
      return;
    }
    const fetchDefects = async () => {
      try {
        const res = await api.get(`/defect/${subcatId}`);
        setDefects(res.data);
      } catch (err) {
        console.error(err);
      }
    };
    fetchDefects();
  }, [subcatId]);

  const addDefect = async () => {
    if (!name.trim()) return alert("Defect name required");
    if (!subcatId) return alert("Select subcategory first");

    try {
      await api.post("/defect/add", {
        name: name.trim(),
        subcategory_id: subcatId,
      });
      setName("");
      setShow(false);
      // Reload defects
      const res = await api.get(`/defect/${subcatId}`);
      setDefects(res.data);
      alert("Defect added!");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to add defect");
    }
  };

  if (loading) return <div>Loading...</div>;

  const deleteDefect = async (defectId) => {
    if (!window.confirm("Are you sure you want to delete this defect?")) return;

    try {
      await api.delete(`/defect/${defectId}`);

      // UI update (page reload nahi hoga)
      setDefects(defects.filter((d) => d.id !== defectId));

      alert("Defect deleted successfully");
    } catch (err) {
      alert(err.response?.data?.message || "Failed to delete defect");
    }
  };


  return (
    <div className="max-w-4xl mx-auto p-6">
      <h2 className="text-3xl font-bold mb-6">Manage Defects</h2>

      {/* Category & Subcategory Select */}
      <div className="mb-6 flex gap-4">
        <select
          value={catId}
          onChange={(e) => setCatId(e.target.value)}
          className="p-3 border rounded-lg"
        >
          <option value="">Select Category</option>
          {categories.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>

        <select
          value={subcatId}
          onChange={(e) => setSubcatId(e.target.value)}
          disabled={!catId}
          className="p-3 border rounded-lg"
        >
          <option value="">Select Subcategory</option>
          {subcategories.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}
            </option>
          ))}
        </select>
      </div>

      {/* Defects List */}
      {subcatId && (
        <>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-xl font-semibold">
              Defects for selected subcategory
            </h3>
            <button
              onClick={() => setShow(true)}
              className="bg-primary text-white px-4 py-2 rounded"
            >
              Add Defect
            </button>
          </div>

          {defects.length === 0 ? (
            <p>No defects found. Add one!</p>
          ) : (
            <ul className="space-y-2">
              {defects.map((d) => (
                <li
                  key={d.id}
                  className="bg-gray-50 p-3 rounded flex justify-between items-center"
                >
                  <span>{d.name}</span>

                  <button
                    onClick={() => deleteDefect(d.id)}
                    className="text-red-600 hover:text-red-800 text-sm"
                  >
                    Delete
                  </button>
                </li>
              ))}
            </ul>
          )}
        </>
      )}

      {defects.length === 0 && subcatId && (
        <p className="text-red-500 text-sm mt-2 bg-red-50 p-2 rounded border border-red-200">
          ⚠️ No defects available for this subcategory. Go to Defects page to
          add some.
        </p>
      )}

      {/* Add Modal */}
      {show && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center">
          <div className="bg-white p-6 rounded-lg">
            <h3 className="text-lg font-bold mb-4">Add New Defect</h3>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Defect name"
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
                onClick={addDefect}
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