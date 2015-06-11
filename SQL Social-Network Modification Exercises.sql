/*1. It's time for the seniors to graduate. Remove all 12th graders from Highschooler.*/
delete from Highschooler
where grade=12

/*2. If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. */
delete from Likes
where id2 in (select id2 from Friend where Likes.id1 = id1) /*friends + likes*/
and id2 not in (select l.id1 from Likes l where Likes.id1 = l.id2); /*checking reverse likes*/

/*3. For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.) */
insert into friend
select f1.id1, f2.id2
from friend f1 join friend f2 on f1.id2 = f2.id1 /*creating the table with A->B->C*/
where f1.id1 <> f2.id2 /*no friends with oneself*/
except select * from friend /*remove existing friends (no double insert)*/
