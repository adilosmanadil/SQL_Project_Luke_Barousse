/*
Question : What skills are required for the top-paying data analyst jobs ?
- Use top 10 highest paying jobs from first query (1_top_paying_job_skills.sql)
- Add specific skills required for these roles
*/

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