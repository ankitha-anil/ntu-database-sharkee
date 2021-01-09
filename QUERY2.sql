SELECT P.Product_Name, AVG(F.Rating) AS 'Average Rating', COUNT(F.Rating) AS 'Number of ratings' 

FROM Products P WITH(INDEX(PIDINDEX)), Feedback F WITH(INDEX(FIDINDEX)) 

WHERE P.Product_ID = F.Product_ID 

GROUP BY Product_Name 

HAVING COUNT(CASE WHEN F.Rating = '5' THEN 1 END) > 100 

ORDER BY AVG(F.Rating) 