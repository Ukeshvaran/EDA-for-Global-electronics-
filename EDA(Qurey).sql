select * from customers
select * from product
select * from sales
select * from store
select * from exchange

--1. Query to count customers

-- To count total customers: 
select count("Gender") from customers;

-- To count Male customers:
select count("Gender") from customers
where "Gender"='Male';

-- To count Female customers:
select count("Gender") from customers
where "Gender"='Female';


--2. Total product sold
select sum("Quantity") from sales

--3.Query to count continent,country and city 

-- To count continent
select count(distinct("Continent")) from customers

-- To count country
select count(distinct("Country")) from customers

-- To count state 
select count(distinct("State")) from customers

--4.Total Revenue value
select sum("Unit Price USD" * sd."Quantity") as Total_Revenue
from product as pd
join sales sd on pd."ProductKey" = sd."ProductKey";

--5.Total order value
select sum("Unit Cost USD" * sd."Quantity") as Total_order_value
from product as pd
join sales sd on pd."ProductKey"=sd."ProductKey"

--6.Count of customers by country-wise
select st."Country", count(distinct s."CustomerKey") as customer_count
from sales as s
join store as st on s."StoreKey" = st."StoreKey"
group by st."Country";

--7.Brand wise revenue
select "Brand",Round(sum(p."Unit Price USD" * s."Quantity") :: numeric,2) as Revenue
from product as p 
join sales as s on p."ProductKey"=s."ProductKey"
group by "Brand";

--8.Product wise revenue
select p."Product Name",Round(sum(p."Unit Cost USD"*s."Quantity")::numeric,2) as Revenue
from product as p
join sales as s on p."ProductKey" = s."ProductKey"
group by p."Product Name"
order by Revenue asc;

--9.Country wise sales
select st."Country" ,sum(p."Unit Price USD" * s."Quantity") as Total_sales
from product as p
join sales as s on p."ProductKey" = s."ProductKey"
join store st on s."StoreKey" = st."StoreKey"
group by st."Country"
;

--10.Order frequency by brand,product

-- Order frequency by brand
select p."Brand",count(distinct(s."Order Number")) as frequency
from product as p
join sales as s on p."ProductKey"=s."ProductKey"
group by "Brand";

--Order frequency by Product
select p."Product Name",count(distinct(s."Order Number")) as frequency
from product as p
join sales as s on p."ProductKey"=s."ProductKey"
group by "Product Name";

--11.Average store size
select round(avg("Square Meters"),2) as Avg_store_size from store;

--12.Product sold by category
select p."Category",sum(s."Quantity") as Quantity
from product as p
join sales as s on p."ProductKey"=s."ProductKey"
group by "Category";

--13.Total Number of stores
select count("Country") as Total_count from store;


--14.Number of stores by country
select distinct("Country"),count("Country") as Count from store
group by "Country"
order by Count desc ;
