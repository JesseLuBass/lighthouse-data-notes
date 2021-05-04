/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE*/

select * from products 





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/
select productname, unitsinstock from products
/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/
select productname, unitprice
from products
where unitprice = (
    select max(unitprice)
    from products)

/* TASK III
Q3. Write a query to count current and discontinued products.
*/
select count(productname) from products where discontinued = 1

select count(productname) from products where discontinued = 0

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/
select productname,categoryname from products join categories c on products.categoryid = c.categoryid

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from USA region. (26 rows)
*/
select productname, unitprice,region from products join suppliers s on products.supplierid = s.supplierid where
s.region not like 'USA'


/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/
select sum(quantity) from order_details

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/
select orderid, sum(quantity) from order_details group by orderid

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/
select lastname, firstname from employees