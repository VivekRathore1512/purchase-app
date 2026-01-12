// src/main.jsx
import React from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom"; // Yeh import add karna zaruri hai
import App from "./App";

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      {" "}
      {/* Yeh <BrowserRouter> tag pura App ko wrap karega */}
      <App />
    </BrowserRouter>
  </React.StrictMode>
);
