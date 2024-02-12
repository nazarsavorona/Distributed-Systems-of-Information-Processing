CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    login    VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE cities
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE resumes
(
    id      SERIAL PRIMARY KEY,
    user_id INT REFERENCES users (id),
    city_id INT REFERENCES cities (id)
);

CREATE TABLE hobbies
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)
);


CREATE TABLE institutions
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)
);


CREATE TABLE previous_jobs
(
    id             SERIAL PRIMARY KEY,
    institution_id INT REFERENCES institutions (id),
    info           TEXT
);

CREATE TABLE user_hobbies
(
    user_id  INT REFERENCES users (id),
    hobby_id INT REFERENCES hobbies (id),
    PRIMARY KEY (user_id, hobby_id)
);

CREATE TABLE user_previous_jobs
(
    user_id INT REFERENCES users (id),
    job_id  INT REFERENCES previous_jobs (id),
    PRIMARY KEY (user_id, job_id)
);