-- Customer Operations & Risk Analytics
-- SQL Analysis

-- 1. View sample transactions
SELECT *
FROM customer_transactions_fixed
LIMIT 10;

-- 2. Total transaction value
SELECT
    SUM(Amount) AS Total_Transaction_Value
FROM customer_transactions_fixed;

-- 3. Average transaction amount
SELECT
    AVG(Amount) AS Average_Transaction_Amount
FROM customer_transactions_fixed;

-- 4. Total number of transactions
SELECT
    COUNT(*) AS Total_Transactions
FROM customer_transactions_fixed;

-- 5. Transaction count by status
SELECT
    Status,
    COUNT(*) AS Transaction_Count
FROM customer_transactions_fixed
GROUP BY Status
ORDER BY Transaction_Count DESC;

-- 6. Transaction value by category
SELECT
    Category,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Value
FROM customer_transactions_fixed
GROUP BY Category
ORDER BY Total_Value DESC;

-- 7. Transaction value by city
SELECT
    City,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Value
FROM customer_transactions_fixed
GROUP BY City
ORDER BY Total_Value DESC;

-- 8. Transaction value by channel
SELECT
    Channel,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Value
FROM customer_transactions_fixed
GROUP BY Channel
ORDER BY Total_Value DESC;

-- 9. High-value transactions
SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Date,
    Amount,
    City,
    Category,
    Channel
FROM customer_transactions_fixed
WHERE Amount > 1500
ORDER BY Amount DESC;

-- 10. Number of high-value transactions
SELECT
    COUNT(*) AS High_Value_Transactions
FROM customer_transactions_fixed
WHERE Amount > 1500;

-- 11. Total value of high-value transactions
SELECT
    SUM(Amount) AS High_Value_Transaction_Value
FROM customer_transactions_fixed
WHERE Amount > 1500;

-- 12. Unusual-hour transactions
SELECT
    COUNT(*) AS Unusual_Hour_Transactions
FROM customer_transactions_fixed
WHERE Transaction_Hour < 5;

-- 13. High-value transactions during unusual hours
SELECT
    COUNT(*) AS High_Value_Unusual_Hour
FROM customer_transactions_fixed
WHERE Amount > 1500
  AND Transaction_Hour < 5;

-- 14. Value of high-value transactions during unusual hours
SELECT
    SUM(Amount) AS High_Value_Unusual_Hour_Value
FROM customer_transactions_fixed
WHERE Amount > 1500
  AND Transaction_Hour < 5;

-- 15. Transactions requiring review
SELECT
    COUNT(*) AS Transactions_For_Review
FROM customer_transactions_fixed
WHERE Amount > 1500
   OR Transaction_Hour < 5;

-- 16. Total value of transactions requiring review
SELECT
    SUM(Amount) AS Review_Transaction_Value
FROM customer_transactions_fixed
WHERE Amount > 1500
   OR Transaction_Hour < 5;

-- 17. Top 10 customers by transaction count
SELECT
    Customer_ID,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Value
FROM customer_transactions_fixed
GROUP BY Customer_ID
ORDER BY Transaction_Count DESC
LIMIT 10;

-- 18. Top 10 customers by transaction value
SELECT
    Customer_ID,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Value
FROM customer_transactions_fixed
GROUP BY Customer_ID
ORDER BY Total_Value DESC
LIMIT 10;

-- 19. Failed transactions by city
SELECT
    City,
    COUNT(*) AS Failed_Transactions
FROM customer_transactions_fixed
WHERE Status = 'Failed'
GROUP BY City
ORDER BY Failed_Transactions DESC;

-- 20. Failed transaction rate
SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN Status = 'Failed' THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS Failed_Transaction_Rate
FROM customer_transactions_fixed;

-- 21. High-value transactions by category
SELECT
    Category,
    COUNT(*) AS High_Value_Count,
    SUM(Amount) AS High_Value_Total
FROM customer_transactions_fixed
WHERE Amount > 1500
GROUP BY Category
ORDER BY High_Value_Total DESC;

-- 22. Unusual-hour transactions by channel
SELECT
    Channel,
    COUNT(*) AS Unusual_Hour_Count,
    SUM(Amount) AS Unusual_Hour_Value
FROM customer_transactions_fixed
WHERE Transaction_Hour < 5
GROUP BY Channel
ORDER BY Unusual_Hour_Value DESC;

-- 23. Combined risk signals by city
SELECT
    City,
    COUNT(*) AS Review_Count,
    SUM(Amount) AS Review_Value
FROM customer_transactions_fixed
WHERE Amount > 1500
   OR Transaction_Hour < 5
GROUP BY City
ORDER BY Review_Value DESC;