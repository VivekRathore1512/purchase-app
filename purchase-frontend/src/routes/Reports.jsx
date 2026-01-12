import React, { useState } from "react";
import api from "../utils/api";

export default function Reports() {
  const [range, setRange] = useState("monthly");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [category, setCategory] = useState("all");

  const [summary, setSummary] = useState({
    purchases: 0,
    quantity: "0 kg",
    amount: "₹0",
  });

  const timePeriods = [
    "Weekly",
    "Monthly",
    "Quarterly",
    "Half yearly",
    "Yearly",
  ];

  // 🔹 date range calculator (UI se koi relation nahi)
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

  // 🔹 report load function
  const loadReport = async (selectedRange) => {
    setRange(selectedRange);

    const { from, to } = getDateRange(selectedRange);
    setStartDate(from);
    setEndDate(to);

    try {
      const res = await api.get(
        `/reports?from=${from}&to=${to}&category=${category}`
      );

      setSummary({
        purchases: res.data?.purchases || 0,
        quantity: `${res.data?.quantity || 0} kg`,
        amount: `₹${res.data?.amount || 0}`,
      });
    } catch (error) {
      console.error("Report error:", error);
      setSummary({
        purchases: 0,
        quantity: "0 kg",
        amount: "₹0",
      });
    }
  };

 const fetchReportByFilters = async () => {
   if (!startDate || !endDate) return;

   try {
     const res = await api.get(
       `/reports?from=${startDate}&to=${endDate}&category=${category}`
     );

     setSummary({
       purchases: res.data?.purchases || 0,
       quantity: `${res.data?.quantity || 0} kg`,
       amount: `₹${res.data?.amount || 0}`,
     });
   } catch (error) {
     console.error("Report error:", error);
     setSummary({
       purchases: 0,
       quantity: "0 kg",
       amount: "₹0",
     });
   }
 };
 

  // 🔹 Export CSV (NO UI / STATE CHANGE)
  const handleExportCSV = async () => {
    try {
      const res = await api.get(
        `/reports?from=${startDate}&to=${endDate}&category=${category}`
      );

      const data = res.data?.records || [];

      if (!data.length) {
        alert("No data to export");
        return;
      }

      const headers = Object.keys(data[0]);
      const csvRows = [
        headers.join(","),
        ...data.map((row) =>
          headers
            .map(
              (key) => `"${(row[key] ?? "").toString().replace(/"/g, '""')}"`
            )
            .join(",")
        ),
      ];

      const blob = new Blob([csvRows.join("\n")], {
        type: "text/csv;charset=utf-8;",
      });

      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.download = `${category}_report.csv`;
      link.click();
    } catch (err) {
      console.error("Export error:", err);
    }
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
          className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-blue-800 transition flex items-center gap-2"
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
                  onClick={() => loadReport(period.toLowerCase())}
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
              onChange={(e) => {
                setStartDate(e.target.value);
                setTimeout(fetchReportByFilters, 0);
              }}
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
              onChange={(e) => {
                setEndDate(e.target.value);
                setTimeout(fetchReportByFilters, 0);
              }}
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
              onChange={(e) => {
                setCategory(e.target.value);
                setTimeout(fetchReportByFilters, 0);
              }}
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
          <p className="text-3xl font-bold text-primary">{summary.purchases}</p>
        </div>

        <div className="bg-white rounded-xl shadow p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Quantity</h3>
          <p className="text-3xl font-bold text-primary">{summary.quantity}</p>
        </div>

        <div className="bg-white rounded-xl shadow p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Amount</h3>
          <p className="text-3xl font-bold text-primary">{summary.amount}</p>
        </div>
      </div>

      {/* No Data */}
      <div className="bg-white rounded-xl shadow p-8 text-center">
        <h3 className="text-xl font-semibold text-gray-800 mb-2">
          No data available
        </h3>
        <p className="text-gray-600">
          No purchases found for the selected filters
        </p>
      </div>
    </div>
  );
}