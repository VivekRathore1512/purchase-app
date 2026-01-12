// src/routes/Dashboard.jsx
import React, { useContext } from "react";
import { Link, Routes, Route, useNavigate } from "react-router-dom";
import Categories from "./Categories";
import Defects from "./Defects";
import Purchase from "./Purchase";
import RecentPurchases from "./RecentPurchases";
import Reports from "./Reports";
import { AppContext } from "../App";

export default function Dashboard() {
  const { company, logout, triggerAutoLogout } = useContext(AppContext);
  const nav = useNavigate();

  const doLogout = () => {
    logout();
    nav("/login");
  };

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Header */}
      <header className="bg-white shadow px-6 py-4 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-blue-700 rounded-lg flex items-center justify-center text-white text-xl">
            🛒
          </div>
          <div>
            <div className="font-semibold text-blue-700">
              {company?.company_name || "Loading Company..."}
            </div>
            <div className="text-xs text-gray-500">Purchase Management</div>
          </div>
        </div>

        <div className="flex gap-3">
          <button
            onClick={triggerAutoLogout}
            className="text-xs border px-3 py-1 rounded"
          >
            Simulate Session
          </button>
          <button
            onClick={doLogout}
            className="bg-blue-700 text-white px-4 py-1 rounded"
          >
            Logout
          </button>
        </div>
      </header>

      {/* Main Content */}
      <main className="p-4 sm:p-6">
        {/* ================= QUICK ACCESS CARDS ================= */}

        {/* Row 1 */}
        <div className="grid grid-cols-2 gap-4 mb-4">
          {/* New Purchase */}
          <Link
            to="purchase"
            className="bg-white rounded-xl shadow p-4 sm:p-6 flex gap-4 hover:shadow-md"
          >
            <div className="w-12 h-12 bg-green-700 rounded-lg flex items-center justify-center text-white text-xl">
              ➕
            </div>
            <div>
              <div className="font-semibold">New Purchase</div>
              <div className="text-sm text-gray-500">Record a new purchase</div>
            </div>
          </Link>

          {/* Reports */}
          <Link
            to="reports"
            className="bg-white rounded-xl shadow p-4 sm:p-6 flex gap-4 hover:shadow-md"
          >
            <div className="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center text-white text-xl">
              📊
            </div>
            <div>
              <div className="font-semibold">Reports</div>
              <div className="text-sm text-gray-500">
                View analytics and reports
              </div>
            </div>
          </Link>
        </div>

        {/* Row 2 */}
        <div className="grid grid-cols-2 gap-4 mb-6">
          {/* Categories */}
          <Link
            to="categories"
            className="bg-white rounded-xl shadow p-4 sm:p-6 flex gap-4 hover:shadow-md"
          >
            <div className="w-12 h-12 bg-purple-700 rounded-lg flex items-center justify-center text-white text-xl">
              📂
            </div>
            <div>
              <div className="font-semibold">Categories</div>
              <div className="text-sm text-gray-500">
                Manage product categories
              </div>
            </div>
          </Link>

          {/* Defects */}
          <Link
            to="defects"
            className="bg-white rounded-xl shadow p-4 sm:p-6 flex gap-4 hover:shadow-md"
          >
            <div className="w-12 h-12 bg-teal-700 rounded-lg flex items-center justify-center text-white text-xl">
              ⚠️
            </div>
            <div>
              <div className="font-semibold">Defects</div>
              <div className="text-sm text-gray-500">Manage defect types</div>
            </div>
          </Link>
        </div>

        {/* ================= RECENT PURCHASES ================= */}
        <div className="bg-white rounded-xl shadow p-4 sm:p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-semibold flex items-center gap-2">
              🕒 Recent Purchases
            </h2>
            <Link to="recent" className="text-blue-700 text-sm">
              View All
            </Link>
          </div>

          {/* Nested Routes */}
          <Routes>
            <Route path="/" element={<RecentPurchases />} />
            <Route path="purchase" element={<Purchase />} />
            <Route path="reports" element={<Reports />} />
            <Route path="categories" element={<Categories />} />
            <Route path="defects" element={<Defects />} />
            <Route path="recent" element={<RecentPurchases />} />
          </Routes>
        </div>
      </main>
    </div>
  );
}
