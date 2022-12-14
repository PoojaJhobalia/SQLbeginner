/* 4.3.1 Write a SQL statement that will show the SalesOrderID, TotalDue, FirstName, and LastName for all orders placed by customer 475. */
SELECT gs_Location.locationcity

/* 4.3.2 Write a SQL statement that shows all the managers and the city where they are a manager. Display Location City, First Name, Last Name, and Position Title. Order by Location City.*/
SELECT 

/* 4.3.3 Write a SQL statement that shows the OrderQty, ShipDate, FirstName, and LastName of anyone who purchased product 944.*/
SELECT orderQty, salesLT.salesOrderHeader.ShipDate, salesLT.Customer.FirstName, salesLT.Customer.LastName
FROM saleslt.SalesOrderDetail
INNER JOIN salesLT.SalesOrderHeader ON SalesLT.SalesOrderHeader.salesOrderID = SalesLT.SalesOrderDetail.salesOrderID
INNER JOIN salesLT.Customer ON salesLT.Customer.customerID = salesLT.SalesOrderHeader.CustomerID
WHERE ProductID = 944

/*4.4.1 Write a SQL statement that shows the average order TotalDue, sum of all orders, minimum order, and maximum order for every city that has an order billed to it. Show the City, StateProvince, and each of the above aggregate functions.*/
SELECT City, StateProvince, AVG(TotalDue) AvgTotalDue, SUM(TotalDue) SumOrder, MIN(TotalDue) MinOrder, MAX(TotalDue) MaxOrder
FROM SalesLT.SalesOrderHeader SH 
INNER JOIN SalesLT.CustomerAddress C ON SH.CustomerID=C.CustomerID
INNER JOIN SalesLT.Address A ON C.AddressID = A.AddressID
GROUP BY City, stateProvince
ORDER BY StateProvince DESC, City

/*4.4.3 Create a new field calculated as the potential profit margin for each product in the SalesLT.Product table. Name it ProfitMargin and sort the results by ProfitMargin descending and next by the product name. Show Product.Name and ProfitMargin. */
SELECT product.Name, ListPrice, StandardCost, ((ListPrice - StandardCost)/ListPrice)*100 AS ProfitMargin
FROM SalesLT.Product
ORDER BY ProfitMargin DESC, Product.Name;

/*4.6.1. Write a SQL statement that shows each of the employees hired between 1/1/1997 and 12/31/2002 (inclusive). Show all fields.*/
SELECT * FROM gs_Employee
WHERE hiredate BETWEEN '1997-1-1' AND '2003-1-1';

/*4.6.2.Show the first and last name only of employees who received a "Good" performance rating and earn more than $50,000.*/
SELECT firstname, lastname FROM gs_Employee WHERE performance='good' AND salary>50000;

/*4.6.3.From the EMPLOYEE table, select the SSN, first and last names, and performance rating of all employees who work at location 1. */
SELECT ssn, firstname, lastname, performance FROM gs_Employee WHERE locationID=1;

/*4.6.4.Select records for employees who have either "Emily" or "Frank" as their first name. Show the first and last name of these employees as well as their salary.*/
SELECT firstname, lastname, salary FROM gs_Employee
WHERE firstname = 'Emily' or firstname='Frank';

/*4.6.5.Select employees with the first name of Holly and received a "Good" performance rating, but in the same query select all employees who received an "Average" performance rating. Display SSN and first and last names in the results. */
SELECT ssn, firstname, lastname FROM gs_Employee
 WHERE (performance='Good' AND firstname='Holly')
       OR performance='Average';

/*4.6.6.Create a query that shows only the last and first name, location city, and position title of employees who earn less than $50,000.*/
SELECT lastname, firstname, gs_Location.locationcity, gs_Position.positiontitle 
FROM gs_Employee
INNER JOIN gs_Location ON gs_Employee.locationID = gs_Location.locationID
INNER JOIN gs_Position ON gs_Employee.positionID = gs_Position.positionID
/* INNER JOIN [table2] ON [table1].[primarykey] = [table2].[foreignkey] */
WHERE salary<50000;

/*4.6.7.Select all of the employees who received either an "Average" or "Poor" performance rating and work in Chicago. Show first name, last name, performance, and locationcity. */
SELECT firstname, lastname, performance, gs_Location.locationcity
FROM gs_Employee
INNER JOIN gs_Location ON gs_Employee.locationID = gs_Location.locationID
WHERE performance IN ('poor','average') 
     AND locationcity = 'chicago' ;

/*4.6.8.Show all of the employees who are managers (including regional managers) and have received a performance rating (field is not empty). Show the last name, salary, performance rating, location, and position title. */
SELECT lastname, salary, performance, gs_Location.locationcity, gs_Position.positiontitle
FROM gs_Employee
INNER JOIN gs_Location ON gs_Location.locationID = gs_Employee.locationID
INNER JOIN gs_Position ON gs_Position.positionID=gs_Employee.positionID
WHERE positiontitle LIKE '%manager' 
      AND performance != 'NULL'

/*4.6.9.Show the last name, salary, position title, and location city of all the Managers (not regional managers) who earn more than $50,000 and work in Chicago or Miami.*/
SELECT lastname,salary, gs_Position.positiontitle, gs_Location.locationcity
FROM gs_Employee
INNER JOIN gs_Position ON gs_Employee.positionID = gs_Position.positionID
INNER JOIN gs_Location ON gs_Employee.locationID = gs_Location.locationID
WHERE positiontitle LIKE'%manager'
    AND positiontitle != 'Regional Manager'
    AND salary>50000
    AND locationcity IN ('chicago', 'miami');
