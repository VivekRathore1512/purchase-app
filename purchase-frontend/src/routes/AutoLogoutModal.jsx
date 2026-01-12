// src/routes/AutoLogoutModal.jsx
import React, { useContext } from "react";
import { AppContext } from "../App";
import { useNavigate } from "react-router-dom";

export default function AutoLogoutModal() {
  const { clearAutoLogout, logout } = useContext(AppContext);
  const nav = useNavigate();

  const relogin = () => {
    clearAutoLogout();
    logout();
    nav("/login");
  };

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black/50 z-50">
      <div className="bg-white p-6 rounded-lg w-full max-w-sm text-center shadow-xl">
        <h4 className="text-lg font-semibold mb-2">Another session detected</h4>
        <p className="text-sm text-gray-600 mb-6">
          You have been logged out because another active session was detected.
        </p>
        <button
          onClick={relogin}
          className="px-6 py-2 bg-primary text-white rounded hover:opacity-90"
        >
          Login Again
        </button>
      </div>
    </div>
  );
}
