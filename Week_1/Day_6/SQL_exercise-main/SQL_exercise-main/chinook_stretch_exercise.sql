/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/
SELECT tbl_name, sql FROM sqlite_schema
WHERE type='table'
ORDER BY name;


--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers? And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
*/
select sum(invoices.InvoiceId) * 0.99 from invoices where BillingCountry = 'Germany';

/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/
select playlists.Name, sum(tracks.Bytes),count(tracks.TrackId) * 0.99 as sumprice 
from tracks join playlist_track
on tracks.TrackId = playlist_track.TrackId
join playlists on playlist_track.PlaylistId = playlists.PlaylistId
where playlists.Name = 'Grunge';

/* TASK III
List the names and the countries of those customers who are supported by an employee who was younger than 35 when hired. 
*/
