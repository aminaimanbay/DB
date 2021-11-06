-- 1a
-- combine each row of dealer table with each row of client table
-- if it should be 48 rows
SELECT * FROM dealer CROSS JOIN client;
-- if it should be 8 rows
SELECT * FROM client FULL OUTER JOIN  dealer ON dealer.id = client.dealer_id;

-- 1b
-- find all dealers along with client name, city, priority, sell number, date, and amount
SELECT d, c.name, c.city, c.priority, s.id, s.date, s.amount
FROM dealer d
LEFT JOIN client c ON d.id = c.dealer_id
LEFT JOIN sell s ON c.id = s.client_id

-- 1c
-- find the dealer and client who belongs to same city
SELECT dealer, client
FROM dealer INNER JOIN client ON client.city = dealer.location;

-- 1d
-- find sell id, amount, client name, city those sells
-- where sell amount exists between 100 and 500
SELECT sell.id, amount , client.name, client.city FROM
sell INNER JOIN client
ON 100<=amount AND amount <=500 AND client_id = client.id;

-- 1e
-- find dealers who works either for one or more client or not yet join under any of the clients
SELECT d.name, COUNT(c.name)
FROM dealer d LEFT OUTER JOIN  client c ON d.id = c.dealer_id
GROUP BY d.name;

-- 1f
-- find the dealers and the clients he service, return client name, city, dealer name, charge.
SELECT c.name, city, d.name, charge
FROM dealer d JOIN client c ON d.id = c.dealer_id;

-- 1g
-- find client name, client city, dealer, commission those dealers who received acommission from the sell more than 12%
SELECT client.name ,client.city,dealer.name , dealer.charge
FROM dealer INNER JOIN client ON dealer.id = client.dealer_id WHERE dealer.charge>0.12;

-- 1h
-- make a report with client name, city, sell id, sell date, sell amount, dealer nameand commission
-- to find that either any of the existing clients haven’t made apurchase(sell) or made one or more purchase(sell)
-- by their dealer or by own.
SELECT c.name, city, s.id, date, amount, d.name, charge
FROM dealer d JOIN client c ON d.id = c.dealer_id JOIN sell s ON c.id = s.client_id ORDER BY c.name;

-- 1i
-- find dealers who either work for one or more clients. The client may have made,either one or more purchases on or above purchases amount 2000 and must have priority, or he may not have made any purchase to the associated dealer. Printclient name, client grade, dealer name, sell id, sell amount
SELECT c.name client_name, c.priority, d.name dealer_name, s.id sell_id, s.amount
FROM client c
         RIGHT JOIN  dealer d ON d.id = c.dealer_id
        LEFT JOIN  sell s ON s.client_id = c.id
WHERE s.amount >= 2000
  AND c.priority IS NOT NULL ;

-- 2

-- 2a
-- a.count the number of unique clients, compute average and total purchaseamount of client orders by each date.
CREATE VIEW a2 AS
SELECT date, count(distinct client_id), avg(amount), sum(amount)
FROM sell
GROUP BY date;
SELECT * FROM a2;

-- 2b
-- find top 5 dates with the greatest total sell amount
CREATE VIEW b2 AS
SELECT s.date, s.amount
FROM sell s
ORDER BY s.amount DESC
LIMIT 5;
SELECT * FROM b2;

-- 2c
-- c.count the number of sales, compute average and total amount of allsales of each dealer
CREATE VIEW c2 AS
 SELECT dealer.name, count(sell.id), avg(amount), sum(amount)
 FROM dealer
INNER JOIN sell ON dealer.id = sell.dealer_id
 GROUP BY dealer.name;
SELECT * FROM c2;

-- 2d
-- compute how much all dealers earned from charge(total sell amount *charge) in each location
CREATE VIEW d2 AS
SELECT dealer.location, sum(sell.amount)*(dealer.charge) AS "earned"
 FROM dealer
 INNER JOIN sell ON dealer.id = sell.dealer_id
GROUP BY dealer.location, dealer.charge;
SELECT * FROM d2;

-- 2e
-- compute number of sales, average and total amount of all sales dealersmade in each location
CREATE VIEW e2 AS
 SELECT location ,COUNT(sell.id) ,AVG(amount) ,SUM(amount)
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;
SELECT * FROM e2;

-- 2f
-- compute number of sales, average and total amount of expenses ineach city clients made.
CREATE VIEW f2 AS
SELECT c.city, COUNT(s.id), AVG(s.amount * (d.charge + 1)), SUM(s.amount * (d.charge + 1))
FROM client c
JOIN dealer d ON c.dealer_id = d.id
JOIN sell s ON c.id = s.client_id
GROUP BY c.city;
SELECT * FROM f2;

-- 2g
-- find cities where total expenses more than total amount of sales inlocations
CREATE VIEW g2 AS
SELECT location, SUM(s.amount * (d.charge + 1)) AS totalexpense, SUM(s.amount) AS totalamount
FROM sell s
JOIN dealer d ON s.dealer_id = d.id
GROUP BY location;
SELECT * FROM g2;

DROP VIEW a2;
DROP VIEW b2;
DROP VIEW c2;
DROP VIEW d2;
DROP VIEW e2;
DROP VIEW f2;
DROP VIEW g2;






