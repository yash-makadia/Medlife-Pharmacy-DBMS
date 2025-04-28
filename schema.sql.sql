--Create the Tables

USE BUDT703_Project_0502_01

-- Drop the table if exists
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Drug;
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS HourlyEmployee;
DROP TABLE IF EXISTS FullTimeEmployee;
DROP TABLE IF EXISTS ContractEmployee;
DROP TABLE IF EXISTS Company;


-- SQL Queries to create the tables
CREATE TABLE Company (
	cmpName VARCHAR (30) NOT NULL,
	cmpPhone CHAR(10),
	cmpAddress VARCHAR(50),
	CONSTRAINT pk_Company_cmpName PRIMARY KEY (cmpName))


CREATE TABLE Drug (
	drgBarcode CHAR (10) NOT NULL,
	drgName VARCHAR(30),
	drgType VARCHAR(20),
	drgDose INTEGER,
	drgCode VARCHAR(10),
	drgCostPrice DECIMAL(6,2),
	drgSellPrice DECIMAL(6,2),
	drgProductionDate DATE,
	drgExpirationDate DATE,
	drgQuantity INTEGER,
	drgProfit DECIMAL(6,2),
	cmpName VARCHAR (30) NOT NULL,
	CONSTRAINT pk_Drug_drgBarcode PRIMARY KEY (drgBarcode),
	CONSTRAINT fk_Drug_cmpName FOREIGN KEY (cmpName ) 
		REFERENCES Company (cmpName )
		ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE Inventory (
	invId CHAR(10) NOT NULL,
	invType VARCHAR(20),
	invAddress VARCHAR (50),
	CONSTRAINT pk_Inventory_invId PRIMARY KEY (invId))

CREATE TABLE Employee (
	empId VARCHAR (10) NOT NULL,
    empName VARCHAR (20),
    empPhone CHAR (12),
    empAddress VARCHAR (50),
    empPassword VARCHAR (20),
	emp_type VARCHAR(20),
	CONSTRAINT pk_Employee_empId PRIMARY KEY (empId) )

CREATE TABLE Customer (
	cstId VARCHAR (10) NOT NULL,
    cstName VARCHAR (20),
    cstPhone CHAR (10),
    cstDOB DATE,  
    empId VARCHAR (10) NOT NULL,    	
	CONSTRAINT pk_Customer_cstId PRIMARY KEY (cstId), 
	CONSTRAINT fk_Customer_cmpName FOREIGN KEY (empId) 
		REFERENCES Employee (empId)
		ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE Bill (
	bilId CHAR (10) NOT NULL,
	bilType VARCHAR (20),
	bilDate DATE,
	bilPrice DECIMAL (8,2),
    cstId VARCHAR (10) NOT NULL,
	CONSTRAINT pk_Bill_bilId PRIMARY KEY (bilId),
	CONSTRAINT fk_Bill_cstId FOREIGN KEY (cstId) 
		REFERENCES Customer (cstId)
		ON DELETE NO ACTION ON UPDATE CASCADE )


CREATE TABLE Purchase (
	invId CHAR (10) NOT NULL,
	drgBarcode CHAR (10) NOT NULL,
	prcQuantity INTEGER,
	prcDate DATE,
	CONSTRAINT pk_Purchase_invId_drgBarcode PRIMARY KEY (invId, drgBarcode),
	CONSTRAINT fk_Purchase_invId FOREIGN KEY (invId)
		REFERENCES Inventory (invId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_Purchase_drgBarcode FOREIGN KEY (drgBarcode)
		REFERENCES Drug (drgBarcode)
		ON DELETE CASCADE ON UPDATE CASCADE)


CREATE TABLE Sale (
	drgBarcode CHAR (10) NOT NULL,
	bilId CHAR (10) NOT NULL,
	saleQty INTEGER,
	CONSTRAINT pk_Sale_drgBarcode_bilId PRIMARY KEY (drgBarcode, bilId),
	CONSTRAINT fk_Sale_drgBarcode FOREIGN KEY (drgBarcode)
		REFERENCES Drug (drgBarcode)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_Sale_bilId FOREIGN KEY (bilId)
		REFERENCES Bill (bilId)
		ON DELETE CASCADE ON UPDATE CASCADE)


CREATE TABLE HourlyEmployee(
	empId VARCHAR (10) NOT NULL,
    empHourlyRate DECIMAL (6,2),
	CONSTRAINT pk_HourlyEmployee_empId PRIMARY KEY (empId),
    CONSTRAINT fk_HourlyEmployee_cmpName FOREIGN KEY (empId) 
		REFERENCES Employee (empId)
		ON DELETE CASCADE ON UPDATE CASCADE)


CREATE TABLE FullTimeEmployee (
	empId VARCHAR (10) NOT NULL,
    empSalary DECIMAL (10,2),
    empStockAmount  DECIMAL (9,2),
    empPaidLeave INTEGER,
	CONSTRAINT pk_FullTimeEmployee_empId PRIMARY KEY (empId), 
    CONSTRAINT fk_FullTimeEmployee_cmpName FOREIGN KEY (empId) 
		REFERENCES Employee (empId)
		ON DELETE CASCADE  ON UPDATE CASCADE)



CREATE TABLE ContractEmployee (
	empId VARCHAR (10) NOT NULL,
    empContractDurationMonths INTEGER,
    empContractAmount DECIMAL (9,2),
	CONSTRAINT pk_ContractEmployee_empId PRIMARY KEY (empId), 
    CONSTRAINT fk_ContractEmployee_cmpName FOREIGN KEY (empId)
		REFERENCES Employee (empId)
		ON DELETE CASCADE ON UPDATE CASCADE)

-- insert the data into the tables

INSERT INTO Company (cmpName, cmpPhone, cmpAddress)
VALUES ('Pfizer Inc', '2127332323', '235 East 42nd Street New York NY 10017 USA'),
('AbbVie Inc' , '8002555162', '1 North Waukegan Road North Chicago, IL 60064 USA'),
('Johnson & Johnson' , '3017388172', 'New Brunswick, NJ 08933 USA');

INSERT INTO Company (cmpName, cmpPhone, cmpAddress)
VALUES ('Roche', '2129032323', '236, East 41st Street, New York, NY 10017, USA'),
('Merck' , '9007388172', '12345, New Brunswick, NJ 08933 USA'),
('Sanofi' , '9006788172', '1345, New hampshire, VA 98983 USA'),
('Astrazeneca' , '9009088172', '33467, Baltimore Ave, MD 20740 USA'),
('Novartis' , '9007388172', '1, South Wan Road, North Chicago, IL 60063, USA');

INSERT INTO Drug (drgBarcode ,drgName, drgType, drgDose, drgCode, drgCostPrice, drgSellPrice, drgProductionDate, drgExpirationDate, drgQuantity, cmpName)
VALUES ('1112908900', 'Atorvastatin', 'Prescription' , 2, '2d00', 23.4, 29.9, '2022-08-11', '2025-08-11', 12, 6.5, 'Pfizer Inc'),
 ('1112908901', 'Levothyroxine', 'Prescription' , 2, '3m50', 13.4, 20.5, '2020-07-12', '2022-07-12', 16, 7.1, 'AbbVie Inc'),
 ('1112908902', 'Metformin', 'Prescription' , 1, '4f30', 43.4, 55.9, '2021-11-13', '2025-11-13', 20, 12.5, 'Johnson & Johnson');

INSERT INTO Drug (drgBarcode ,drgName, drgType, drgDose, drgCode, drgCostPrice, drgSellPrice, drgProductionDate, drgExpirationDate, drgQuantity, cmpName, drgProfit)
VALUES ('1112908905', 'Alecensa', 'Prescription' , 3, '2d10', 20.4, 21.9, '2021-07-11', '2025-08-11', 12, 'Roche',1.5),
 ('1112908906', 'Esbriet', 'Prescription' , 2, '3h50', 15.4, 24.5, '2022-07-12', '2025-07-12', 16, 'Roche', 9.1),
 ('1112908907', 'Adakveo', 'Prescription' , 1, '4f90', 23.4, 32.9, '2021-11-13', '2025-11-13', 20, 'Novartis', 9.5),
 ('1112908908', 'Arzerra', 'Prescription' , 1, '4f00', 143.4, 155.9, '2021-11-13', '2025-11-13', 10, 'Novartis', 12.5),
 ('1112908909', 'Clarinex', 'Prescription' , 1, '6s30', 83.4, 95.9, '2022-11-13', '2025-12-13', 15, 'Merck', 12.5),
 ('1112908910', 'Fosamax', 'Prescription' , 1, '9j90', 3.4, 5.9, '2020-07-13', '2025-11-13', 17, 'Merck', 2.5),
 ('1112908911', 'Adacel', 'Prescription' , 1, 'sf30', 23.4, 35.9, '2021-11-13', '2023-11-13', 25, 'Sanofi', 12.5),
 ('1112908912', 'Admelog', 'Prescription' , 1, 'gg30', 53.4, 65.9, '2022-09-13', '2025-10-13', 25, 'Sanofi', 12.5),
 ('1112908913', 'Lokelma', 'Prescription' , 1, 'df20', 47.4, 57.9, '2022-07-13', '2027-11-13', 22, 'Astrazeneca', 10.5),
 ('1112908914', 'Nexium', 'Prescription' , 1, 'sf30', 49.4, 59.9, '2022-05-13', '2024-11-13', 26, 'Astrazeneca', 10.5);

INSERT INTO Inventory (invId, invType, invAddress)
VALUES ('A345678900', 'Warehouse', '3240 Fawn Circle, PA 204567'),
 ('A345678901', 'Warehouse', '6210 Belcrest Road, Hyattsville 20782'),
 ('A345678902', 'Warehouse', '4330 Heart Break road, College park 20742');

INSERT INTO  Employee (empId, empName, empPhone, empAddress, empPassword, empType)
VALUES ('1111192779','John Walker', '457890894', '571 Gulf Ave., Onalaska, WI 54650', 'gjkTYU&56^', 'Hourly'),
('1111192780','Raja Syan', '2405678894', '972 N. Myrtle St., Southampton, PA 18966', 'GHJKU&46^','Hourly'),
('1111192781','Yash Taylor', '2046378894', '829 Edgewater Street, Nashua, NH 03060', 'LKJ78&56^','Hourly'),
('1111192782','Zeel Patel', '1206378894', '118 Spring Dr., Poughkeepsie, NY 12601', 'UIOP34&5z^', 'FullTime'),
('1111192783','Vikram Walker', '2316378894', '78 Olive St., Vernon Hills, IL 60061', 'LKJrtU&56^', 'FullTime'),
('1111192784','Harsh Zalavadia', '4845678894', '9743 Big Rock Cove Court, Coventry, RI 02816', '9087Y&56^', 'FullTime'),
('1111192785','Nishant Vun', '2406378894', '500 Fulton Rd., Delray Beach, FL 33445', 'opLAU&56^', 'Contract'),
('1111192786','Geet Maine', '34046378894', '8082 Pilgrim Circle, Glendale, AZ 85302', 'MNghU&56^', 'Contract'),
('1111192787','Riddhi Gawda', '8906378894', '9420 Harvard Dr., Maineville, OH 45039', 'op><YU&56^', 'Contract');

INSERT INTO  Employee (empId, empName, empPhone, empAddress, empPassword, empType)
VALUES ('1111192788','Sam Walker', '789090894', '47 Pawnee Street Maspeth, NY 11378', 'eefYU&56^', 'Hourly'),
('1111192789','Virat Syan', '89455678894', '51 Airport Street Morrisville, PA 19067', 'jklKU&46^', 'Hourly'),
('1111192790','Zeel Taylor', '9089778894', '9836 Maiden Ave. Shrewsbury, MA 01545', 'qwe78&56^', 'Hourly'),
('1111192791','Jack Patel', '9088978894', '9962 Kent Rd. Lawrenceville, GA 30043', 'hjkl34&5z^', 'Hourly'),
('1111192792','Jhony Walker', '6616378894', '7412 Somerset Avenue Holly Springs, NC 27540', 'vbnrtU&56^', 'Hourly'),
('1111192793','Harsh Jaskal', '0945678894', '9853 Golf Lane Nutley, NJ 07110', '1089Y&56^', 'Hourly'),
('1111192794','Nishant Bun', '1206378894', '7781 Del Monte St. Middle Village, NY 11379', 'cvbAU&56^', 'Hourly'),
('1111192795','Sherine Maine', '34046309780', '9451 Henry Dr. Indiana, PA 15701', 'yuihU&56^', 'Hourly'),
('1111192796','Katha Gawda', '8906356789', '814 Clinton Lane Downingtown, PA 19335', 'yt.*<YU&56^', 'Hourly');

INSERT INTO  Employee (empId, empName, empPhone, empAddress, empPassword, empType)
VALUES ('1111192797','Virat Kohli', '124590894', '90 Pawnee Street Maspeth, NY 11378', 'iopYU&56^', 'FullTime'),
('1111192798','Zyan Malik', '89455671234', '71 Airport Street Morrisville, PA 19067', 'sdfKU&46^', 'FullTime'),
('1111192799','Zeel Zalavadia', '9089776523', '7636 Maiden Ave. Shrewsbury, MA 01545', 'qwe78&56^', 'FullTime'),
('1111192800','Yash Patel', '9088972040', '9962 Kent Rd. Lawrenceville, GA 30043', 'bnml34&5z^', 'FullTime'),
('1111192801','Jhony Rodriguqez', '6616372040', '7412 Somerset Avenue Holly Springs, NC 27540', 'ghjktU&56^', 'FullTime'),
('1111192802','Harsh Kamani', '0945672040', '9853 Golf Lane Nutley, NJ 07110', 'zxc9Y&56^', 'FullTime'),
('1111192803','Dessire Bun', '1206372040', '7781 Del Monte St. Middle Village, NY 11379', 'edcAU&56^', 'FullTime'),
('1111192804','Paul Maine', '34046302040', '9451 Henry Dr. Indiana, PA 15701', 'l,.hU&56^', 'FullTime'),
('1111192805','Katha Patel', '8906352040', '814 Clinton Lane Downingtown, PA 19335', 'yty.o<YU&56^', 'FullTime');

INSERT INTO  Employee (empId, empName, empPhone, empAddress, empPassword, empType)
VALUES ('1111192806','Rasi Khanna', '789090894', '47 Pawnee Street Maspeth, NY 11378', 'eefYU&56^', 'Contract'),
('1111192807','Dhoni Syan', '89455678894', '51 Airport Street Morrisville, PA 19067', 'jklKU&46^', 'Contract'),
('1111192808','Adam Taylor', '9089778894', '9836 Maiden Ave. Shrewsbury, MA 01545', 'qwe78&56^', 'Contract'),
('1111192809','Ayushi Patel', '9088978894', '9962 Kent Rd. Lawrenceville, GA 30043', 'hjkl34&5z^', 'Contract'),
('1111192810','Aashay Pandya', '6616378894', '7412 Somerset Avenue Holly Springs, NC 27540', 'vbnrtU&56^', 'Contract'),
('1111192811','Harsh Pandya', '0945678894', '9853 Golf Lane Nutley, NJ 07110', '1089Y&56^', 'Contract'),
('1111192812','Harshil Dani', '1206378894', '7781 Del Monte St. Middle Village, NY 11379', 'cvbAU&56^', 'Contract'),
('1111192813','Vatsal Patel', '34046309780', '9451 Henry Dr. Indiana, PA 15701', 'yuihU&56^', 'Contract'),
('1111192814','Harsh Gawda', '8906356789', '814 Clinton Lane Downingtown, PA 19335', 'yt.*<YU&56^', 'Contract');

INSERT INTO HourlyEmployee (empId, empHourlyRate)
VALUES ('1111192779', 15.80),
('1111192780', 17.90),
('1111192781', 23.60);

INSERT INTO HourlyEmployee (empId, empHourlyRate)
VALUES ('1111192788', 16.80),
('1111192789', 12.90),
('1111192790', 24.60),
('1111192791', 25.60),
('1111192792', 13.60),
('1111192793', 26.60),
('1111192794', 21.60),
('1111192795', 13.60),
('1111192796', 10.60);

INSERT INTO FullTimeEmployee (empId, empSalary, empStockAmount, empPaidLeave)
VALUES ('1111192782', 23456.90, 34532.00, 25),
('1111192783', 63456.20, 4532.00, 20),
('1111192784', 53436.90, 14532.00, 35);


INSERT INTO FullTimeEmployee (empId, empSalary, empStockAmount, empPaidLeave)
VALUES ('1111192797', 33456.90, 12532.00, 23),
('1111192798', 83456.20, 5532.00, 22),
('1111192799', 12436.90, 17532.00, 20),
('1111192800', 76456.90, 56532.00, 25),
('1111192801', 23456.20, 5432.00, 20),
('1111192802', 90436.90, 39532.00, 35),
('1111192803', 12456.90, 53532.00, 25),
('1111192804', 87456.20, 9032.00, 20),
('1111192805', 45436.90, 63532.00, 35);


INSERT INTO ContractEmployee (empId, empContractDurationMonths, empContractAmount)
VALUES ('1111192785', 15, 89098.00),
('1111192786', 25, 180040.00),
('1111192787', 5, 19398.00);

INSERT INTO ContractEmployee (empId, empContractDurationMonths, empContractAmount)
VALUES ('1111192806', 12, 90098.00),
('1111192807', 15, 190040.00),
('1111192808', 5, 21398.00),
('1111192809', 25, 91098.00),
('1111192810', 15, 200040.00),
('1111192811', 10, 22398.00),
('1111192812', 24, 89098.00),
('1111192813', 25, 230040.00),
('1111192814', 5, 22398.00);


INSERT INTO Customer (cstId, cstName, cstPhone, cstDOB, empId)
VALUES ('A33BH90121', 'Jerome Heff', '2239098767', '2002-09-09', '1111192779'),
('A33BH90122', 'Jafer Heff', '3456698767', '2003-09-09', '1111192781'),
('A33BH90123', 'Adam Heff', '9089098767', '2004-09-09', '1111192782');

INSERT INTO Customer (cstId, cstName, cstPhone, cstDOB, empId)
VALUES ('A33BH90124', 'Jerome Heff', '2239098767', '2002-09-09', '1111192806'),
('A33BH90125', 'Jafer Heff', '3456698767', '2003-09-09', '1111192807'),
('A33BH90126', 'Adam Heff', '9089098767', '2004-09-09', '1111192808');

INSERT INTO Customer (cstId, cstName, cstPhone, cstDOB, empId)
VALUES ('A33BH90127', 'Jerome Heff', '2239098767', '2002-09-09', '1111192809'),
('A33BH90128', 'Jafer Heff', '3456698767', '2003-09-09', '1111192810'),
('A33BH90129', 'Virat Heff', '9089098767', '2004-09-09', '1111192812'),
('A33BH90130', 'Jerome Patel', '2239098767', '2002-09-09', '1111192813'),
('A33BH90131', 'Harsh Heff', '3456698767', '2003-09-09', '1111192814');

INSERT INTO Customer (cstId, cstName, cstPhone, cstDOB, empId)
VALUES ('A33BH90132', 'Jerome Heff', '2239098767', '2002-09-09', '1111192797'),
('A33BH90133', 'Jafer Heff', '3456698767', '2003-09-09', '1111192798'),
('A33BH90134', 'Virat Heff', '9089098767', '2004-09-09', '1111192799'),
('A33BH90135', 'Jerome Patel', '2239098767', '2002-09-09', '1111192800'),
('A33BH90136', 'Harsh Heff', '3456698767', '2003-09-09', '1111192801');

INSERT INTO Bill (bilId , bilType, bilDate, bilPrice, cstId)
VALUES('B234568201', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90121'),
('B234568202', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90122'),
('B234568203', 'Over The Counter', '2022-03-30', 354.84, 'A33BH90123');

INSERT INTO Bill (bilId , bilType, bilDate, bilPrice, cstId)
VALUES('B234568204', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90124'),
('B234568205', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90125'),
('B234568206', 'Over The Counter', '2022-03-30', 354.84, 'A33BH90126');

INSERT INTO Bill (bilId , bilType, bilDate, bilPrice, cstId)
VALUES('B234568207', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90127'),
('B234568208', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90128'),
('B234568209', 'Over The Counter', '2022-03-30', 354.84, 'A33BH90129'),
('B234568210', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90130'),
('B234568211', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90131');

INSERT INTO Bill (bilId , bilType, bilDate, bilPrice, cstId)
VALUES('B234568212', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90132'),
('B234568213', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90133'),
('B234568214', 'Over The Counter', '2022-03-30', 354.84, 'A33BH90134'),
('B234568215', 'Over The Counter', '2022-08-11', 1024.59, 'A33BH90135'),
('B234568216', 'Self Checkout', '2021-05-21', 126.19, 'A33BH90136');

INSERT INTO Purchase (invId, drgBarcode , prcQuantity, prcDate)
VALUES ('A345678900', '1112908900', 10, '2022-08-11'),
('A345678901', '1112908901', 20, '2021-09-10'),
('A345678902', '1112908902', 15, '2022-07-12');

INSERT INTO Sale (drgBarcode, bilId, saleQty)
VALUES ('1112908900', 'B234568201', 23),
('1112908902', 'B234568202', 25),
('1112908901', 'B234568202', 20);

