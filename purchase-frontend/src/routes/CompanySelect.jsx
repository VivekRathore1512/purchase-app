// src/routes/CompanySelect.jsx
import React, { useContext, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { AppContext } from "../App";
import api from "../utils/api";

export default function CompanySelect() {
  const { setCompany } = useContext(AppContext);
  const [companies, setCompanies] = useState([]);
  const [selected, setSelected] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const nav = useNavigate();

  useEffect(() => {
    const fetchCompanies = async () => {
      try {
        const res = await api.get("/company");
        const data = res.data;

        if (data.length === 0) {
          setError("No companies found. Please add a company first.");
          setLoading(false);
          return;
        }

        setCompanies(data);
        setSelected(data[0].id); // Default first company select
      } catch (err) {
        console.error(err);
        setError("Failed to load companies. Is backend running?");
      } finally {
        setLoading(false);
      }
    };

    fetchCompanies();
  }, []);

  const handleContinue = () => {
    const selectedCompany = companies.find((c) => c.id === Number(selected));
    if (selectedCompany) {
      setCompany({
        id: selectedCompany.id,
        name: selectedCompany.company_name, // Dashboard mein name dikhane ke liye
        ...selectedCompany,
      });
      nav("/dashboard");
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-100">
        <p className="text-lg">Loading companies...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-100 px-4">
        <div className="bg-white p-6 rounded-lg shadow text-center">
          <p className="text-red-600 mb-4">{error}</p>
          <button
            onClick={() => window.location.reload()}
            className="px-4 py-2 bg-primary text-white rounded"
          >
            Retry
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100 px-4">
      <div className="w-full max-w-md bg-white rounded-2xl shadow-lg p-8">
        {/* Icon */}
        <div className="flex justify-center mb-4">
          <div className="w-12 h-12 rounded-full bg-blue-800 flex items-center justify-center">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="w-6 h-6 text-white"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth="1.5"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M3 21h18M5 21V7l7-4 7 4v14M9 21v-6h6v6"
              />
            </svg>
          </div>
        </div>

        <h2 className="text-center text-blue-800 text-lg font-semibold">
          Select Company
        </h2>
        <p className="text-center text-gray-500 text-sm mb-6">
          Choose your workspace
        </p>

        {/* Company Dropdown */}
        <div className="mb-6">
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Choose your company
          </label>
          <select
            className="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-700"
            value={selected}
            onChange={(e) => setSelected(e.target.value)}
          >
            {companies.map((c) => (
              <option key={c.id} value={c.id}>
                {c.company_name}
              </option>
            ))}
          </select>
        </div>

        {/* Continue Button */}
        <button
          onClick={handleContinue}
          className="w-full bg-blue-800 text-white py-2.5 rounded-lg font-medium hover:bg-blue-900 transition"
        >
          Continue
        </button>

        {/* Note */}
        <div className="mt-6 bg-gray-100 text-gray-600 text-xs rounded-lg p-3 text-center">
          <strong>Note:</strong> If another session is detected for this
          company, you will be automatically logged out.
        </div>
      </div>
    </div>
  );
}