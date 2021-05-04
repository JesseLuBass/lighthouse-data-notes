/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE
SELECT name, sql FROM sqlite_schema
WHERE type='table'
ORDER BY name;




--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/
SELECT movie_id from movie_distributors  join distributors USING (distributor_id)
where distributors.name = 'Universal Pictures';


/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/
select name from distributors join movie_distributors md on distributors."index" = md."index"
join movies m on md.movie_id = m.movie_id
where year = 2006;


/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/
select t1.title,t2.title from movies t1 left outer join movies t2
where t1.year = t2.year and t1.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/
select distinct title from movies join directors d on movies.movie_id = d.movie_id
join roles r on d.movie_id = r.movie_id
join people on r.person_id = people.person_id
where d.person_id = r.person_id;

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/




/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/




/* TASK VII
Find the most popular movie genres.
*/


/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/



/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/




/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/




/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
