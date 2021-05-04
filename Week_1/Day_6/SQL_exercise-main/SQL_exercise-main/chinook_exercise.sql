/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE
SELECT tbl_name, sql FROM sqlite_schema
WHERE type='table'
ORDER BY name;





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
select Name, Title from artists left join albums on artists.ArtistId = albums.ArtistId 
where Title is NULL;

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
select artists.Name, count(tracks.Name) from tracks 
join albums on tracks.AlbumId = albums.AlbumId 
join artists on albums.ArtistId = artists.ArtistId
join genres on genres.GenreId = tracks.GenreId
where genres.GenreId = 7
group by artists.Name;
/* TASK III
Which video track has the longest length?
*/
select tracks.Name, MAX(tracks.Milliseconds) from tracks join media_types
on tracks.MediaTypeId = media_types.MediaTypeId where media_types.MediaTypeId = 3;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
SELECT customers.FirstName, customers.LastName, customers.City, employees.City from customers JOIN employees 
on customers.City = employees.City;


/* TASK V
Find the managers of employees supporting Brazilian customers.
*/
select EmployeeId from employees where EmployeeId = (select SupportRepId from customers where Country = 'Brazil');
select FirstName,LastName from employees where EmployeeId = 2;
/* TASK VI
Which playlists have no Latin tracks?
*/
select playlists.Name from playlists 
join playlist_track on playlist_track.PlaylistId = playlists.PlaylistId
join tracks on playlist_track.TrackId = tracks.TrackId
join genres on tracks.Genreid = genres. Genreid
where genres.Name is not 'Latin' group by playlists.Name  




;
