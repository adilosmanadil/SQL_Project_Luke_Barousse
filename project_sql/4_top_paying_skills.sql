/*
Question : What are top skills based on salary ?
- Look at average salary associated with each skill for Data Analyst roles
- Focuses on roles with specified salaries regardless of location
*/

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