--select top 5 purchases, unique user purchase excludes repeated orders by same user
SELECT TOP 5 with TIES 
COUNT(DISTINCT(Orders.User_ID)) as UniqueUserPurchases, Product_Name, 
SUM(PIO.Quantity) as NumberOfProductPurchased 
FROM ProductInOrder AS PIO
--Join orders, users and product table
JOIN Orders ON Orders.Order_ID = PIO.Order_ID 
JOIN Users ON Orders.User_ID = Users.User_ID
JOIN Products ON Products.Product_ID = PIO.Product_ID
--filter by month
WHERE DATEPART(month, Orders.Order_datetime) = 8 
--group by pdt name
GROUP BY Product_Name 
--filter out only those where unique purchase count<Total number of users 
HAVING COUNT(DISTINCT(Orders.User_ID)) < (SELECT COUNT(User_ID) FROM Users) 
--arrange in desc
ORDER BY NumberOfProductPurchased DESC 
