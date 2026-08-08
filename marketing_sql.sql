USE marketing_analytics;

-- =====================================================
-- QUERY 1: Overall Marketing KPIs
-- =====================================================

SELECT
    COUNT(DISTINCT ID) AS Total_Customers,
    SUM(Total_Spending) AS Total_Spending,
    ROUND(AVG(Total_Spending), 2) AS Avg_Customer_Spending,
    SUM(Total_Purchases) AS Total_Purchases,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases_Per_Customer,
    ROUND(AVG(Response) * 100, 2) AS Campaign_Response_Rate
FROM marketing_customers;


-- =====================================================
-- QUERY 2: Customer Segment Performance
-- =====================================================

SELECT
    Customer_Segment,
    COUNT(*) AS Customers,
    SUM(Total_Spending) AS Total_Spending,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY Customer_Segment
ORDER BY Total_Spending DESC;

-- =====================================================
-- QUERY 3: Preferred Purchase Channel
-- =====================================================

SELECT
    Preferred_Channel,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY Preferred_Channel
ORDER BY Customers DESC;

-- =====================================================
-- QUERY 4: Customer Segment by Preferred Channel
-- =====================================================

SELECT
    Customer_Segment,
    Preferred_Channel,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY
    Customer_Segment,
    Preferred_Channel
ORDER BY
    Customer_Segment,
    Avg_Spending DESC;
    
    -- =====================================================
-- QUERY 5: Product Category Performance
-- =====================================================

SELECT
    SUM(MntWines) AS Wine_Spending,
    SUM(MntMeatProducts) AS Meat_Spending,
    SUM(MntGoldProds) AS Gold_Spending,
    SUM(MntFishProducts) AS Fish_Spending,
    SUM(MntSweetProducts) AS Sweet_Spending,
    SUM(MntFruits) AS Fruit_Spending
FROM marketing_customers;

-- =====================================================
-- QUERY 6: High-Value Customers Who Did Not Respond
-- =====================================================

SELECT
    ID,
    Total_Spending,
    Total_Purchases,
    Preferred_Channel,
    Recency,
    Campaign_Engagement
FROM marketing_customers
WHERE Customer_Segment = 'High Value'
  AND Response = 0
ORDER BY Total_Spending DESC;

-- =====================================================
-- QUERY 7: High-Value Customers With Long Recency
-- =====================================================

SELECT
    ID,
    Total_Spending,
    Total_Purchases,
    Preferred_Channel,
    Recency,
    Campaign_Engagement,
    Response_Status
FROM marketing_customers
WHERE Customer_Segment = 'High Value'
  AND Recency > 90
ORDER BY Total_Spending DESC;

-- =====================================================
-- QUERY 8: High-Value Customers With Recency > 90
-- Opportunity Summary
-- =====================================================

SELECT
    COUNT(*) AS Customers_At_Risk,
    SUM(Total_Spending) AS Total_Spending_At_Risk,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases
FROM marketing_customers
WHERE Customer_Segment = 'High Value'
  AND Recency > 90;
  
  -- =====================================================
-- QUERY 9: At-Risk High-Value Customers by Response
-- =====================================================

SELECT
    Response_Status,
    COUNT(*) AS Customers,
    SUM(Total_Spending) AS Total_Spending,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending
FROM marketing_customers
WHERE Customer_Segment = 'High Value'
  AND Recency > 90
GROUP BY Response_Status
ORDER BY Customers DESC;

-- =====================================================
-- QUERY 10: Campaign Engagement vs Customer Value
-- =====================================================

SELECT
    Campaign_Engagement,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY Campaign_Engagement
ORDER BY Avg_Spending DESC;

-- =====================================================
-- QUERY 11: Recency Segment vs Campaign Response
-- =====================================================

SELECT
    Recency_Segment,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY Recency_Segment
ORDER BY Avg_Spending DESC;

-- =====================================================
-- QUERY 12: Education vs Customer Value & Response
-- =====================================================

SELECT
    Education,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Spending), 2) AS Avg_Spending,
    ROUND(AVG(Total_Purchases), 2) AS Avg_Purchases,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM marketing_customers
GROUP BY Education
ORDER BY Avg_Spending DESC;
