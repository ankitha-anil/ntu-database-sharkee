CREATE TRIGGER ProductInOrderupdate  
ON ProductInOrder 
AFTER UPDATE 
NOT FOR REPLICATION  
AS  
BEGIN 
UPDATE ProductInOrder 
SET DeliveryDate = GETDATE()  
FROM ProductInOrder P, inserted i , deleted d 
WHERE P.Order_ID = i.Order_ID AND P.Product_ID = i.Product_ID AND i.ProductInOrder_Status = 'Delivered' 
END; 
GO 
 
CREATE TRIGGER ComplaintsUpdate  
ON Complaints 
AFTER UPDATE 
NOT FOR REPLICATION 
AS 
BEGIN 
UPDATE Complaints 
SET HandledDateTime = GETDATE() 
FROM Complaints C, inserted i, deleted d 
WHERE C.Complaints_Id = i.Complaints_ID AND i.Complaints_Status = 'Addressed' 
END; 

CREATE TRIGGER UpdatePriceHistory  
ON ProductInShops  
AFTER UPDATE 
AS 
BEGIN 
declare @shopId int; 
declare @productId int; 
declare @startDateTime DATETIME; 
declare @price int; 
select @shopId = ProductInShops.shop_ID from inserted ProductInShops; 
select @productId = ProductInShops.Product_ID from inserted ProductInShops; 
select @startDateTime = GetDate() 
select @price = ProductInShops.Shop_Price from inserted ProductInShops; 
begin 
UPDATE PriceHistory 
SET EndDate = GETDATE() 
FROM PriceHistory P, inserted i 
WHERE P.EndDate IS NULL  and P.Product_ID = @productId and P.Shop_ID = @shopId 
end 
INSERT into PriceHistory(Shop_ID,Product_ID,StartDate,Price) 
VALUES(@shopId,@productId,@startDateTime,@price) 
END;