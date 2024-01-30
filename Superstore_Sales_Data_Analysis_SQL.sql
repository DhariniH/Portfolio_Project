SELECT * FROM Orders

--Which are the products making highest profit?
SELECT Top 10 [Product_Name], SUM(Profit) As Total_Profit
FROM Orders
GROUP BY [Product_Name]
Order BY Total_Profit Desc

--Which are the products making the lowest sales?
SELECT Top 10 [Product_Name], SUM(Sales) As Total_Sales
FROM Orders
GROUP BY [Product_Name]
Order BY Total_Sales Asc

--Which sub-category has made the highest profit in the sales?
SELECT Top 10 [Sub-Category], SUM(Profit) As Total_Profit
FROM Orders
GROUP BY [Sub-Category]
Order BY Total_Profit Desc

--Which is the most preferred Ship_Mode by the customers?
SELECT [Ship_Mode], COUNT([Ship_Mode]) as ShipModeCount
FROM Orders
GROUP BY [Ship_Mode]
ORDER BY ShipModeCount Desc

--List of Products with state and their profit margin.
SELECT State, Category, Product_Name, ((SUM(Profit)/SUM(Sales))*100)  As Profit_Margin
FROM Orders
GROUP BY State, Category, Product_Name
HAVING SUM((Profit)*100)!= 0
ORDER BY Profit_Margin DESC

--List of Shipments happened on 'Fridays'.
SELECT [Order_Date],[Category], [Sub-Category], [Product_Name]
FROM Orders 
WHERE DATENAME(dw,[Order_Date]) = 'Friday'

--List the Products with quantity ordered more than 10.
SELECT [Order_ID],[Product_Name], SUM(Quantity) as Total_Quantity
FROM Orders
GROUP BY [Order_ID], [Product_Name]
HAVING SUM(Quantity) > 10
ORDER BY Total_Quantity Desc

--Get the bottom 10 Sales in the year 2014.
SELECT TOP 10 [Order_Date], [Order_ID],[Category], [Product_Name], SUM(Sales) As Total_Sales
FROM Orders
WHERE YEAR([Order_Date]) = 2014
GROUP BY [Order_Date], [Order_ID], [Category], [Product_Name]
ORDER BY Total_Sales Asc

--List the Products which has made the highest sales in the year 2016 with 'Standard' ship mode
SELECT TOP 10 [Category], [Product_Name], [Ship_Mode], SUM(Sales) As Total_Sales
FROM Orders
WHERE DATENAME(YY, [Order_Date]) = 2016 and [Ship_Mode] ='Standard Class'
GROUP BY [Category], [Product_Name], [Ship_Mode]
ORDER BY [Category] 

--Categorize the data based on Sales.
SELECT top 10 Category, [Sub-Category], Sales,
	CASE	
		WHEN Sales <= 100 THEN 'Under 100'
		WHEN Sales >100 and Sales <1000  THEN 'Under 1K'
		WHEN Sales >=1000 and Sales <5000  THEN 'Under 5k'
		WHEN Sales >=5000 and Sales <10000  THEN 'Under 10k'
		ELSE '20k or More'
	END as 'Sales Category'	
FROM Orders 
ORDER BY Category

--Fetch the top ten customers based on orders.
SELECT top 10 Cd.Customer_Name, COUNT(Od.Order_ID) as OrderCount
FROM Orders Od
Join Customer_details cd on  Od.Order_ID = Cd.Order_ID 
GROUP BY Cd.Customer_Name
ORDER BY OrderCount DESC

--Get the list of products returned by customers.
SELECT Top 10 Od.Product_Name, COUNT(R.Order_ID) As ReturnCount
FROM Returns R
JOIN Orders Od ON Od.Order_ID = R.[Order_ID]
JOIN Customer_details Cd ON Cd.Order_ID = R.Order_ID
WHERE Returned = 'YES' 
GROUP BY Od.Product_Name
ORDER BY ReturnCount Desc
