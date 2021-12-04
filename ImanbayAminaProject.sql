CREATE DATABASE AUTOMOBILE_COMPANY;
CREATE TABLE vehicle(
    vin BIGSERIAL NOT NULL PRIMARY KEY ,
    model_name VARCHAR(50) NOT NULL
);
CREATE TABLE option(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    color VARCHAR(50) NOT NULL,
    engine VARCHAR(50) NOT NULL
)
CREATE TABLE company(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    company_name VARCHAR(50) NOT NULL
);
CREATE TABLE brand(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    brand_name VARCHAR(50) NOT NULL
);
CREATE TABLE model(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    model_name VARCHAR(50) NOT NULL,
    model_year TIMESTAMP NOT NULL,
    model_style VARCHAR(50)
);
CREATE TABLE manufacturer(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    manufacturer_name VARCHAR(50) NOT NULL,
    manufacturer_locate VARCHAR(50) NOT NULL
);
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(1,'Lenz','Beijing');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(2,'NEB','Pekin');

CREATE TABLE sales(
    date_of_sale TIMESTAMP NOT NULL,
    price NUMERIC(19,2) NOT NULL,
    vehicle_vin int REFERENCES vehicle(vin),
    customer_id int REFERENCES customer(id),
    dealer_id int REFERENCES dealers(dealer_id)
);


CREATE TABLE customer(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name varchar NOT NULL ,
    last_name varchar NOT NULL ,
    gender varchar(1) NOT NULL CHECK ( gender = 'M' OR gender = 'F' ),
    phone VARCHAR(50) NOT NULL
);

insert into customer values (1, 'Eva', 'Johnson', 'F', 24345), (2, 'Sarah', 'Bishop', 'M', 51356), (3, 'William', 'Buffington', 'F', 91422), (4, 'Regina', 'Cleland', 'M', 26089), (5, 'John', 'Palmer', 'F', 42731), (6, 'Terrance', 'Fenderson', 'M', 1198), (7, 'Douglas', 'Sprague', 'F', 58941), (8, 'Paul', 'Kunz', 'M', 67047), (9, 'Dale', 'Stramel', 'F', 98708) ;
CREATE TABLE dealer(
    dealer_id int NOT NULL PRIMARY KEY ,
    org_name varchar NOT NULL,
    contract_duration int NOT NULL CHECK ( contract_duration > 0 )
);
insert into dealers values (1, 'Alex', 1), (2, 'Adam', 2), (3, 'Ganstra', 4), (4, 'High', 1);


CREATE TABLE supplier(
    supplier_id int NOT NULL PRIMARY KEY ,
    org_name varchar NOT NULL,
    detail_id int REFERENCES details(detail_id)
);CREATE TABLE supplies(
    detail_id BIGSERIAL NOT NULL,
    supply_date DATE NOT NULL,
    detail_id int REFERENCES details(detail_id));


