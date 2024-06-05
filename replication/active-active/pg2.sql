CREATE SEQUENCE emp_eid_seq
    START 2
    INCREMENT 2;

CREATE TABLE emp (eid int NOT NULL DEFAULT nextval('emp_eid_seq') primary key,
                  first_name varchar(40),
                  last_name varchar(40),
                  email varchar(100),
                  hire_dt timestamp);

CREATE ROLE repuser WITH REPLICATION LOGIN PASSWORD 'welcome1';
GRANT all ON all tables IN schema public TO repuser;

CREATE PUBLICATION hrpub2
    FOR TABLE emp;

CREATE SUBSCRIPTION hrsub2
    CONNECTION 'host=postgres1 port=5432 user=repuser password=welcome1 dbname=db'
    PUBLICATION hrpub1
    WITH (origin = none, copy_data = true);

SELECT * FROM emp WHERE eid=1;
SELECT * FROM emp WHERE eid=3;
UPDATE emp SET first_name='Road', last_name='Runner' WHERE eid=3;