--                                      1



--1.a
select * from course where(credits>3);

--1.b
select * from classroom where(building='Watson' or building='Packard' );

--1.c
select * from course where (dept_name= 'Comp. Sci.');

--1.d
select course.title from course full outer join section on course.course_id = section.course_id where (section.semester='Fall');

--1.e
select student.name from student where tot_cred between 45 and 90;

--1.f
select * from students where (name like '%e' or name like '%y' or name like '%u' or name like '%i' or name like '%o' or name like '%a');

--1.g
select course.title from course full outer join prereq on course.course_id = prereq.course_id where (prereq.prereq_id= 'CS-101');



--                                      2

--2.a
select distinct dept_name, avg(salary) from instructor order by avg(salary) asc ;

--2.b
select max(count(building)) from section;

--2.c
select min(count(dept_name)) from course;

--2.d
select distinct student.id, student.name from(( takes full outer join student on takes.ID=student.ID ) full outer join course on course.course_ID=takes.course_ID ) where ((count(takes.course_id)>3) and count(course.dept_name='Comp. Sci.')>3);

--2.e
select distinct name from instructor where (dept_name='Biology' or dept_name='Philosophy' or dept_name='Music');

--2.f
select distinct instructor.name from instructor full outer join teaches on teaches.ID=instructor.ID where teaches.year = '2018' and instructor.ID not in (select distinct teaches.ID from teaches where year = '2017');



--                                      3

--3.a
select * from student full outer join takes on student.ID= takes.ID where dept_name = 'Comp. Sci.' and (grade = 'A' or grade = 'A-') order by student.name;

--3.b
select distinct instructor.name from ((takes full outer join advisor on takes.id=advisor.s_id) full outer join instructor on advisor.i_id= instructor.id) where not ((takes.grade = 'A' or takes.grade = 'A-' or takes.grade = 'B+' or takes.grade = 'B'));

--3.c
select distinct course.dept_name from takes full outer join course on takes.course_id=course.course_id where not (takes.grade = 'F' or takes.grade = 'C');

--3.d
select distinct instructor.name from instructor full outer join teaches on instructor.id = teaches.id where instructor.id in (select teaches.id from takes full outer join teaches on takes.course_id = teaches.course_id and takes.year = teaches.year and takes.semester = teaches.semester and not (takes.grade = 'A'));

--3.e
select distinct course.course_id, course.title from ((course full outer join section on section.course_id=course.course_id) full outer join time_slot on time_slot.time_slot_id = section.time_slot_id) where (time_slot.end_hr<13);