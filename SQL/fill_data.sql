-- Inserting data into cities
INSERT INTO cities (name)
VALUES ('Kyiv'),
       ('Lviv'),
       ('Kharkiv'),
       ('Odesa'),
       ('Dnipro');

-- Inserting data into users
INSERT INTO users (login, password)
VALUES ('ivanov', 'password1'),
       ('petrov', 'password2'),
       ('sidorov', 'password3'),
       ('kozlov', 'password4'),
       ('shevchenko', 'password5');

-- Inserting data into institutions
INSERT INTO institutions (name)
VALUES ('PrivatBank'),
       ('Ukrtelecom'),
       ('Kyivstar'),
       ('Epicenter'),
       ('Roshen');

-- Inserting data into hobbies
INSERT INTO hobbies (name)
VALUES ('Football'),
       ('Basketball'),
       ('Chess'),
       ('Reading'),
       ('Coding');

-- Inserting data into previous_jobs
INSERT INTO previous_jobs (institution_id, info)
VALUES (1, 'Worked as a software engineer'),
       (2, 'Worked as a network engineer'),
       (3, 'Worked as a data analyst'),
       (4, 'Worked as a sales manager'),
       (5, 'Worked as a product manager');

-- Inserting data into resumes
INSERT INTO resumes (user_id, city_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Inserting data into user_hobbies
INSERT INTO user_hobbies (user_id, hobby_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Inserting data into user_previous_jobs
INSERT INTO user_previous_jobs (user_id, job_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Inserting more data into cities
INSERT INTO cities (name)
VALUES ('Zaporizhzhia'),
       ('Mykolaiv'),
       ('Vinnytsia'),
       ('Kherson'),
       ('Chernihiv');

-- Inserting more data into users
INSERT INTO users (login, password)
VALUES ('morozov', 'password6'),
       ('vasiliev', 'password7'),
       ('pavlov', 'password8'),
       ('semenov', 'password9'),
       ('stepanov', 'password10');

-- Inserting more data into institutions
INSERT INTO institutions (name)
VALUES ('Nova Poshta'),
       ('ATB-Market'),
       ('Silpo'),
       ('Auchan'),
       ('Metro');

-- Inserting more data into hobbies
INSERT INTO hobbies (name)
VALUES ('Swimming'),
       ('Cycling'),
       ('Hiking'),
       ('Photography'),
       ('Painting');

-- Inserting more data into previous_jobs
INSERT INTO previous_jobs (institution_id, info)
VALUES (6, 'Worked as a logistics manager'),
       (7, 'Worked as a store manager'),
       (8, 'Worked as a cashier'),
       (9, 'Worked as a stocker'),
       (10, 'Worked as a customer service representative');

-- Inserting more data into resumes
INSERT INTO resumes (user_id, city_id)
VALUES (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

-- Inserting more data into user_hobbies
INSERT INTO user_hobbies (user_id, hobby_id)
VALUES (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

-- Inserting more data into user_previous_jobs
INSERT INTO user_previous_jobs (user_id, job_id)
VALUES (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

-- Inserting more data into user_hobbies
INSERT INTO user_hobbies (user_id, hobby_id)
VALUES (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (3, 1),
       (3, 2),
       (4, 5),
       (4, 6),
       (5, 7),
       (5, 8),
       (6, 9),
       (6, 10),
       (7, 6),
       (8, 9),
       (9, 10),
       (9, 6),
       (10, 7),
       (10, 8);

-- Inserting more data into user_previous_jobs
INSERT INTO user_previous_jobs (user_id, job_id)
VALUES (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (3, 1),
       (3, 2),
       (4, 5),
       (4, 6),
       (5, 7),
       (5, 8),
       (6, 9),
       (6, 10),
       (7, 6),
       (8, 9),
       (9, 10),
       (9, 6),
       (10, 7),
       (10, 8);

-- Inserting more data into user_hobbies, so there is two common hobbies among users
INSERT INTO user_hobbies (user_id, hobby_id)
VALUES (1, 4),
       (1, 5),
       (2, 4),
       (2, 5),
       (3, 4),
       (3, 5),
       (5, 4),
       (6, 4),
       (6, 5),
       (7, 4),
       (7, 5),
       (8, 4),
       (8, 5),
       (9, 4),
       (9, 5),
       (10, 4),
       (10, 5);

-- Inserting more data so users have common city with id 2
INSERT INTO resumes (user_id, city_id)
VALUES (4, 2),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 2),
       (10, 2);

