// src/routes/Login.jsx
import React, { useState, useContext } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AppContext } from "../App";
import api from "../utils/api"; // Yeh import add karna

export default function Login() {
  const { login } = useContext(AppContext);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!email || !password) {
      alert("Please enter both email and password");
      return;
    }

    setLoading(true);

    try {
      const response = await api.post("/auth/login", {
        email,
        password,
      });

      const { token } = response.data;

      // Token save kar localStorage mein
      localStorage.setItem("token", token);

      // Context mein user set (UI ke liye)
      login({ email });

      alert("Login successful!");
      navigate("/select-company");
    } catch (error) {
      console.error("Login error:", error);
      const msg = error.response?.data?.message || "Invalid email or password";
      alert(msg);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-bg px-4">
      <div className="w-full max-w-md bg-white rounded-2xl shadow-xl p-6">
        <div className="flex justify-center mb-4">
          <div className="w-14 h-14 rounded-full bg-primary flex items-center justify-center">
            <span className="text-white text-2xl">➜</span>
          </div>
        </div>

        <h2 className="text-center text-xl font-semibold text-primary">
          Welcome Back
        </h2>
        <p className="text-center text-gray-500 text-sm mb-6">
          Login to continue
        </p>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="text-sm font-medium">Email</label>
            <div className="relative mt-1">
              <span className="absolute inset-y-0 left-3 flex items-center text-gray-500">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  className="w-5 h-5"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M21.75 6.75v10.5a2.25 2.25 0 11-4.5 0V6.75m0 0h-4.5m4.5 0v10.5m-9-10.5h4.5v10.5a2.25 2.25 0 11-4.5 0V6.75z"
                  />
                </svg>
              </span>

              <input
                type="email"
                placeholder="Enter your email"
                className="w-full pl-10 pr-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                disabled={loading}
              />
            </div>
          </div>

          <div>
            <label className="text-sm font-medium">Password</label>
            <div className="relative mt-1">
              <span className="absolute inset-y-0 left-3 flex items-center text-gray-500">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  className="w-5 h-5"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M16.5 10.5V7.5a4.5 4.5 0 10-9 0v3M5.25 10.5h13.5v9a2.25 2.25 0 01-2.25 2.25H7.5A2.25 2.25 0 015.25 19.5v-9z"
                  />
                </svg>
              </span>

              <input
                type="password"
                placeholder="Enter your password"
                className="w-full pl-10 pr-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                disabled={loading}
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-primary text-white py-2 rounded-lg font-medium hover:opacity-90 transition disabled:opacity-70"
          >
            {loading ? "Logging in..." : "Login"}
          </button>
        </form>

        <div className="text-center mt-4">
          <Link to="#" className="text-primary text-sm">
            Forgot Password?
          </Link>
        </div>

        <hr className="my-5" />

        <p className="text-center text-sm">
          Don't have an account?{" "}
          <Link to="/signup" className="text-primary font-medium">
            Sign Up
          </Link>
        </p>
      </div>
    </div>
  );
}
