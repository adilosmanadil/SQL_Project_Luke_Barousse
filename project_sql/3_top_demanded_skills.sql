/*
Question: What are the most in-demand skills for data analysis ?
- Join job postings to inner join table similar to query 2(2_top_paying_job_skills.sql)
- Identify the top 5 in-demand data skills for a data analyst
- Focus on all job postings
*/

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