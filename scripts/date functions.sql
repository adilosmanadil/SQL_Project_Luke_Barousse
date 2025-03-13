/*

-- Change date to not include timestamp

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date ::DATE AS date
FROM
    job_postings_fact;

*/

/*

-- Display timestamps, timezone and extract month and year

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;

*/

/*

-- Extract month, group by sum of each month and filter Data Analyst

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY
    job_posted_count DESC;

*/