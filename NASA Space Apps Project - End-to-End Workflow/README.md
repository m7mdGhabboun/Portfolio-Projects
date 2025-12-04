# NASA Space Apps Project

This project is an end-to-end data workflow completed for the **NASA Space Apps Hackathon**, using the *Kepler Objects of Interest* dataset provided by NASA.
It involves data cleaning, exploratory data analysis (EDA), and visualization — all done to prepare and better understand the data before training an AI model.

The raw dataset contained many irrelevant attributes and numerous missing values, which required extensive preprocessing based on **NASA’s own published research methods**.

# Description

This project includes:

* **Data Cleaning** based on NASA research papers and modeling guidelines

* **Exploratory Data Analysis (EDA)** to extract insights and understand the astrophysical properties

* **Visualization** using SQL views and Tableau dashboards

The workflow was designed to transform the raw dataset into a reliable, structured form suitable for both ML model training and storytelling during the final presentation.

# Dataset

* **Source**: NASA (Open-source)

* **Format**: Excel (.xlsx)

* Contains Kepler Objects of Interest (KOI) attributes, dispositions, astrophysical parameters, and other observational metadata.

# Tools Used

* Python (Pandas)

* SQL

* Excel

* Tableau

# What I Did
## Data Cleaning

NASA provided research papers documenting their own preprocessing steps for KOI datasets.
I followed their methodology to prepare a clean dataset suitable for our AI model:

**1. Removing irrelevant attributes** listed by NASA as not needed for KOI disposition models

**2. Binary encoding** for the `disposition` attribute to improve ML training

**3. Replacing missing values**:

  * Numerical columns → appropriate statistical values (mean/median depending on distribution)

  * Categorical columns → mode or domain-specific replacements based on NASA guidelines

**4.** Ensured data consistency, resolved formatting issues, and verified integrity using SQL

## EDA

* Explored key astrophysical patterns and anomalies

* Identified meaningful trends and insights useful for storytelling during judging

* (Note: SQL queries used to perform EDA were demonstrated live during the event but cannot be included in the repo)

# Visualization

* Created **SQL views** to structure the cleaned dataset for visualization

* Built a **Tableau dashboard** showing distributions, KOI counts, detection types, and other features

* Used the visuals during our pitch to explain model behavior and data characteristics

# How to Run
**1. Running the Notebook**

* Download the dataset included in the folder

* Make sure the file path in the `read_excel()` or `read_csv()` line is correct

* Run the Jupyter Notebook cells in order

**2. Viewing the Dashboard**

Two formats are provided:

* **PNG file**: for a quick, static preview of the dashboard

* **Tableau Workbook (.twbx)**:

* Download and open in **Tableau Desktop**

* Full interactivity and animations are available in this version
