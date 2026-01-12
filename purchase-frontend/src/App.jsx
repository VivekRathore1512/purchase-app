import React, { useState, useEffect } from "react";
import { Routes, Route, Navigate } from "react-router-dom";
import Splash from "./routes/Splash";
import Signup from "./routes/Signup";
import Login from "./routes/Login";
import CompanySelect from "./routes/CompanySelect";
import Dashboard from "./routes/Dashboard";
import AutoLogoutModal from "./routes/AutoLogoutModal";

export const AppContext = React.createContext();

export default function App() {
  const [user, setUser] = useState(null);
  const [company, setCompany] = useState(null);
  const [autoLogout, setAutoLogout] = useState(false);

  // 🔹 Auto-login from localStorage
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      // User info minimal, can be extended if backend returns user data
      setUser({ loggedIn: true });
    }
  }, []);

  const login = (u) => setUser(u);

  const logout = () => {
    setUser(null);
    setCompany(null);
    localStorage.removeItem("token");
  };

  return (
    <AppContext.Provider
      value={{
        user,
        company,
        setCompany,
        login,
        logout,
        triggerAutoLogout: () => setAutoLogout(true),
        clearAutoLogout: () => setAutoLogout(false),
      }}
    >
      <Routes>
        <Route path="/" element={<CompanySelect />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/login" element={<Login />} />
        <Route
          path="/select-company"
          element={user ? <CompanySelect /> : <Navigate to="/login" />}
        />
        <Route
          path="/dashboard/*"
          element={user && company ? <Dashboard /> : <Navigate to="/login" />}
        />
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>

      {autoLogout && <AutoLogoutModal />}
    </AppContext.Provider>
  );
}