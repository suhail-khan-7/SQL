SELECT *
  FROM [Hospital_database].[dbo].[Hospital_Data]

-- 30 Days SQL Micro Course Certificate Assignment.

-- 1. Total Number of Patients.

SELECT sum(Patients_Count) as Total_Number_of_Patients
FROM hospital_data

-- 2. Average Number of Doctors Per Hospitals.

SELECT Hospital_Name,AVG(Doctors_count) as Average_Number_of_Doctor_Per_Hospital
FROM Hospital_Data
GROUP BY Hospital_Name

-- 3. Top 3 Departments With The Highest Number of Patients.

SELECT TOP(3)Department,sum(patients_count) as Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients DESC

-- 4. Hospital With The Maximum Medical Exp.

SELECT TOP(1)Hospital_Name,SUM(medical_expenses) as Total_Medical_Expenses
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Total_Medical_Expenses DESC

-- 5. Daily Average Medical Expenses.

SELECT Hospital_Name,AVG(Medical_Expenses) as Average_Medical_Exp
FROM Hospital_Data
GROUP BY Hospital_Name

-- 6. Longest Hospital Stay.

SELECT TOP(1)Hospital_Name,Admission_Date,Discharge_Date,DATEDIFF(DAY,Admission_Date,Discharge_Date) as Day_Difference
FROM Hospital_Data
ORDER BY Day_Difference DESC

-- 7. Total Patients Treated Per City.

SELECT Location,SUM(Patients_count) As Total_patients
FROM Hospital_Data
GROUP BY Location

-- 8. Average Length of Stay Per department.

SELECT Department,AVG(DATEDIFF(DAY,Admission_Date,Discharge_Date)) as Ave_Day_of_Stay_in_Each_Department
FROM Hospital_Data
GROUP BY Department

-- 9. Identify The Department With the Lowest Number of Patients.

SELECT TOP(1)Department,SUM(patients_count) as Total_Number_of_Pateints
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Number_of_Pateints

-- 10. Monthly Medical Expenses Report.

SELECT Format(Admission_Date,'yyyy-MM') as Months,sum(medical_expenses) as total_expense
FROM Hospital_Data
GROUP BY Format(Admission_Date,'yyyy-MM')

