-- 1.
select count(distinct productid) as numberOfproducts
from production.Product

-- 2.
select count(distinct productid) as numberOfproducts
from production.product
where ProductSubcategoryID IS NOT NULL

-- 3.
select ProductSubcategoryID, count(productid) as CountedProducts
from production.product
group by ProductSubcategoryID

-- 4.
select count(productid)
from production.product
where ProductSubcategoryID IS NULL

-- 5.
select sum(quantity)
from production.productInventory

-- 6.
select productId as ProductID, sum(quantity) as TheSUM
from production.productInventory
where locationID = 40
group by productId
having sum(quantity) < 100

-- 7.
select Shelf, productId as ProductID, sum(quantity) as TheSUM
from production.productInventory
where locationID = 40
group by Shelf, productId
having sum(quantity) < 100

-- 8.
select avg(quantity) as TheAvg
from production.productInventory
where LocationID = 10

-- 9.
select ProductID, Shelf, avg(quantity) as TheAvg
from production.productInventory
group by ProductID, Shelf

-- 10.
select ProductID, Shelf, avg(quantity) as TheAvg
from production.productInventory
where Shelf != 'N/A'
group by ProductID, Shelf

-- 11.
select Color, Class, COUNT(*) as TheCount, Avg(ListPrice) as AvgPrice
from production.product
where Color IS NOT Null and Class is not NULL
group by Color, Class

-- 12.
select cr.name as Country, sp.Name as Province
from person.CountryRegion cr
JOIN person.StateProvince sp
on cr.countryregioncode = sp.countryregioncode

-- 13.
select cr.name as Country, sp.Name as Province
from person.CountryRegion cr
JOIN person.StateProvince sp
on cr.countryregioncode = sp.countryregioncode
where cr.name in ('Germany', 'Canada')

-- 14.
select distinct od.productId
from [order details] od
join orders o
on od.orderId = o.orderId
where o.orderDate >= DATEADD(YEAR, -25, GETDATE())

-- 15.
select top 5 ShipPostalCode
from orders
group by ShipPostalCode
order by Count(ShipPostalCode) desc

-- 16.
select top 5 ShipPostalCode
from orders
where orderDate >= DATEADD(YEAR, -25, GETDATE())
group by ShipPostalCode
order by Count(ShipPostalCode) desc

-- 17.
select City, count(customerID) as numOfCustomers
from customers
group by city


-- 18.
select city, count(customerID) as numOfCustomers
from customers
group by city
having count(customerID) > 2

-- 19.
select c.companyName, o.orderDate
from customers c 
JOIN orders o
on o.customerId = c.customerID
where o.orderDate > '1998-01-01'

-- 20.
select c.companyName, max(o.orderDate) as newestOrderDate
from customers c 
join orders o 
on c.customerID = o.customerID
group by c.customerID, c.companyName

-- 21.
select c.companyName, sum(od.quantity) as numOfProducts
from orders o 
join [order details] od 
on o.orderID = od.orderID
join customers c 
on o.customerID = c.customerID
group by c.companyName, c.customerID

-- 22.
select o.customerID, sum(od.quantity) as numOfProducts
from orders o 
join [order details] od 
on o.orderID = od.orderID 
group by o.customerID 
having sum(od.quantity) > 100

-- 23.
select su.companyName, sh.companyName
from suppliers su 
CROSS JOIN shippers sh 

-- 24.
select o.orderDate, p.productName
from orders o
join [order details] od on o.orderID = od.orderID
join products p on od.productID = p.productID
order by o.orderDate

-- 25.
select e1.firstName + ' ' + e1.lastName, e2.firstName + ' ' + e2.lastname
from employees e1
join employees e2
on e1.employeeID < e2.employeeID and e1.title = e2.title

-- 26.
select e1.firstName + ' ' + e1.lastName
from employees e1
where e1.employeeID in (
    select e2.reportsTo
    from employees e2
    group by reportsTo
    having count(reportsTo) > 2
)

-- 27.
select *
from(
select City, companyName as Name, ContactName as [Contact name], 'Customer' as Type
from customers
union ALL
select City, companyName as Name, Contactname as [Contact name], 'Supplier' as Type
from suppliers
) ng
order by City