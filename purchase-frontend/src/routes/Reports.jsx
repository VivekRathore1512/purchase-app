import React, { useState, useEffect } from "react";
import api from "../utils/api";

export default function Reports() {
  const [range, setRange] = useState("monthly");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [category, setCategory] = useState("all");

  const [summary, setSummary] = useState({
    purchases: 0,
    quantity: "0 kg",
    amount: "0.00", // ₹ hata diya
  });

  const [loading, setLoading] = useState(true);
  const [hasData, setHasData] = useState(false);

  const timePeriods = [
    "Weekly",
    "Monthly",
    "Quarterly",
    "Half yearly",
    "Yearly",
  ];

  const getDateRange = (type) => {
    const today = new Date();
    let from = new Date();
    let to = new Date();

    if (type === "weekly") {
      from.setDate(today.getDate() - 6);
    } else if (type === "monthly") {
      from = new Date(today.getFullYear(), today.getMonth(), 1);
    } else if (type === "quarterly") {
      from.setMonth(today.getMonth() - 3);
    } else if (type === "half yearly") {
      from.setMonth(today.getMonth() - 6);
    } else if (type === "yearly") {
      from = new Date(today.getFullYear(), 0, 1);
    }

    return {
      from: from.toISOString().split("T")[0],
      to: to.toISOString().split("T")[0],
    };
  };

  const fetchReport = async () => {
    if (!startDate || !endDate) return;

    setLoading(true);

    try {
      const res = await api.get(
        `/reports?from=${startDate}&to=${endDate}&category=${category}`
      );

      const data = res.data || {};

      const qty = Number(data.quantity || 0).toFixed(2) + " kg";

      // Amount ko clean karo – ₹ ya koi garbage nahi
      let rawAmount = data.amount || "0";

      if (typeof rawAmount === "string") {
        rawAmount = rawAmount
          .replace(/[^0-9.-]/g, "") // sab non-number hata do
          .replace(/,/g, ""); // comma bhi hatao
      }

      let amtValue = parseFloat(rawAmount) || 0;
      if (isNaN(amtValue)) amtValue = 0;

      // Sirf number format (₹ nahi)
      const amt = amtValue.toLocaleString("en-IN", {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
        useGrouping: true,
      });

      setSummary({
        purchases: Number(data.purchases || 0),
        quantity: qty,
        amount: amt,
      });

      setHasData(
        Number(data.purchases || 0) > 0 ||
          Number(data.quantity || 0) > 0 ||
          amtValue > 0
      );
    } catch (err) {
      console.error("Failed to fetch report:", err);
      setSummary({
        purchases: 0,
        quantity: "0 kg",
        amount: "0.00",
      });
      setHasData(false);
    } finally {
      setLoading(false);
    }
  };

  const handlePeriodChange = (period) => {
    setRange(period);
    const { from, to } = getDateRange(period);
    setStartDate(from);
    setEndDate(to);
  };

  useEffect(() => {
    if (startDate && endDate) {
      fetchReport();
    }
  }, [startDate, endDate, category]);

  useEffect(() => {
    handlePeriodChange("monthly");
  }, []);

  const handleExportCSV = () => {
    if (!hasData) {
      alert("No data to export");
      return;
    }

    const headers = ["Metric", "Value"];
    const rows = [
      ["Purchases", summary.purchases],
      ["Quantity", summary.quantity],
      ["Amount", summary.amount], // ab ₹ nahi, sirf number
    ];

    const BOM = "\uFEFF";
    let csv = BOM + headers.join(",") + "\n";

    rows.forEach((row) => {
      const escapedRow = row.map((cell) => {
        if (cell === null || cell === undefined) return "";
        return `"${cell.toString().replace(/"/g, '""')}"`;
      });
      csv += escapedRow.join(",") + "\n";
    });

    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.setAttribute(
      "download",
      `purchase_report_${startDate}_to_${endDate}.csv`
    );
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="p-4 sm:p-6 bg-gray-100 min-h-screen">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <button className="text-gray-600 hover:text-primary">
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M15 19l-7-7 7-7"
              />
            </svg>
          </button>
          <h1 className="text-2xl font-bold text-gray-800">Reports</h1>
        </div>
        <button
          onClick={handleExportCSV}
          className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-blue-800 transition flex items-center gap-2 disabled:opacity-50"
          disabled={loading || !hasData}
        >
          <svg
            className="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
            />
          </svg>
          Export
        </button>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-xl shadow p-6 mb-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-800 flex items-center gap-2">
            Filters
          </h2>
          <button className="text-sm text-gray-500 hover:text-primary">
            Reset
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {/* Time Period */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Time Period
            </label>
            <div className="flex flex-wrap gap-2">
              {timePeriods.map((period) => (
                <button
                  key={period}
                  onClick={() => handlePeriodChange(period.toLowerCase())}
                  className={`px-3 py-1 rounded-full text-sm font-medium transition ${
                    range === period.toLowerCase()
                      ? "bg-primary text-white"
                      : "bg-gray-100 text-gray-700 hover:bg-gray-200"
                  }`}
                >
                  {period}
                </button>
              ))}
            </div>
          </div>

          {/* Start Date */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Start Date
            </label>
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
              className="w-full p-2 border rounded-lg"
            />
          </div>

          {/* End Date */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              End Date
            </label>
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
              className="w-full p-2 border rounded-lg"
            />
          </div>

          {/* Category */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Category
            </label>
            <select
              value={category}
              onChange={(e) => setCategory(e.target.value)}
              className="w-full p-2 border rounded-lg"
            >
              <option value="all">All Categories</option>
              <option value="grains">Grains</option>
              <option value="pulses">Pulses</option>
              <option value="vegetables">Vegetables</option>
            </select>
          </div>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div className="bg-white rounded-xl shadow p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Purchases</h3>
          {loading ? (
            <p className="text-3xl font-bold text-gray-400">...</p>
          ) : (
            <p className="text-3xl font-bold text-primary">
              {summary.purchases}
            </p>
          )}
        </div>

        <div className="bg-white rounded-xl shadow p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Quantity</h3>
          {loading ? (
            <p className="text-3xl font-bold text-gray-400">...</p>
          ) : (
            <p className="text-3xl font-bold text-primary">
              {summary.quantity}
            </p>
          )}
        </div>

        <div className="bg-white rounded-xl shadow p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Amount</h3>
          {loading ? (
            <p className="text-3xl font-bold text-gray-400">...</p>
          ) : (
            <p className="text-3xl font-bold text-primary">{summary.amount}</p>
          )}
        </div>
      </div>

      {/* No Data / Data Message */}
      <div className="bg-white rounded-xl shadow p-8 text-center">
        {loading ? (
          <p className="text-gray-600 text-lg">Loading report...</p>
        ) : hasData ? (
          <>
            <h3 className="text-xl font-semibold text-green-700 mb-2">
              ✓ Data Found
            </h3>
            <p className="text-gray-600">
              Purchases found for selected period and category.
            </p>
          </>
        ) : (
          <>
            <h3 className="text-xl font-semibold text-gray-800 mb-2">
              No data available
            </h3>
            <p className="text-gray-600">
              No purchases found for the selected filters
            </p>
          </>
        )}
      </div>
    </div>
  );
}
