# Smart Urban Transportation Management System

This repository contains a sample system designed for intelligent urban transportation management. It provides a structured data model, well‑organized database resources, and fully usable files aimed at developers who want to study, test, or extend a real‑world database system.

> **Note:** All architectural diagrams, table relationships, ERD, and class structures are stored as separate files inside the repository. Sample data files are also included so users can quickly populate the system and begin testing.

---

## 🔍 Project Purpose

This project is developed to support learning, system design practice, and understanding of professional standards in database modeling, documentation, and data management. Using the included files, users can:

- Review and explore the full database structure  
- Import sample data into PostgreSQL  
- Test pre‑written queries  
- Run, analyze, and extend the system  

The project is fully implemented using **PostgreSQL**.

---

## 🗄️ Database Structure

**Tables.sql & Tabels_Info.sql** include:

- Creation of all PostgreSQL tables (DDL)  
- Definitions of primary and foreign keys  
- Constraints, indexes, and data rules  
- Detailed descriptions of each table and field  

> All structural and architectural details are stored inside these files rather than the README.

---

## 🧪 Sample Data

The repository includes sample datasets inside the project files . These datasets cover:

- Vehicles  
- Drivers  
- Routes & stations  
- Trips  
- Payments & reservations  

These files allow users to:

- Avoid manual data creation  
- Immediately test the system  
- Run queries on realistic data

---

## 📝 Queries (Queries.sql)

This file contains:

- Reporting queries  
- Management queries  
- Analytical queries for testing the system

---

## 🚀 How to Use the Project

1. **Clone the Repository**
    ```bash
    git clone <repo-url>
    ```

2. **Create the Database**  
   Execute `Tables.sql` in PostgreSQL to build the schema.

3. **Load Sample Data**  
   Run the sample data files included in the repository.

4. **Test Queries**  
   Use `Queries.sql` to test operations and analyze the system.

---

## 🧩 System Capabilities

- Vehicle management (bus, taxi, van, metro, etc.)  
- Driver management and assignment  
- Route and station definition  
- Trip logging  
- Reservation & payment handling  
- Intelligent reporting and analysis