ALTER TABLE vehicle ADD manufacturer_id BIGINT REFERENCES manufacturer(id);
ALTER TABLE vehicle ADD customer_id BIGINT REFERENCES customer(id);
ALTER TABLE vehicle ADD option_id BIGINT REFERENCES option(id);
ALTER TABLE vehicle ADD model_id BIGINT REFERENCES model(id);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(1,'Kia Rio',1,1,1,1);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(2,'Audi R8',2,2,2,2);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(3,'BMW M5',3,3,3,3);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(4,'Alpha Romeo',4,4,4,4);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(5,'BMW M3',5,5,5,5);
ALTER TABLE option ADD model_id BIGINT REFERENCES model(id);
INSERT INTO option(id,color,engine,model_id)
VALUES(1,'red','2 cylinders',1);
INSERT INTO option(id,color,engine,model_id)
VALUES(2,'blue','3 cylinders',2);
INSERT INTO option(id,color,engine,model_id)
VALUES(3,'black','2 cylinders',3);
INSERT INTO option(id,color,engine,model_id)
VALUES(4,'white','3 cylinders',4);
INSERT INTO option(id,color,engine,model_id)
VALUES(5,'black','3 cylinders',5);
INSERT INTO company(id,company_name)
VALUES(1,'Toyota');
INSERT INTO company(id,company_name)
VALUES(2,'BMW');
INSERT INTO company(id,company_name)
VALUES(3,'Ford');
INSERT INTO company(id,company_name)
VALUES(4,'Lamborgini');
INSERT INTO company(id,company_name)
VALUES(5,'Nissan');
ALTER TABLE brand ADD company_id BIGINT REFERENCES company(id);
INSERT INTO brand(id,brand_name,company_id)
VALUES(1,'Toyota',1);
INSERT INTO brand(id,brand_name,company_id)
VALUES(2,'BMW',2);
INSERT INTO brand(id,brand_name,company_id)
VALUES(3,'Ford',3);
INSERT INTO brand(id,brand_name,company_id)
VALUES(4,'Lamborgini',4);
ALTER TABLE model ADD brand_id BIGINT REFERENCES brand(id);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(1,'Kia Rio','2021-11-12 16:23:12','road',1);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(2,'Audi R8','2020-03-27 18:30:57','road',2);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(3,'BMW M5','2021-01-10 13:05:36','road',3);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(4,'Alpha Romeo','2021-02-07 12:09:15','road',4);
ALTER TABLE model
ALTER COLUMN model_year TYPE VARCHAR(50);
UPDATE model
SET model_year = '2020-04-47 18:04:23'
WHERE id = 1;
INSERT INTO sales VALUES('2021-03-17 12:09:15',42000,1,1,1);
INSERT INTO sales VALUES('2021-12-02 05:37:45' ,45000,2,2,2);
INSERT INTO sales VALUES('2020-11-19 18:10:37',32000,3,3,3);
INSERT INTO sales VALUES('2021-09-13 09:32:45' ,42000,4,4,4);
INSERT INTO sales VALUES('2021-04-24 07:33:17',30000,5,5,3);
INSERT INTO sales VALUES('2020-07-11 19:47:35' ,48000,6,6,2);
insert into supplier values (1, 'Getrag', 5), (2, 'Atrak', 3);

create view data as
    select date_of_sale('year', sales.date) as year,
           date_of_sale('month', sales.date) as month,
           date_of_sale('week', sales.date) as week, brand.id,
    join model on sale.vehicle_vin = model.vehicle_vin
drop view data;

select * from data;
create view trends as select year, month, week, max(c) as m from data group by year, month, week;
drop view trends;
select * from trends;
create view show as select data.year as year, data.month as month, data.week as week, brands.brand_id, brands.name
    from trends join data on trends.year = data.year and trends.month = data.month and trends.m = data.c and trends.week = data.week
        join brands on brands.brand_id = data.brand_id;
drop view show;

SELECT MAX(price) FROM sales;
SELECT MAX(price) FROM sales
WHERE price NOT IN(SELECT MAX(price) FROM sales);

select * from show;
select customer.gender, show.year, show.month, show.week, show.name from show
    join brand on show.brand_id = brand.brand_id
    join model on model.model_id = brand.model_id
    join sales on model.vehicle_id = sale.vehicle_id
    join customer on buy.buyer_id = customer_id group by customer.gender, show.year, show.month, show.week, show.name;


SELECT vehicle_vin FROM sales
WHERE price >= 38000;

SELECT brand_id FROM model
WHERE (id = 1 OR id = 2);

SELECT brand_name FROM brand
WHERE (id = 3 OR id = 2);


SELECT MAX(time_keep) FROM dealer;
SELECT MAX(time_keep) FROM dealer
WHERE time_keep NOT IN(SELECT MAX(time_keep) FROM dealer);
SELECT id FROM dealer
WHERE (time_keep = 21 OR time_keep = 15);
-ALTER TABLE supplies ADD COLUMN vehiclevin BIGINT;


SELECT vehiclevin FROM supplies
WHERE(supply_date = '2019-01-04' OR supply_date = '2019-01-05');

SELECT customer_id FROM vehicle
WHERE(vin = 1 OR vin = 2 OR vin = 6);

SELECT date_of_sale FROM sales
WHERE brand_vision = 'BMW';