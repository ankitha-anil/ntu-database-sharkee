With TopShop(SID, SName, Revenue) AS (
SELECT TOP 5 with TIES
PIO.Shop_ID, Shops.Shop_Name, SUM(PIO.Quantity * PIO.Order_price) as Revenue
FROM ProductInOrder as PIO
JOIN Shops ON Shops.Shop_ID = PIO.Shop_ID
JOIN Orders ON Orders.Order_ID = PIO.Order_ID
WHERE DATEPART(month, PIO.DeliveryDate) = 8
Group by PIO.Shop_ID,Shops.Shop_Name
ORDER BY Revenue DESC
),
Items(PName, PID) AS (
Select 
P.Product_Name, P.Product_ID
FROMProducts P
JOIN ProductInShops ON P.Product_ID = ProductInShops.Product_ID
WHERE ProductInShops.Shop_ID IN (SELECT SID FROM TopShop)
)

SELECT TOP 3 WITH TIES
PName, PID, AVG(F.Rating) as AverageRating, SUM(PIO.Quantity) as AmtSold
FROM Items, ProductInOrder PIO, Feedback F
WHERE Items.PID = PIO.Product_ID and Items.PID = F.Product_ID
Group by PName,PID
Order BY AverageRating DESC
