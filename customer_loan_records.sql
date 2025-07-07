-- Making database active
USE customer_loan_records;

SELECT *
FROM loan_dataset;

-- Business Questions 
-- 1. Extract all records where the loan status is 'Defaulted'.
SELECT * 
FROM loan_dataset
WHERE Loan_Status =  'Defaulted';

-- 2. Identify loans where monthly income is below 2000.
SELECT *
FROM loan_dataset
WHERE Monthly_Income < 2000;
 
-- 3. Group loan records by loan purpose and count each category.
SELECT Loan_Purpose, COUNT(Loan_Purpose)  AS loan_count
FROM loan_dataset
GROUP BY Loan_Purpose
ORDER BY loan_count DESC;
 
-- 4. Calculate the average credit score of customers who have defaulted.
SELECT  Customer_ID, Loan_Status, AVG(Credit_Score)
FROM loan_dataset
GROUP BY Customer_ID, Loan_Status
HAVING Loan_Status = 'Defaulted'
ORDER BY AVG(Credit_Score) DESC;

-- 5. Count the number of loans in each status category.
SELECT  Loan_Status, COUNT(Loan_ID)
FROM loan_dataset
GROUP BY Loan_Status;

-- 6. Find the average interest rate for each loan purpose. 
SELECT Loan_Purpose, ROUND(AVG(Interest_Rate),2) AS Avg_interest_rate
FROM loan_dataset
GROUP BY Loan_Purpose
ORDER BY  Avg_interest_rate DESC;

-- 7. Identify the employment status with the most loan defaults.
SELECT  Employment_Status, COUNT( Loan_Status) AS loan_defaults
FROM loan_dataset
WHERE Loan_Status = 'Defaulted'
GROUP BY  Employment_Status
ORDER BY loan_defaults DESC;

-- 8. Determine the average loan amount for each employment status. 
SELECT Employment_Status, ROUND(AVG(Loan_Amount),2)
FROM  loan_dataset
GROUP BY Employment_Status;

-- 9. List the total number of loans with terms greater than 36 months.
SELECT  COUNT(Loan_ID)
FROM loan_dataset
WHERE Loan_Term > 36;

-- 10. For each loan status, show the minimum and maximum loan amounts.
SELECT Loan_Status, MIN(Loan_Amount) AS MIN_loan, MAX(Loan_Amount) AS MAX_loan
FROM loan_dataset
GROUP BY Loan_Status;

-- 11. Count how many loans have credit scores less than 600 and were approved. 
SELECT  COUNT(Loan_ID)
FROM loan_dataset
WHERE Credit_Score < 600 AND Loan_Status = 'Approved';

-- 12. Classify customers into credit bands based on credit score. 
SELECT Credit_Score,
CASE
WHEN Credit_Score < 500 THEN 'LOW'
WHEN Credit_Score >= 500 AND Credit_Score < 700 THEN 'MODERATE'
ELSE 'HIGH'
END AS credit_bands
FROM loan_dataset;
 
-- 13. Rank loan purposes by the total loan amount issued.
SELECT Loan_Purpose, SUM(Loan_Amount) AS Total_Loan_Amount,
       RANK() OVER (ORDER BY SUM(Loan_Amount) DESC) AS Loan_Purpose_Rank
FROM loan_dataset
GROUP BY Loan_Purpose;
 
-- 14. Show the loan count grouped by gender and employment status.
SELECT Gender, Employment_Status, COUNT(Loan_ID)
FROM loan_dataset
GROUP BY Gender, Employment_Status;
 
-- 15. List customers with approved loans over 30000 and credit score above 700
SELECT Customer_ID, Loan_Status, Loan_Amount, Credit_Score
FROM loan_dataset
WHERE Loan_Status = 'Approved' AND Loan_Amount > 30000 AND Credit_Score > 700;