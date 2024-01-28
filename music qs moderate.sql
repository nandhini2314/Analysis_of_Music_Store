Q1- return email fname lname genre of rockmusic listeners-alphabetically

select distinct email,first_name,last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
select track_id from track
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
)
order by first_name

Q2-artist who has written most rock music artist name and total track count of top 10 rock bands
select artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.album_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
group by artist.name
order by number_of_songs desc
limit 10

Q3- track names length longer than avg song length. return name and length order by song length
Select name, milliseconds
from track
where milliseconds >(
select avg(milliseconds) as avg_length
from track)
order by milliseconds desc