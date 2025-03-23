# Introduction
🔍 Dive into the data job market ! Focusing on the data analyst roles, this project explores the top-paying jobs with the most in-demand skills and where high demand meets high salary in data analytics.

👾 SQL queries can be found in : [project_sql](/project_sql/)
# Background
Driven by a quest to navigte the data analyst job market more effectively, this project was born from the desire to pinpoint top-paid and in-demand skills, steamlining others work to find optimal jobs.

Data hails from the SQL Course provided by Luke Barousse, see link [here](https://lukebarousse.com/sql). The data contains insights on job titles, salaries, locations and essential skills.

### The questions I answered through my SQL queries were:

1. What are the top-paying data analyst jobs ?
2. What skills are required for these top-paying jobs ?
3. What skills are most in demand for data analysts ?
4. Which skills are associated with higher salaries ?
5. What are the most optimal (most in demand and highest paying) skills to learn ?

# Tools I Used
For my deep dive into the data analyst job market, I used several key tools:

- **SQL**: The main tool used for analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system which was ideal for handling the job database.
- **Visual Studio Code**: My go-to IDE tool used for database management, creating and executing SQL queries.
- **Git & Github**: Essential for version control and sharing both my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here is how each question was approached:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying oppurtunities in the field.

```sql
-- Choose the necessary columns (location, salary, title, etc.)
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
-- View which company is advertising job
LEFT JOIN
    company_dim
ON
    job_postings_fact.company_id = company_dim.company_id
-- Specify which Data Analyst jobs are remote and shows a salary
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
-- Show top 10 jobs and order from highest to lowest salary
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta and AT&T offer high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specialisations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
-- Create a CTE
WITH
    top_paying_jobs AS (
-- Choose the necessary columns (skills)
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    -- View which company is advertising job
    LEFT JOIN
        company_dim
    ON
        job_postings_fact.company_id = company_dim.company_id
    -- Specify which Data Analyst jobs are remote and shows a salary
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    -- Show top 10 jobs and order from highest to lowest salary
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
-- Multiple joins with the CTE above (top_paying_jobs)
SELECT
    top_paying_jobs.*, -- Allows you to select all col's from CTE above
    skills
FROM
    top_paying_jobs
-- Join with the relevant skills tables
INNER JOIN
    skills_job_dim
ON
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
-- Sort by highest to lowest wages
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
-- Choose columns showing skills, no. of jobs per skill
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
-- Join with the relevant skills tables
INNER JOIN
    skills_job_dim
ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
-- Filter by data analyst role and remote roles
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
-- Aggregation above requires GROUP BY
GROUP BY
    skills
-- Order by highest to lowest count
ORDER BY
    demand_count DESC
-- Limit to 5 as the execution time is too long
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization** Tools like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
-- Choose columns showing skills and average salary per skill(round to nearest whole no.)
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
-- Join with the relevant skills tables
INNER JOIN
    skills_job_dim
ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
-- Filter by data analyst role
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
-- Aggregation above requires GROUP BY
GROUP BY
    skills
-- Order by highest to lowest average salary
ORDER BY 
    avg_salary DESC
-- Limit to 5 as the execution time is too long
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand** for **Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned
The main things I learnt within this project were:

- 🧩 **Building Basic SQL Queries:** The project really helped me understand the thought process and the structure of how to build and the order of execution of SQL queries.
- 🦾 **Practicing with VS Code Editor:** Allowed me to use the various tools provided within *VS Code Editor*, editing/formatting sql scripts and text files and using Github to upload project files and version control.
- 🧠 **Analytical Mindset:** Enhanced my analytical mindset using real-life puzzle-solving skills by turning questions into actionable insights.

# Conclusions
### Insights

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.