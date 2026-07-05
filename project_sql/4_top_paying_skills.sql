/*
Question : What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analyst and 
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25


/*
Here is a breakdown of this data:
Cloud & DevOps skills (Terraform, VMware, Ansible, Puppet, GitLab) dominate the list, showing strong demand and premium salaries for infrastructure and automation expertise.
AI & Machine Learning skills (PyTorch, TensorFlow, Keras, Hugging Face, DataRobot) consistently rank among the highest-paying, reflecting the growing importance of AI across industries.
Specialized skills earn the highest salaries. Niche technologies like Solidity and Golang command significantly higher pay than common skills, indicating that expertise in specialized domains is highly valued.
*/