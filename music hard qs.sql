Q1- how much spent by each customer -quantity * unit
with best_selling_artists as(
select artist.artist_id as artist_id, artist.name as artist_name,sum(invoice_line.unit_price*invoice_line.quantity)
from invoice_line
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join  artist on artist.artist_id = album.artist_id
group by 1 order by 3 desc
limit 1)
select c.customer_id,c.first_name,c.last_name,bsa.artist_name,sum(il.unit_price*il.quantity) as amt_spent
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artists bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;

Q2-most popular genre for each country
with popular_genre as
(
select count(invoice_line.quantity) as purchases, customer.customer_id,genre.name,genre.genre_id,
row number() over(partition by customer.country order by count(invoice_line.quantity)desc)as Rowno
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by 2,3,4,
order by 2 asc , 1 desc)
select * from popular_genre where Rowno<=1

Q3 cutomer that has spent most on music in each country
with customer_with_country as
(
select customer.customer_id,first_name,last_name,billing_country,sum(total) as total_spent,
row_number() over (partition by billing_country order by sum(total)desc)
as rowno
from invoice join customer on customer.customer_id = invoice.customer_id
group by 1,2,3
order by 4 asc, 5 desc)
select * from customer_with_country where rowno <=1