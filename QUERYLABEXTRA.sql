WITH AvgTIME(Product_Name, AvgTime, Shop_ID) AS(  

SELECT Products.Product_Name, AVG(DATEDIFF(DAY, O.Order_datetime, P.DeliveryDate)) as AvgTime , P.Shop_ID 

FROM Orders O, ProductInOrder P, Products  

WHERE O.Order_ID = P.Order_ID and P.DeliveryDate is NOT NULL and Products.Product_ID = P.Product_ID  

GROUP BY Shop_ID,Product_Name), 

 

MAXTIME(MaxTime, Shop_ID) AS( 

SELECT MAX(AvgTime) AS MaxTime, Shop_ID 

FROM AvgTIME  

GROUP BY Shop_ID) 

 

SELECT  MAXTIME.Shop_ID,  Shop_Name,Product_Name, MaxTime  

FROM MAXTIME 

JOIN AvgTIME ON AvgTIME.AvgTime = MaxTIME.MaxTime 

JOIN Shops ON  Shops.Shop_ID = MAXTIME.Shop_ID 

ORDER BY Shop_ID; 