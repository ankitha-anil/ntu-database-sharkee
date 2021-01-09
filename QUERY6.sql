WITH TotalRevenue(Shop_ID,ShopName,Revenue) AS
(select S.Shop_ID,S.Shop_Name, SUM(PO.Order_price * PO.Quantity) AS Revenue
from ProductInOrder PO,Shops S
where PO.Shop_ID = S.Shop_ID and PO.DeliveryDate >= '2020-08-01' and PO.DeliveryDate <= '2020-08-31'
group by S.Shop_ID,S.Shop_Name)

select TOP 1 with TIES 
ShopName, Revenue
from TotalRevenue
Order by Revenue DESC;
