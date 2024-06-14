
  
    

  create  table "project2_dbt"."public"."datamart_monthly_supplier_category_sold__dbt_tmp"
  
  
    as
  
  (
    

select
to_char(cast(o."orderDate" AS date), 'YYYY-MM') as "salesMonthYear",
to_char(cast(o."orderDate" AS date), 'Mon-YYYY') as "salesMonthYearName",
ROW_NUMBER() OVER(PARTITION BY to_char(cast(o."orderDate" AS date), 'YYYY-MM') 
	ORDER BY count(od."orderID") DESC) as "rank",
c."categoryID",
c."categoryName",
sum(od."quantity") as "totalSold",
sum((od."unitPrice" - (od."unitPrice" * od."discount"))* od."quantity") as "grossRevenue"
from orders o
inner join order_details od on od."orderID" = o."orderID"
inner join products p on p."productID" = od."productID"
inner join categories c on c."categoryID" = p."categoryID"
group by "salesMonthYear", "salesMonthYearName", c."categoryID", c."categoryName"
  );
  