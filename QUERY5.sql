WITH SamsungProducts(ID,PName,Maker) AS 
(select P.Product_ID,P.Product_Name,P.Maker
from Products P
where P.Maker ='Samsung')

select S.PName,Product_ID, COUNT(PS.Product_ID) as ShopsSellingSamsung
from ProductInShops PS,SamsungProducts S
where PS.Product_ID = S.ID
GROUP BY PS.Product_ID, S.PName;
