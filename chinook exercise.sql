-- List all customers. Show only the CustomerId, FirstName and LastName columns

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
FROM
    Customer c

-- List customers in the United Kingdom  

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    , c.Country
FROM
    Customer c
WHERE c.Country = 'United Kingdom'

-- List customers whose first names begins with an A.
-- Hint: use LIKE and the % wildcard

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    , c.Country
FROM
    Customer c


-- List Customers with an apple email address

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    , c.Country
    , c.Email
FROM
    Customer c


SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
    Invoice i
GROUP BY i.CustomerId
order by InvoiceTotal DESC

-- Which are the corporate customers i.e. those with a value, not NULL, in the Company column?

SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    , c.Country
    , c.Email
    , c.Company
FROM
    Customer c

-- How many customers are in each country.  Order by the most popular country first.

-- When was the oldest employee born?  Who is that?

-- List the 10 latest invoices. Include the InvoiceId, InvoiceDate and Total
-- Then  also include the customer full name (first and last name together)

-- List the customers who have spent more than £45

-- implement as a join 
SELECT
    c.FirstName
        ,c.LastName
        ,Sum(i.Total) AS InvTotal
FROM
    Invoice i
    JOIN Customer c ON i.CustomerId=c.CustomerId
GROUP BY c.FirstName
        ,c.LastName
HAVING Sum(i.Total)>45

-- implement as a subquery using in
select * FROM Customer where 
CustomerId IN 
(SELECT
    i.CustomerId
    --,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45) 

-- implement as a table subquery

SELECT
    c.FirstName
    ,c.LastName
    ,topCust.InvoiceTotal
FROM
    Customer c JOIN  
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45) topCust
ON c.CustomerId = topCust.CustomerId

-- implement as a CTE
;
with cte AS
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45 )
select 
    c.FirstName
    ,c.LastName
    ,cte.InvoiceTotal
from  Customer c JOIN cte on c.CustomerId = cte.CustomerId

--implement as temporary tables

SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
INTO #topCust
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45

select * from #topCust JOIN Customer c ON #topCust.CustomerId = C.CustomerId



-- List the City, CustomerId and LastName of all customers in Paris and London, 
-- and the Total of their invoices
