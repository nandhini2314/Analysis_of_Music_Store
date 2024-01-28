Q1 - senior most employee based on jobtitle
select * from employee
order by levels desc
limit 1;

Q2 - which countries have most invoices
select count(*) , billing_country 
from invoice
group by billing_country
order by count(*) desc

Q4- which city has best customers
select Sum(total) as a,billing_city from invoice
group by billing_city
order by a desc
limit 1

Q5 best customer
select customer.customer_id,customer.first_name, customer.last_name, sum(invoice.total) as b 
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id 
order by b desc
limit 1
