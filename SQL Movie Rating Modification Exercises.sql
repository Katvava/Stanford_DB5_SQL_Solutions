/* 1. Add the reviewer Roger Ebert to your database, with an rID of 209.*/
insert into Reviewer (rID, name)
values ('209','Roger Ebert'); 

/* 2. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.*/
insert into Rating (rID, mID, stars) 
     select '207' as rID, '101' as mID, '5' as stars 
     union select '207', '102', '5'
     union select '207', '103', '5' 
     union select '207', '104', '5' 
     union select '207', '105', '5' 
     union select '207', '106', '5' 
     union select '207', '107', '5' 
     union select '207', '108', '5' 

/* 3. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.) */
update Movie
set year=year+25
where mID in (
  select mID 
  from (select avg(stars) as ag, mID 
      from Rating
      where mID=rating.mID
      group by mID
      having ag >=4))

/* 4. Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. */
delete from Rating
where mID in (select mID 
              from Movie
              where year < 1970 or year > 2000) and stars < 4
