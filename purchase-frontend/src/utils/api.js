import axios from "axios";

const API_URL = "http://localhost:3001/api";

const api = axios.create({
  baseURL: API_URL,
  headers: {
    "Content-Type": "application/json",
  },
});

/**
 * ✅ REQUEST INTERCEPTOR
 * Har API call ke saath JWT token automatically add hoga
 */
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");

    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  (error) => Promise.reject(error)
);

/**
 * ✅ RESPONSE INTERCEPTOR
 * Agar token expire / invalid ho (401)
 * to auto logout + redirect to login
 */
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      localStorage.clear(); // token + user clear
      window.location.href = "/"; // ya "/login"
    }
    return Promise.reject(error);
  }
);

export default api;