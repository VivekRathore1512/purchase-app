// src/routes/Splash.jsx
import React from "react";
import { Link } from "react-router-dom";

export default function Splash() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-sky-200 via-indigo-200 to-purple-200">
      <div className="bg-white/40 backdrop-blur-xl rounded-2xl shadow-xl p-10 w-full max-w-xl text-center border border-white/40">
        <h1 className="text-4xl font-bold text-indigo-900 mb-2">PurchaseApp</h1>
        <p className="text-indigo-800 mb-8">
          Fast, simple purchase and defect tracking
        </p>
        <div className="flex justify-center gap-4">
          <Link
            to="/signup"
            className="px-6 py-2 rounded-md bg-cyan-500 text-white hover:bg-cyan-600 transition"
          >
            Create Account
          </Link>
          <Link
            to="/login"
            className="px-6 py-2 rounded-md bg-white text-indigo-700 border border-indigo-300 hover:bg-indigo-50 transition"
          >
            Login
          </Link>
        </div>
      </div>
    </div>
  );
}

