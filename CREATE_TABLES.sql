CREATE TABLE Employee( 
Employee_ID int NOT NULL, 
Employee_Name varchar(50) NOT NULL, 
Salary int, 
PRIMARY KEY(Employee_ID)  
) 
 
CREATE TABLE Users( 
User_ID int NOT NULL, 
User_Name varchar(50) NOT NULL, 
PRIMARY KEY(User_ID), 
) 
 
CREATE TABLE Shops( 
Shop_ID int NOT NULL, 
Shop_Name varchar(50) NOT NULL, 
PRIMARY KEY(Shop_ID) 
) 
 
CREATE TABLE Orders( 
Order_ID int NOT NULL, 
User_ID int NOT NULL, 
Shipping_Address varchar(250) NOT NULL, 
Order_datetime datetime NOT NULL,  
PRIMARY KEY(Order_ID), 
FOREIGN KEY(User_ID) REFERENCES Users(User_ID), 
) 
 
CREATE TABLE Products( 
Product_ID int NOT NULL, 
Product_Name varchar(50) NOT NULL, 
Maker varchar(50), 
Category varchar(50) 
PRIMARY KEY(Product_ID) 
) 
 
CREATE TABLE Complaints( 
Complaints_ID int NOT NULL, 
Employee_ID int,  
User_ID int NOT NULL,  
Shop_ID int NOT NULL,  
Order_ID int NOT NULL, 
Complaints_Status varchar(50),  
text varchar(300),  
FilledDateTime datetime NOT NULL,  
HandledDateTime datetime, 
PRIMARY KEY(Complaints_ID), 
FOREIGN KEY(Employee_ID) REFERENCES Employee(Employee_ID), 
FOREIGN KEY(User_ID) REFERENCES Users(User_ID), 
FOREIGN KEY(Shop_ID) REFERENCES Shops(Shop_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
) 
 
CREATE TABLE Feedback( 
User_ID int NOT NULL, 
Product_ID int NOT NULL, 
Feedback_datetime datetime NOT NULL, 
Comment varchar(250), 
Rating int, 
PRIMARY KEY(User_ID,Product_ID,Feedback_datetime), 
FOREIGN KEY(User_ID) REFERENCES Users(User_ID), 
FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
) 
 
CREATE TABLE ProductInOrder( 
Order_ID int NOT NULL, 
Product_ID int NOT NULL, 
Shop_ID int NOT NULL, 
ProductInOrder_Status varchar(50) , 
Order_price float NOT NULL, 
Quantity int, 
DeliveryDate datetime,  
PRIMARY KEY(Order_ID, Product_ID, Shop_ID), 
FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(Shop_ID) REFERENCES Shops(Shop_ID) 
ON DELETE CASCADE ON UPDATE CASCADE 
) 
 
CREATE TABLE ProductInShops( 
Shop_ID int NOT NULL, 
Product_ID int NOT NULL, 
Shop_Price float NOT NULL, 
Quantity int NOT NULL, 
PRIMARY KEY(Product_ID), 
FOREIGN KEY(Shop_ID) REFERENCES Shops(Shop_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(PRODUCT_ID) REFERENCES Products(Product_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
) 
 
CREATE TABLE PriceHistory( 
Shop_ID int NOT NULL, 
Product_ID int NOT NULL, 
StartDate DATETIME, 
EndDate DATETIME, 
Price float NOT NULL 
PRIMARY KEY(Shop_ID, Product_ID, StartDate) 
FOREIGN KEY(Shop_ID) REFERENCES Shops(Shop_ID) 
ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID) 
ON DELETE CASCADE ON UPDATE CASCADE 
) 