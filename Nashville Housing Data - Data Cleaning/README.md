# Nashville Housing Data Cleaning

This project focuses on cleaning and restructuring a Nashville housing dataset to prepare it for future analysis, visualizations, or exploratory data analysis (EDA).
The dataset contained several inconsistencies, formatting issues, and missing information, which were addressed through a series of structured SQL cleaning operations.

# Description

The goal of this project is to:

* Transform raw housing data into a clean, consistent format

* Fix structural and formatting issues

* Prepare the dataset for future analytical tasks such as EDA, dashboards, or ML preprocessing

**The dataset originally contained multiple formatting inconsistencies, missing values, and duplicated records, all of which were cleaned and standardized.**

# Dataset

* **Source:** Kaggle

* **Format:** Excel (.xlsx)

# Tools Used

* **SQL**
Used for all data cleaning, formatting, and transformation operations.

# What I Did

The data cleaning process included:

**1. Standardizing date formats** to ensure consistency across all records

**2. Populating missing property addresses** by identifying duplicate records and using known values to fill gaps

**3. Splitting the property address** into atomic fields — **Address, City, State** — improving usability for analysis and visualization

**4. Splitting the owner address** using the same technique for clarity and structure

**5. Standardizing boolean columns**, converting multiple inconsistent representations into a unified format

**6. Removing duplicate and irrelevant rows/columns** to ensure data integrity and cleanliness

These transformations significantly improved the quality and usability of the dataset.

# How to Run

**1. Download the dataset and the SQL query file** included in this project.

**2.** Import the dataset into your SQL environment (MySQL, PostgreSQL, SQL Server, etc.).

**3.** Run the provided SQL queries in order to reproduce the cleaning steps.
