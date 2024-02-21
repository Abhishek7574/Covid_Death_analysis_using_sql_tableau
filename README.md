# COVID-19 Data Analysis and Visualization

This repository contains data related to COVID-19 sourced from Our World in Data (ourworlddata.org). The data spans from 2020 to December 2023 and covers various aspects of the pandemic, including COVID deaths and vaccination statistics.

## Data Processing

1. **Data Extraction:** The original data was obtained from [Our World in Data](https://ourworldindata.org/covid-deaths).

2. **Data Splitting:** The data was split into two Excel files: one for COVID deaths and another for people vaccinated.

3. **SQL Database:** The data was uploaded into an SQL database for efficient querying.

4. **Querying:** SQL queries were performed to extract detailed information country-wise and continent-wise.

5. **Table Extraction:** The results of the queries were organized into six different tables.

6. **Export to Excel:** The tables extracted from the SQL database were exported as Excel files for further analysis.

7. **Tableau Visualization:** The Excel files were utilized in Tableau for creating visualizations.

8. **Interactive Dashboards:** The visualizations were used to create interactive dashboards, providing insights into various aspects of the COVID-19 data.


## Visualization
The visualizations of the data were created using Tableau. Feel free to explore and interact with the visualizations.

[Explore the Global Data on Confirmed COVID-19 Deaths](https://public.tableau.com/views/ExploretheglobaldataonconfirmedCOVID-19deaths/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

## SQL Query

The SQL query used for extracting the data can be found 
[here](https://github.com/Abhishek7574/Covid_Death_analysis_using_sql_tableau/blob/4ba39982b5d63b55775a2e49cbb6ff529faaf03e/sql%20covid%20final%20project.sql).

### Data Exploration and Ordering
- Explored COVID-19 death data.
- Ordered data from `CovidDeaths` by the 3rd and 4th columns.

### Column Selection and Ordering
- Selected specific columns from `CovidDeaths` (Location, Date, total_cases, new_cases, total_cases, population).
- Ordered data by the 1st and 2nd columns.

### Death Statistics for India
- Analyzed total cases vs total deaths for India.
- Calculated the likelihood of dying if one gets COVID in India.

### Global Numbers
- Examined global numbers for total cases, total deaths, and death percentage.

### Population vs Vaccination
- Investigated the relationship between total population and vaccinations.
- Calculated the number of people vaccinated globally.

### Vaccination Percentage
- Used a Common Table Expression (CTE) to calculate the vaccination percentage.

### Population Vaccinated Temp Table
- Utilized a temporary table to perform calculations on the Partition By clause.

### Additional Analysis and Notes
- Various queries focus on different aspects such as death count, infection rates, and vaccination percentages.
- Ensure the database is properly structured and data is loaded before running queries.
- Customize filters such as `WHERE` conditions to suit your specific dataset.

 ## Repository Files

1. **covid_data/**
   - Folder containing the raw data files.
  
2. **Tableau_visualization/**
   - Folder containing Tableau-related files.
     - `Tableau_visualization_link.txt`: File containing the link to the Tableau visualization.
     
3. **sql covid final project.sql**
   - SQL file containing the queries used to extract data from the original dataset.

4. **covid_Dashboard_static.png**
   - Static image version of the Tableau visualization.

5. **README.md**
   - Markdown file providing an overview of the repository and the data processing steps.

## Notes
- The data used in this analysis is up to December 2023.
- Please refer to the original data source [Our World in Data - COVID-19 Deaths](https://ourworldindata.org/covid-deaths) for any updates or additional information.

Feel free to use, share, and contribute to this repository. If you have any questions or suggestions, please open an issue or contact [Abhishek kumar](www.linkedin.com/in/abhishek-kumar0032)
.

Happy Analyzing!
