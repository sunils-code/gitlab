USE ProjectDay
GO
CREATE TABLE Customer
(CustomerID INT NOT NULL
,FirstName VARCHAR NOT NULL
,LastName VARCHAR NOT NULL
,Phone int 
,Street VARCHAR
,City VARCHAR
,State VARCHAR
,ZIP VARCHAR
PRIMARY KEY (CustomerID)
);
GO

USE ProjectDay
GO
CREATE TABLE "Order"
(OrderID INT NOT NULL
,OrderNumber INT NOT NULL
,CustomerID INT NOT NULL
,OrderDate DATETIME 
,TotalAmount INT
PRIMARY KEY (OrderID)
);
GO

USE ProjectDay
GO
CREATE TABLE "OrderItem"
(OrderID INT NOT NULL
,ProductID INT NOT NULL
,CustomerID INT
,TotalAmount INT
PRIMARY KEY (OrderID,ProductID)
);
GO

USE ProjectDay
GO
CREATE TABLE "Product"
(ProductID INT NOT NULL
,ProductName VARCHAR 
,UnitPrice INT
PRIMARY KEY (ProductID)
);
GO

USE ProjectDay
GO
ALTER TABLE OrderItem
ADD CONSTRAINT FK_Order_OrderItem FOREIGN KEY (OrderID)
REFERENCES "Order" (OrderID)

USE ProjectDay
GO
ALTER TABLE OrderItem
ADD CONSTRAINT FK_Product_OrderItem FOREIGN KEY (ProductID)
REFERENCES Product (ProductID)

USE ProjectDay
GO
INSERT INTO Customer VALUES(1,'a','b', 1,'c','e','','f');
GO

USE ProjectDay
GO
INSERT INTO Customer VALUES(2,'b','c', 2,'d','e','','f');
GO

USE ProjectDay
GO
INSERT INTO Customer VALUES(3,'c','d', 3,'e','f','','g');
GO

USE ProjectDay
GO
INSERT INTO Customer VALUES(4,'e','f', 4,'g','h','','i');
GO

USE ProjectDay
GO
INSERT INTO Customer VALUES(5,'f','g', 5,'h','i','','j');
GO

USE ProjectDay
GO
INSERT INTO "Order" VALUES(1,1,1,GETDATE(),1);
GO

USE ProjectDay
GO
INSERT INTO "Order" VALUES(2,2,2,GETDATE(),2);
GO

USE ProjectDay
GO
INSERT INTO "Order" VALUES(3,3,3,GETDATE(),3);
GO

USE ProjectDay
GO
INSERT INTO "Order" VALUES(4,4,4,GETDATE(),4);
GO

USE ProjectDay
GO
INSERT INTO "Order" VALUES(5,5,5,GETDATE(),5);
GO

--/////////////////////CREATING VIEW///////////////////////
USE ProjectDay
GO
CREATE VIEW VW_ProjectDay
AS
SELECT o.OrderID
,o.OrderNumber
,o.OrderDate
,(c.FirstName + ' ' + c.LastName) AS 'CustomerName'
FROM Customer AS c
JOIN "Order" AS o ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, o.OrderNumber,o.OrderDate, c.FirstName,c.LastName;
GO

Select * FROM VW_ProjectDay;
GO

--////////////////////////CREATING STORED PROCEDURE//////////
CREATE PROCEDURE USP_ProjectDay
AS
 SELECT o.OrderID
,o.OrderNumber
,o.OrderDate
,(c.FirstName + ' ' + c.LastName) AS 'CustomerName'
FROM Customer AS c
JOIN "Order" AS o ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, o.OrderNumber,o.OrderDate, c.FirstName,c.LastName;
GO

EXEC USP_ProjectDay
GO
