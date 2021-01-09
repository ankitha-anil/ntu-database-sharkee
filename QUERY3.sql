WITH AvgTIME(Product_Name, AvgTime) AS( 

SELECT Products.Product_Name, AVG(DATEDIFF(DAY, O.Order_datetime, P.DeliveryDate)) as AvgTime 

FROM Orders O, ProductInOrder P, Products 

WHERE O.Order_ID = P.Order_ID and O.Order_datetime>= ‘2020-06-01’ and O.Order_datetime<= ‘2020-06-30’ and P.DeliveryDate is NOT NULL and Products.Product_ID = P.Product_ID 

GROUP BY Product_Name) 
SELECT AVG(AvgTime) as AvgTime 

FROM AvgTIME; 