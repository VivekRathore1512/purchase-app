# Purchase Management System

Full-Stack Purchase Tracking Application

## Tech Stack
- **Frontend**: React 19 + Vite + Tailwind CSS + React Router
- **Backend**: Node.js + Express + JWT Authentication
- **Database**: MySQL (MariaDB compatible)

## Folder Structure
purchase-management-project/
├── frontend/         # React + Vite app
├── backend/          # Express API
├── database/               # SQL schema & seed data
└── README.md


### Quick Start

1. **Database**
   ```bash
   mysql -u root -p
   CREATE DATABASE purchase_db;

2.**Brash
   mysql -u root -p purchase_db < database/schema/database_schema.sql
mysql -u root -p purchase_db < database/seeds/seed_categories.sql
# ... बाकी seeds भी इसी तरह