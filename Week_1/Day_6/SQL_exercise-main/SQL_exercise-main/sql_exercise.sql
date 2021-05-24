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



/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/
select t1.title,t2.title from movies t1 left outer join movies t2
where t1.year = t2.year and t1.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/
select title from movies join directors d on movies.movie_id = d.movie_id
join roles r on d.movie_id = r.movie_id
join people on r.person_id = people.person_id
where d.person_id = r.person_id
group by people.name;

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/
select aka_titles.title from aka_titles
left join movies on movies.movie_id = aka_titles.movie_id
where year = 2011;



/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

select title, people.name from movies join composers on movies.movie_id = composers.movie_id
join people on people.person_id = composers.person_id
where movies.year in (1976, 1977)


/* TASK VII
Find the most popular movie genres.
*/
select genres.label, count(movie_genres.movie_id) from genres
    join movie_genres on movie_genres.genre_id = genres.genre_id
group by genres.label order by count(movie_genres.movie_id) desc limit 1

/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/
select p.name, row_number()  over (order by movies.rating desc)
from movies join cinematographers c on movies.movie_id = c.movie_id
join people p on c.person_id = p.person_id limit 10;


/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

select distinct countries.name from countries join movie_countries mc on countries.country_id = mc.country_id
join movies on mc.movie_id = movies.movie_id
where movies.movie_id in
(select movie_id from movies where rating > 8.4);



/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/
select distinct title, year, rating, countries.name from countries join movie_countries mc on countries.country_id = mc.country_id
join movies on mc.movie_id = movies.movie_id
where movies.movie_id in
(select movie_id from movies where rating=9.2) group by title;



/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
SELECT
    p1.name as director_1,
    min(m1.year) as first_movie_1,
    max(m1.year) as last_movie_1,
    p2.name as director_2,
    min(m2.year) as first_movie_2,
    max(m2.year) as last_movie_2
FROM directors d1, directors d2, people p1, people p2, movies m1, movies m2
WHERE d1.person_id = p1.person_id
    AND d2.person_id = p2.person_id
    AND d1.movie_id = m1.movie_id
    AND d2.movie_id = m2.movie_id
    and (select person_id from directors
group by person_id having count(*) > 4)
GROUP BY d1.person_id, d2.person_id
HAVING max(m1.year) < min(m2.year)
    AND count(DISTINCT m1.movie_id) >= 5
    AND count(DISTINCT m2.movie_id) >= 5;