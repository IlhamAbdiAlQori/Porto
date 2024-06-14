

WITH bestEmployee AS (
select
to_char(cast(o."orderDate" AS date), 'YYYY-MM') as "salesMonthYear",
to_char(cast(o."orderDate" AS date), 'Mon-YYYY') as "salesMonthYearName",
ROW_NUMBER() OVER(PARTITION BY to_char(cast(o."orderDate" AS date), 'YYYY-MM')
	ORDER BY sum((od."unitPrice" - (od."unitPrice" * od."discount"))* od."quantity") DESC) as "rank",
e."title",
e."employeeID",
concat(e."titleOfCourtesy", ' ', e."firstName", ' ', "lastName") as "fullName",
count(od."orderID") as "totalSold",
sum((od."unitPrice" - (od."unitPrice" * od."discount"))* od."quantity") as "grossRevenue"
from orders o
inner join order_details od on od."orderID" = o."orderID"
inner join products p on p."productID" = od."productID"
inner join employees e on e."employeeID" = o."employeeID"
group by o."orderDate" , to_char(cast(o."orderDate" AS date), 'YYYY-MM'), to_char(cast(o."orderDate" AS date), 'Mon-YYYY'), e."title", e."employeeID", "fullName"
)
SELECT * FROM bestEmployee where "rank" = 1