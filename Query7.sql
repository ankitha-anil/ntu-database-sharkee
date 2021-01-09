-- Get user with most complaints /top complainer
WITH TopC(User_ID) AS (
SELECT 
    User_ID
FROM 
    Complaints
WHERE 
    User_ID = (SELECT TOP 1 with ties User_ID
	FROM Complaints
	GROUP BY User_ID
	ORDER BY COUNT(*) DESC))
-- get the products he has ordered, rank by price in desc order, select top 1 with ties
Select  TOP 1 WITH TIES 
PO.Product_ID, Products.Product_Name,Order_price
from TopC T, Orders O
LEFT JOIN ProductInOrder PO ON O.Order_ID=PO.Order_ID
LEFT JOIN Products ON PO.Product_ID = Products.Product_ID
where T.User_ID =  O.User_ID
Order by Order_price DESC;
