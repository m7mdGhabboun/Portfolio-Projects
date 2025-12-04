# Movies Correlation

This project applies statistical analysis to a movies dataset to understand which attributes have the strongest influence on a film’s gross earnings.
Using Python, the project examines correlations between variables to identify meaningful relationships and trends in the movie industry.

# Description

The goal of this project is to:

* Analyze a dataset of movies using statistical methods

* Identify which features contribute most to a movie’s box office performance

* Explore correlations between numerical variables

* Visualize key relationships

The analysis focuses primarily on discovering which attributes have the highest correlation with **gross earnings**.

# Dataset

* **Source**: Kaggle

* **Format**: CSV (.csv)

* Includes movie-related attributes such as budget, votes, gross revenue, and more.

# Tools Used

* Python

* NumPy

* Pandas

* Seaborn

* Matplotlib

# What I Did

* Performed correlation analysis using the **Pearson method**

* Visualized correlations using heatmaps and scatter plots

* Identified the strongest predictors of movie earnings

# Key Insights

* **Budget** has the strongest correlation with **gross earnings**, with a coefficient of **0.75**

* **Votes** also show a strong positive correlation with **gross**, with a coefficient of **0.63**

* These findings suggest that higher production budgets and greater audience engagement (votes) tend to be associated with higher earnings

# How to Run

1. **Download the dataset** provided in the folder and save it locally on your computer.

2. Open the `.ipynb` notebook in **Jupyter Notebook** or **JupyterLab**.

3. In the cell where `pd.read_csv()` is used, **replace the file path** with the correct path to where you saved the dataset.

4. Run the notebook cells in order to generate the analysis and visualizations.
