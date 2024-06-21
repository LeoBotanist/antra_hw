-- 1.
select distinct c.city
from customers c join employees e
on c.city = e.city

-- 2.
-- a.subquery
select distinct city 
from customers 
where city not in (
    select city
    from employees
)

-- b.no subquery
select distinct c.city
from customers c
left join employees e 
on c.city = e.city 
where e.city is null

-- 3.
select p.productName, sum(od.quantity) as quantities
from products p 
join [order details] od 
on p.productId = od.productId
group by p.productId, p.productName

-- 4.
select c.city, count(od.quantity) as total_quantity
from customers c 
left join orders o 
on o.customerid = c.customerId 
join [order details] od 
on o.orderid = od.orderid
group by c.city 


-- 5.
-- a


-- 6.
select c.city 
from customers c 
join orders o 
on o.customerId = c.customerId
join [order details] od 
on o.orderId = od.orderId 
group by c.city
having count(distinct od.productId) > 1

-- 7.
select distinct c.contactName
from customers c
join orders o 
on c.customerId = o.customerid and c.city != o.shipcity

-- 8.
select top 5 p.productname, [avg price].avg_price, [city rank].city 
from products p 
join (
    select productId, sum(quantity * unitprice) / sum(quantity) avg_price, sum(quantity) as total_quant
    from [order details]
    group by productId
) [avg price] on [avg price].productId = p.productId
join (
    select od.productId, c.city, rank() over (partition by od.productId order by sum(od.quantity) desc) as cc
    from [order details] od 
    join orders o on o.orderid = od.orderId
    join customers c on o.customerId = c.customerId
    group by od.productID, c.city
) [city rank] on p.productId = [city rank].productid
where [city rank].cc = 1
order by [avg price].total_quant desc

-- 9.
-- a.
select distinct e.city 
from employees e 
where e.city not in (
    select c.city 
    from customers c 
    join orders o on o.customerid = c.customerid
)

-- b.
select distinct e.city 
from employees e 
left join customers c on c.city = e.city 
left join orders o on o.customerid = c.customerid
where c.city is null

-- 10.
select ng1.city 
from
(
    select city 
    from employees
    where employeeId = (
        select top 1 employeeId
        from orders 
        group by employeeId
        order by count(*) desc
    )
) ng1
join 
(
    select top 1 su.city
    from suppliers su
    join products p on su.supplierId = p.supplierId
    join [order details] od on od.productid = p.productid 
    join orders o on od.orderID = o.orderID
    group by su.city
    order by sum(od.quantity) desc

) ng2
on ng1.city = ng2.city


-- 11.
-- union it with itself