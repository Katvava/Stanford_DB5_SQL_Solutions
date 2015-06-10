/* 1. Find the names of all students who are friends with someone named Gabriel. */
select h1.name
from Highschooler h1, Friend f
where (f.id1 = 1689 or f.id1 = 1911) and f.id2 = h1.id;

/* 2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. */
select h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where l.id1 = h1.id and l.id2 = h2.id and h1.grade > h2.grade+1;

/* 3. Find the names of all students who are friends with someone named Gabriel. */

/* 4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.  */
select distinct h.name, h.grade
from Highschooler h, Likes
where h.id not in (select id1 from Likes) and h.id not in (select id2 from Likes)
order by h.grade;

/* 5. For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.  */
select distinct h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where h1.id = l.id1 and h2.id = l.id2 and h2.id not in (select id1 from Likes)
order by h1.grade;

