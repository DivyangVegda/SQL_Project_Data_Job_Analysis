/*
    Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/


WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count 
    FROM
        skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings
        ON skills_to_job.job_id = job_postings.job_id
    WHERE
        job_work_from_home = true
        --AND job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)

SELECT
    skill.skill_id,
    skills as skill_name,
    skill_count
FROM 
    remote_job_skills 
    INNER JOIN skills_dim AS skill 
    ON remote_job_skills.skill_id = skill.skill_id
ORDER BY
    skill_count DESC
LIMIT 5

