--create table with column names
CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * 
FROM job_applied;


--INSERT DATA
INSERT INTO job_applied
    (job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status)
VALUES
    (1,
    '2024-02-01',
    true,
    'resume_01.pdf',
    true,
    'cover_letter_01.pdf',
    'submitted'),
    (2,
    '2024-02-04',
    false,
    'resume_02.pdf',
    true,
    'cover_letter_02.pdf',
    'submitted'),
    (3,
    '2024-02-10',
    true,
    'resume_03.pdf',
    true,
    'cover_letter_03.pdf',
    'submitted'),
    (4,
    '2024-02-12',
    true,
    'resume_04.pdf',
    false,
    'cover_letter_04.pdf',
    'submitted'),
    (5,
    '2024-02-02',
    false,
    'resume_05.pdf',
    false,
    'cover_letter_05.pdf',
    'submitted');


--UPDATE
UPDATE job_applied
SET status = 'rejected'
WHERE cover_letter_sent = FALSE AND custom_resume = FALSE;


--add contact column
ALTER TABLE job_applied
ADD contact VARCHAR(50);


--set contact data
UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Tony Stark'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Charlie Cruise'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Tom Holland'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Bill Gates'
WHERE job_id = 5;


--rename column
ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;
SELECT * FROM job_applied;


--change data_type
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;


--delete column
ALTER TABLE job_applied
DROP COLUMN contact_name;


--delete entire table
DROP TABLE job_applied;





SELECT 
    job_title_short as title,
    job_location as location,
    job_posted_date at time zone 'UTC' at time zone 'IOT' as date,
    EXTRACT(MONTH FROM job_posted_date) as date_month,
    EXTRACT(YEAR FROM job_posted_date) as date_year
from job_postings_fact
LIMIT 100;



/*

    label new column as follows:
    - 'Anywhere' jobs as 'Remote'
    - 'New York, NY' jobs as 'Local'
    - Otherwise 'Onsite'

*/

SELECT
    --job_title_short,
    --job_location,
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;




--SubQueries
SELECT 
    company_id,
    name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE job_no_degree_mention = true
)




/*
    Find the companies that have the most job openings.
    - Get the total number of job postings per company id (job_posting_fact)
    - Return the total number of jobs with the company name (company_dim)
*/


WITH company_job_count AS(
    --subquery , we can run explicitily 
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact 
    GROUP BY company_id
)0

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
    LEFT JOIN company_job_count 
    ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC

/*
SELECT *
FROM company_job_count
*/



SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs