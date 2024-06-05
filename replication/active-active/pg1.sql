CREATE SEQUENCE emp_eid_seq
    START 1
    INCREMENT 2;

CREATE TABLE emp (eid int NOT NULL DEFAULT nextval('emp_eid_seq') primary key,
                  first_name varchar(40),
                  last_name varchar(40),
                  email varchar(100),
                  hire_dt timestamp);

INSERT INTO emp (FIRST_NAME,LAST_NAME,EMAIL,HIRE_DT) VALUES ('John', 'Doe', 'johndoe@example.com', '2021-01-15 09:00:00'),
                                                            ('Jane', 'Smith', 'janesmith@example.com', '2022-03-20 14:30:00'),
                                                            ('Michael', 'Johnson', 'michaelj@example.com', '2020-12-10 10:15:00'),
                                                            ('Emily', 'Williams', 'emilyw@example.com', '2023-05-05 08:45:00'),
                                                            ('David', 'Brown', 'davidbrown@example.com', '2019-11-25 11:20:00'),
                                                            ('Sarah', 'Taylor', 'saraht@example.com', '2022-09-08 13:00:00'),
                                                            ('Robert', 'Anderson', 'roberta@example.com', '2021-07-12 16:10:00'),
                                                            ('Jennifer', 'Martinez', 'jenniferm@example.com', '2023-02-18 09:30:00'),
                                                            ('William', 'Jones', 'williamj@example.com', '2020-04-30 12:45:00'),
                                                            ('Linda', 'Garcia', 'lindag@example.com', '2018-06-03 15:55:00');

CREATE ROLE repuser WITH REPLICATION LOGIN PASSWORD 'welcome1';
GRANT all ON all tables IN schema public TO repuser;

CREATE PUBLICATION hrpub1
    FOR TABLE emp;

CREATE SUBSCRIPTION hrsub1
    CONNECTION 'host=postgres2 port=5432 user=repuser password=welcome1 dbname=db'
    PUBLICATION hrpub2
    WITH (origin = none, copy_data = false);


SELECT * FROM emp WHERE eid=1;
UPDATE emp SET first_name='Bugs', last_name='Bunny' WHERE eid=1;
