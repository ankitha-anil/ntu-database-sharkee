WITH Phone(Product_ID, Product_Name, Price) AS ( 

SELECT P.Product_ID, P.Product_Name, H.Price 

From Products P, PriceHistory H 

WHERE P.Product_ID = H.Product_ID 

) 

SELECT Product_Name, AVG(PriceHistory.Price) AS Average_Price 

FROM Phone, PriceHistory 

WHERE Product_Name = 'iPhone XS' and Phone.Product_ID = PriceHistory.Product_ID 

AND StartDate > '2020-07-31' AND EndDate < '2020-09-01' 

GROUP BY Product_Name; 
