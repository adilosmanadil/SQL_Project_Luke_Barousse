/*
Question : What are the top-paying data analyst jobs ?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
*/

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