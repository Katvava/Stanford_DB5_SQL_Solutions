/* 1. Find the names of all students who are friends with someone named Gabriel. */
select h1.name
from Highschooler h1, Friend f
where (f.id1 = 1689 or f.id1 = 1911) and f.id2 = h1.id;

/* 2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. */
select h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where l.id1 = h1.id and l.id2 = h2.id and h1.grade > h2.grade+1;

