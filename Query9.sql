WITH ProductSales(Product_Name, Product_ID, Month) AS (
SELECT P.Product_Name, P.Product_ID, FORMAT(O.Order_datetime,'yyyy-MM') AS Month
FROM Products P, ProductInOrder PO, Orders O
WHERE P.Product_ID = PO.Product_ID AND PO.Order_ID = O.Order_ID
GROUP BY  P.Product_Name, P.Product_ID, O.Order_datetime
),


--Table that counts the duplicates of each product in a given month
SalesPerMonth(Product_Name, Product_ID ,Month, Quantity) AS (
SELECT Product_Name, Product_ID, Month, COUNT(*) As Quantity
FROM ProductSales
GROUP BY Product_Name, Product_ID, Month
),
--Generate comparison table with 3 columns of successive months, returns NULL value if no previous month found
ComparisonTable(Product_Name, Product_ID, Month, Quantity_Month3, Quantity_Month2, Quantity_Month1) AS (
SELECT Product_Name, Product_ID, Month, Quantity AS 'Quantity_Month3', LAG(Quantity, 1) OVER(partition by Product_ID order by Month) AS 'Quantity_Month2', LAG(Quantity, 2) OVER(partition by Product_ID order by Month) AS 'Quantity_Month1'
FROM SalesPerMonth
GROUP BY Product_Name, Product_ID, Month, Quantity
)
--Returns all products that have successively increased sales over 3 months
SELECT C.Product_Name, C.Product_ID
FROM ComparisonTable C
WHERE Quantity_Month3 > Quantity_Month2 AND Quantity_Month2 > Quantity_Month1
GROUP BY Product_Name, Product_ID
