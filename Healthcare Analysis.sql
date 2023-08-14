use company;

CREATE TABLE Patients (
patient_id INT PRIMARY KEY,
patient_name VARCHAR(50),
age INT,
gender VARCHAR(10),
city VARCHAR(50)
);

INSERT INTO Patients (patient_id, patient_name, age, gender, city)
VALUES
(1, 'John Smith', 45, 'Male', 'Seattle'),
(2, 'Jane Doe', 32, 'Female', 'Miami'),
(3, 'Mike Johnson', 50, 'Male', 'Seattle'),
(4, 'Lisa Jones', 28, 'Female', 'Miami'),
(5, 'David Kim', 60, 'Male', 'Chicago');

CREATE TABLE Symptoms (
symptom_id INT PRIMARY KEY,
symptom_name VARCHAR(50)
);

INSERT INTO Symptoms (symptom_id, symptom_name)
VALUES
(1, 'Fever'),
(2, 'Cough'),
(3, 'Difficulty Breathing'),
(4, 'Fatigue'),
(5, 'Headache');

CREATE TABLE Diagnoses (
diagnosis_id INT PRIMARY KEY,
diagnosis_name VARCHAR(50)
);

INSERT INTO Diagnoses (diagnosis_id, diagnosis_name)
VALUES
(1, 'Common Cold'),
(2, 'Influenza'),
(3, 'Pneumonia'),
(4, 'Bronchitis'),
(5, 'COVID-19');

CREATE TABLE Visits2 (
visit_id INT PRIMARY KEY,
patient_id INT,
symptom_id INT,
diagnosis_id INT,
visit_date DATE);

INSERT INTO Visits2 (visit_id, patient_id, symptom_id, diagnosis_id, visit_date)
VALUES
(1, 1, 1, 2, '2022-01-01'),
(2, 2, 2, 1, '2022-01-02'),
(3, 3, 3, 3, '2022-01-02'),
(4, 4, 1, 4, '2022-01-03'),
(5, 5, 2, 5, '2022-01-03'),
(6, 1, 4, 1, '2022-05-13'),
(7, 3, 4, 1, '2022-05-20'),
(8, 3, 2, 1, '2022-05-20'),
(9, 2, 1, 4, '2022-08-19'),
(10, 1, 2, 5, '2022-12-01');

select * from patients;

select * from symptoms;

select * from Diagnoses;

select * from visits2;

/*1. Write a SQL query to retrieve all patients who have been diagnosed with COVID-19? */

select 
p.patient_name,
d.diagnosis_name
from patients p 
join diagnoses d
on p.patient_id = d.diagnosis_id
where d.diagnosis_name = 'covid-19';
/*2.Write a SQL query to retrieve the number of visits made by each patient, ordered by the number of visits in descending order.*/

select p.patient_id,
p.patient_name,
count(v.visit_id) as num_visits
from patients p
left join visits2 v
on p.patient_id = v.patient_id
group by p.patient_id,p.patient_name
order by num_visits desc;

/*3.Write a SQL query to calculate the average age of patients who have been diagnosed with Pneumonia.*/
 select p.patient_name,
 round(avg(p.age)) as average_age_of_patients
 from patients p
 left join diagnoses d 
 on p.patient_id = d.diagnosis_id
 where d.diagnosis_name = 'pneumonia'
 group by p.patient_name;
 
 /*4.Write a SQL query to retrieve the top 3 most common symptoms among all visits.*/
 select s.symptom_name,
 count(*) as symptom_count
 from symptoms s
 join visits2 v
 on s.symptom_id = v.symptom_id
 group by symptom_name
 order by symptom_count desc
 limit 3;
 
 
 /*5.Write a SQL query to retrieve the patient who has the highest number of different symptoms reported.*/
 
 select p.patient_name,
 count(s.symptom_name) as high_num_of_diff_symptoms
 from patients p
 join symptoms s
 on p.patient_id = s.symptom_id
 limit 1;
 
 /*6.Write a SQL query to calculate the percentage of patients who have been diagnosed with COVID-19 out of the total number of patients.*/
 
SELECT (COUNT(CASE WHEN d.diagnosis_name = 'COVID-19' THEN 1 END) / COUNT(*) * 100) AS percentage
FROM patients p
JOIN diagnoses d ON p.patient_id = d.diagnosis_id;

/*7.Write a SQL query to retrieve the top 5 cities with the highest number of visits, along with the count of visits in each city.*/

select (p.city), count(*) as visit_count
from patients p
join visits2 v
on p.patient_id = v.patient_id
group by p.city
limit 5;

/*8. Write a SQL query to find the patient who has the highest number of visits in a single day, along with the corresponding visit date.*/
SELECT p.patient_id, v.visit_date, COUNT(*) AS visit_count
FROM patients p
JOIN visits2 v ON p.patient_id = v.patient_id
GROUP BY p.patient_id, v.visit_date
HAVING COUNT(*) - (
    SELECT MAX(visit_count)
    FROM (
        SELECT COUNT(*) AS visit_count
        FROM visits2
        GROUP BY visit_date
    ) AS counts
)
LIMIT 1;


/*9.Write a SQL query to retrieve the average age of patients for each diagnosis, ordered by the average age in descending order.*/

SELECT d.diagnosis_name,
AVG(p.age) AS average_age
FROM diagnoses d
JOIN patients p 
ON d.diagnosis_id = p.patient_id
GROUP BY d.diagnosis_name
ORDER BY average_age DESC;

/*10. Write a SQL query to calculate the cumulative count of visits over time, ordered by the visit date.*/
 
 select visit_date, 
 count(visit_date) as cumulative_count_of_visits_over_time
 from visits2
 group by visit_date
 order by visit_date;
 
 use company;
 
SELECT p.patient_id, v.visit_date, COUNT(*) AS visit_count
FROM patients p
JOIN visits2 v ON p.patient_id = v.patient_id
GROUP BY p.patient_id, v.visit_date
HAVING COUNT(*) = (
    SELECT MAX(visit_count)
    FROM (
        SELECT COUNT(*) AS visit_count
        FROM visits2
        GROUP BY visit_date
    ) AS counts
)
LIMIT 1;

SELECT p.patient_name,
d.diagnosis_name
FROM patients p
JOIN diagnoses d ON p.patient_id = d.diagnosis_id
WHERE d.diagnosis_name = 'COVID-19';

SELECT p.patient_id, p.patient_name, COUNT(v.visit_id) AS num_visits
FROM patients p
LEFT JOIN visits2 v ON p.patient_id = v.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY num_visits DESC;

SELECT AVG(p.age) AS average_age
FROM patients p
JOIN diagnoses d ON p.patient_id = d.diagnosis_id
WHERE d.diagnosis_name = 'Pneumonia';

SELECT p.city, COUNT(v.visit_id) AS visit_count
FROM patients p
JOIN visits2 v ON p.patient_id = v.patient_id
GROUP BY p.city
ORDER BY visit_count DESC
LIMIT 5;






 
