/* 1. Find the names of all students who are friends with someone named Gabriel. */
select h1.name
from Highschooler h1, Friend f
where (f.id1 = 1689 or f.id1 = 1911) and f.id2 = h1.id;

/* 2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. */
select h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where l.id1 = h1.id and l.id2 = h2.id and h1.grade > h2.grade+1;

/* 3. Find the names of all students who are friends with someone named Gabriel. */
select h1.name, h1.grade, h2.name, h2.grade 
from Highschooler h1, Highschooler h2, 
/* Table with friendships other than one sided friendships (so mutual) */
(select id1, id2 from Likes except select id1, id2 from 
    (select id1, id2 from Likes except select id2, id1 from Likes)) as mutual /* To select all one-sided friendships */
    where h1.id = mutual.id1 and h2.id = mutual.id2 and h1.name < h2.name

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

/* 6. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. */
select h1.name, h1.grade 
from highschooler h1
where not exists
    (select * from highschooler h2 where h2.grade != h1.grade and       /*Grades not same*/
        exists (select * from friend f 
            where (f.id1 = h1.id or f.id2 = h1.id) and (f.id1 = h2.id or f.id2 = h2.id)))
order by grade, name

/* 7. For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. */
select h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from highschooler h1, highschooler h2, highschooler h3, likes l, friend f1, friend f2
where (h1.id=l.id1 and h2.id=l.id2) and /*A likes B*/
    h1.id not in (select id1 from friend where id2 = h2.id) and /*checking friendship for A & B*/
    h1.id = f1.id1 and f1.id2 = h3.id and /*A is friends with C*/
    h2.id = f2.id1 and h3.id = f2.id2; /*B is friends with C*/

/* 8. Find the difference between the number of students in the school and the number of different first names. */
select (select count(name) from highschooler) - 
(select count(name) from (select distinct name from highschooler))

/* 9. Find the name and grade of all students who are liked by more than one other student. */
select h.name, h.grade
from highschooler h
where id in (select id2 /* Checking for all liked people*/
from likes
group by id2
having count(id1) > 1)  /* Only pulling them in if they have more than 1 liker*/
