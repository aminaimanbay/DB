--1a
create function inc(val integer) returns integer
    language plpgsql
as
$$
BEGIN RETURN val + 1; END;
$$;

--1b
create function sum(val1 integer,val2 integer) returns bool
    language plpgsql
as
$$
BEGIN RETURN val1 + val2; END;
$$;

--1c
create function check_div(num numeric) returns BOOLEAN
    language plpgsql
as
$$
BEGIN
    IF ( num%2=0)
        then return true;
    else
        return false;
     END IF;

END;
$$;

--1d
create function check_pass(pass text) returns BOOLEAN
    language plpgsql
as
$$
BEGIN
    IF (length(pass) > 8)
        then return true;
    else
        return false;
     END IF;

END;
$$;

--1e
create or replace function splitting(text varchar(30)) returns record
    language plpgsql
as
$$
declare text1 record;
begin
    select split_part(text, ',', 1) ,
           split_part(text, ',', 2)
           into text1;
    return text1;
end;
$$;

--2a
create trigger tmstmp
    before update
    on table1
    for each row
    set new.modified_timestamp=CURRENT_TIMESTAMP();
    end;

--2b
create or replace function age_calculate()
    returns trigger
    language plpgsql
    as
$$
    begin
        new.age = extract(year from current_date) - new.year_of_birth;
        return new;
    end;
$$;
create trigger age1 before insert or update on person
    for each row execute procedure age_calculate();


--2c
create trigger cost after insert on table1
    for each row
    update price
    set price=price*1.12;


-- 2d
create trigger back
    after delete
    on table1
    for each row
    execute procedure reset();


--2e
create trigger func
    after insert
    on table1
    for each row
    execute function splitting;

create trigger paswalid
    after insert
    on table1
    execute function check_pass();


--3
-- The function must return a value but in Stored Procedure it is optional.
-- Even a procedure can return zero or n values.

-- Functions can have only input parameters for it whereas
-- Procedures can have input or output parameters.

-- Functions can be called from Procedure whereas
-- Procedures cannot be called from a Function.


--4a
Create table employee(
    id int primary key,
    name varchar(40),
    date_of_birth date,
    age int,
    salary int,
    workexperience int,
    discount int);

CREATE or replace procedure salary()
language plpgsql
    as
$$
    Begin
        update employee
        set salary = ( workexperience/2)*0.1*salary+salary,
            discount = ( workexperience/2)*0.1*employee.discount + employee.discount,
            discount = ( workexperience/5)*0.01 * employee.discount + employee.discount;
        commit;
    end;
    $$;


-- 4b
create or replace procedure sal()
language plpgsql
as
    $$
        BEGIN
            update employee
            set salary = salary*1.15
            where age > 40;
            update employee
            set salary = salary*1.15
            where workexperience>8;
            update employee
            set discount = 20 where  workexperience > 8;
            commit;
        end;
    $$;


-- 5
create table members(
    memid integer,
    surname varchar(200),
    firstname varchar(200),
    address varchar(300),
    zipcode integer,
    telephone varchar(20),
    recommendedby integer,
    joindate timestamp
);
create table bookings(
    facid integer,
    memid integer,
    starttime timestamp,
    slots integer
);
create table facilities(
    facid integer,
    name varchar(100),
    membercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric
);
with recursive recom(recommender, member) as (
	select recommendedby, memid
		from members
	union all
	select members.recommendedby, recom.member
		from recom
		inner join members
			on members.memid = recom.recommender
)
select recom.member member, recom.recommender, members.firstname, members.surname
	from recom
	inner join members
		on recom.recommender = members.memid
	where recom.member = 22 or recom.member = 12
order by recom.member asc, recom.recommender desc



