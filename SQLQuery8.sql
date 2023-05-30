--create of table client_master
create table Client_Master(ClientNo varchar(6) primary key check(ClientNo like 'c%'),
Name varchar(20) not null,
Address1 varchar(30),
Address2 varchar(30),
City varchar(15),
PinCode numeric(8),
State varchar(15),
BalDue numeric(10,2)
);


--create of table product_master
create table Product_Master(ProductNo varchar(6) primary key check(ProductNo like 'p%'),
Description varchar(15) not null,
ProfitPerc numeric(4,2)not null,
UniMeasure varchar(10)not null,
QtyOnHand numeric(8)not null,
ReOrderLvl numeric(8)not null,
SellPrice numeric(8,2)not null check(SellPrice<>0),
CostPrice numeric(8,2)not null check(SellPrice<>0),
);
--create of table salesman_master
create table Salesman_Master(SalesmanNo varchar(6) primary key check(salesManNo like 's%'),
SalesmanName varchar(20) not null,
Address1 varchar(30) not null,
Address2 varchar(30),
City varchar(20),
PinCode numeric(8),
State varchar(20),
salamt numeric(8,2)not null check(salamt<>0),
tgttoget numeric(6,2)not null,
ytdsales numeric(6,2)not null,
remarks varchar(60)
);
--create of table sales_order
create table Sales_Order(OrderNo varchar(6) primary key check(OrderNo like 'o%'),
ClientNo varchar(6) CONSTRAINT FK_To_ClientMaster FOREIGN KEY (ClientNo) REFERENCES Client_Master(ClientNo),
OrderDate  date,
DelyAddr varchar(25),
SalesmanNo varchar(6) CONSTRAINT FK_To_SalesmanMaster foreign key(SalesmanNo) references Salesman_Master(SalesmanNo),
DelyType char(1) check(DelyType = 'p' or DelyType = 'F'),
BilledYn char(1) check(BilledYn = 'Y' or BilledYn = 'N'),
DelyDate Date,
OrderStatus varchar(10) check(OrderStatus = 'In Process' or OrderStatus='Fulfilled'  or OrderStatus='Backorder' or OrderStatus='Cancelled')
);

--create of table sales_order_details
create table Sales_Order_Details(OrderNo varchar(6) constraint FK_To_SalesOrder foreign key(OrderNo) references Sales_Order(OrderNo),
ProductNo varchar(6)  constraint FK_To_ProductMaster foreign key(ProductNo) references Product_Master(ProductNo),
QtyOrdered numeric(8),
QtyDisp numeric(8),
ProductRate numeric(10,2),
constraint composite_order_product primary key(OrderNo,ProductNo),
);


--Insert Queries
INSERT INTO Client_Master (ClientNo, Name, City, PinCode, State, BalDue) VALUES ('C00001', 'Ivan Bayross', 'Mumbai',400054, 'Maharashtra', 15000);
INSERT INTO product_Master VALUES ('P00001', 'T-Shirts',5,'Piece',200, 50, 350, 250);
INSERT INTO Salesman_Master VALUES ('S00001', 'Aman', 'A/14', 'Worli', 'Mumbai', 400002,'Maharashtra',3000, 100, 50, 'Good');
INSERT INTO Sales_Order (OrderNo, OrderDate, ClientNo, DelyType, BilledYn, SalesmanNo, DelyDate, OrderStatus)
VALUE('019001', '12-june-02', 'C00001', 'F', 'N', 'S00001', '20-july-02', 'In Process');
INSERT INTO Sales_Order_Details (OrderNo, ProductNo, QtyDisp, ProductRate) VALUES('019001', 'P00001', 4, 4, 525);




select Name from Client_Master;
select * from Client_Master where City = 'Mumbai';
select * from Product_Master where SellPrice >2000 and SellPrice<5000;
select Name,City,State from Client_Master where State NOT IN ('Maharashtra');
select *from Client_Master where ClientNo IN('C00001','C00002');
INSERT INTO product_Master VALUES ('P00002', '1.44 drive', 5, 'Piece', 200, 50, 350, 250);
UPDATE Product_Master
SET SellPrice = REPLACE(SellPrice, '350', '1150.50')

WHERE Description='1.44 drive';
DELETE FROM Client_Master WHERE ClientNo = 'C00005';
select * from Client_Master where city like '_a%;
select COUNT(ProductNo) from Product_Master where CostPrice >= 1500;
alter table Client_Master add constrain ClientNo primary key;
alter table Client_Master add phone_No numeric(10);
alter table Client_Master alter column Name varchar(60);