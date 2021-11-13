--  6a  6d
-- 1
-- How can we store large-object types?
--  We can store it in binary large object(blob) and in character large object(clob)
--  to store audio, video, images, and other files that are larger than 32 KB.
--     blob:
--              to store large amounts of noncharacter data,
--              such as pictures, voice, and mixed media.
--     clob:
--              to store SBCS or mixed data, such as
--              documents that contain single character set.
-- 2
-- What is the difference between privilege, role and user?
--     Privileges control the ability to run SQL statements.
--     A role is a group of privileges.
--     Role can have many users.
--     A user is an individual person who is included in the role
--     This makes is easier to assign permissions to database objects.
--     You can assign permissions to the role, and any user who belongs to
--     that role inherits the same set of permissions.


-- 2a
-- create accountant, administrator, support roles and grant appropriate privileges
CREATE ROLE administrator SUPERUSER;
CREATE ROLE accountant;
CREATE ROLE support;
GRANT ALL PRIVILEGES ON accounts, transactions, customers to administrator;
GRANT SELECT,INSERT,UPDATE (status), DELETE ON transactions TO accountant;
GRANT SELECT on customers TO support;

-- 2b
-- create some users and assign them roles
CREATE USER Ayau;
CREATE USER Ayazhan;
CREATE USER Ayaulym;

GRANT accountant to Ayau;
GRANT adminstrator to Ayazhan;
GRANT support to Ayaulym;

-- 2c
-- give to some of them permission to grant roles to other users
GRANT ALL PRIVILEGES ON accounts to Ayazhan;
ALTER ROLE administrator CREATEROLE;

-- 2d
-- revoke some privilege from particular user
REVOKE DELETE on transactions FROM Ayau;
REVOKE SELECT, UPDATE on customers from Ayazhan;

-- 3b
-- add not null constraints
ALTER TABLE accounts ALTER COLUMN customer_id SET NOT NULL;

-- 5a
-- index so that each customer can only have one account of onecurrency
CREATE UNIQUE INDEX check_for_uniqueness ON accounts (currency,customer_id);

-- 5b
-- index for searching transactions by currency and balance
CREATE INDEX for_transactions ON accounts(currency, balance);

-- 6
-- Write a SQL transaction that illustrates money transaction from oneaccount to another:

-- 6a
-- create transaction with “init” status

-- 6b
-- increase balance for destination account and decrease for sourceaccount
UPDATE accounts SET balance = balance - 222.00
    WHERE account_id = 'RS88012';
UPDATE accounts SET balance = balance + 222.00
    WHERE account_id = 'AB10203';

-- 6c
-- if in source account balance becomes below limit, then makerollback
BEGIN TRANSACTION ;
SELECT * FROM accounts WHERE (accounts_id=src_account,limit>balance) then ROLLBACK;

-- 6d
-- update transaction with appropriate status(commit or rollback)
COMMIT ;