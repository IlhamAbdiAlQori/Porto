
  
    

  create  table "project2_dbt"."public"."datamart_monthly_supplier_gross_revenue__dbt_tmp"
  
  
    as
  
  (
    

select
to_char(cast(o."orderDate" AS date), 'YYYY-MM') as "salesMonthYear",
to_char(cast(o."orderDate" AS date), 'Mon-YYYY') as "salesMonthYearName",
ROW_NUMBER() OVER(PARTITION BY to_char(cast(o."orderDate" AS date), 'YYYY-MM') 
	ORDER BY sum((od."unitPrice" - (od."unitPrice" * od."discount"))* od."quantity") DESC) as "rank",
s."supplierID",
s."companyName",
sum((od."unitPrice" - (od."unitPrice" * od."discount"))* od."quantity") as "grossRevenue"
from orders o
inner join order_details od on od."orderID" = o."orderID"
inner join products p on p."productID" = od."productID" 
inner join suppliers s on s."supplierID"  = p."supplierID"
group by "salesMonthYear", "salesMonthYearName", s."supplierID", s."companyName"
  );
  