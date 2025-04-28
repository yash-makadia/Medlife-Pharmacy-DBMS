
USE BUDT703_Project_0502_01


/*  
1. As part of our customer experience, we would like to know how our employees are doing with customer assistance. 
Are customers who purchase from our pharmacy, helped by Full-time employees or part-time (Hourly)? 
*/

-- Query 1
SELECT e.empType AS 'Employee Type' , COUNT(e.empId) AS 'Number of Customers' 
FROM Employee e where empId IN ( SELECT c.empId FROM Customer c, Bill b WHERE c.cstId = b.cstId)
GROUP BY e.empType
ORDER BY COUNT(e.empId) DESC;


/* 
2.For the purpose of efficient Inventory management, the manager wants to know the purchase quantity of drugs for any particlar month and year.
This will help the manager in  determining which drugs to buy in bulk and also determine the kind of contracts he/she wants to make with drug selling companies.
*/


-- Query 2
SELECT d.drgName AS 'Drug Name', p.drgBarcode AS 'Drug Barcode', d.cmpName AS 'Company Name', SUM(p.prcQuantity) AS 'Purchase Quantity'  
FROM Purchase p, Drug d 
WHERE YEAR(p.prcDate) = '2021' AND MONTH(p.prcDate) = '09' AND p.drgBarcode = d.drgBarcode
GROUP BY p.drgBarcode, d.drgName, d.cmpName
ORDER BY SUM(p.prcQuantity) DESC;


/*
3. The consumption pattern of drugs changes yearly. With the rise in variety of diseases and global outbreaks, the most-selling drugs are different for every year.
The Sales manager wants to see the most-selling drugs every year to analyze the trends and patterns and for forecasting purposes.
*/


-- QUERY 3
SELECT s.drgBarcode AS 'Drug Barcode', d.drgName AS 'Drug Name', d.cmpName AS 'Company Name', YEAR(b.bilDate) AS 'Year of Sale', SUM(s.saleQty) AS 'Sale Quantity' 
FROM Drug d, Sale s, Bill b
WHERE (Year(b.bilDate) IN (SELECT Year(b.bilDate) FROM Bill b GROUP BY YEAR(b.bilDate) ) 
AND (s.drgBarcode = d.drgBarcode AND s.bilId = b.bilId))
GROUP BY s.drgBarcode, d.drgName, d.cmpName, YEAR(b.bilDate)
ORDER BY SUM(s.saleQty) DESC, d.drgName;


/*
4. Profitabilty is an important part of any business. Medlife wants to estimate which drugs are the most profitable for them.
This will help the Sales manager and the Relationship manager to enter into long-term contracts for companies whose drugs are sold in highest number by Medlife.
*/


-- Query 4
SELECT d.drgType AS 'Drug Type', d.drgName AS 'Drug Name', d.cmpName AS 'Company Name', SUM(s.saleQty) AS 'Sale Quantity', ((SUM(d.drgProfit)*SUM(s.saleQty))/COUNT(s.drgBarcode)) AS 'Total Profit' 
FROM Drug d, Sale s 
WHERE d.drgBarcode = s.drgBarcode
GROUP BY  d.drgType, d.cmpName, d.drgName
ORDER BY d.drgType ASC , SUM(s.saleQty) DESC;

