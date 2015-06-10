/* 1. Find the titles of all movies directed by Steven Spielberg */
select title
from Movie
where director = 'Steven Spielberg';

/* 2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.  */
select distinct year
from Movie
inner join Rating
on Movie.mID = Rating.mID
where stars >= 4
order by Movie.year;

/* 3. Find the titles of all movies that have no ratings.  */ 
select distinct title
from Movie
where Movie.title not in (select distinct title
from Movie join Rating
where Movie.mID = Rating.mID); 

/* 4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.  */ 
select name
from Reviewer
inner join Rating
on Reviewer.rID = Rating.rID
where Rating.ratingDate is null;

/* 5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.  */ 
select Reviewer.name, Movie.title, Rating.stars, Rating.ratingDate
from Movie, Reviewer, Rating
where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
order by Reviewer.name, Movie.title, Rating.stars;

/* 6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.  */
select distinct Reviewer.name, Movie.title
from Rating 
join Movie on (Rating.mID = Movie.mID) 
join Reviewer on (Rating.rID = Reviewer.rID)
join Rating rt on (Rating.mID = rt.mID and Rating.rID = rt.rID)
where Rating.ratingDate > rt.ratingDate and Rating.stars > rt.stars;

/* 7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.  */
select m.title, max(rt.stars)
from Movie m, Rating rt
where m.mID = rt.mID
group by m.title
order by m.title;

/* 8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.  */
select m.title, max(rt.stars)-min(rt.stars) as diff
from Movie m, Rating rt
where m.mID = rt.mID
group by m.title
order by diff desc, m.title;

/* 9. Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)  */
select max(ag1)-min(ag1)
from 
(select avg(art1) ag1
from (select avg(rt.stars) art1
from Movie m, Rating rt
where m.mID = rt.mID and m.year < 1980
group by rt.mID)
union
select avg(art2) ag1
from (select avg(rt.stars) art2
from Movie m, Rating rt
where m.mID = rt.mID and m.year > 1980
group by rt.mID));
