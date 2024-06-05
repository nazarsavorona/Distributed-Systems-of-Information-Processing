-- create sample table
CREATE TABLE sample_table
(
    id   serial PRIMARY KEY,
    name VARCHAR(50),
    age  INTEGER
);

-- insert sample data
INSERT INTO sample_table (name, age)
VALUES ('Alice', 25);
INSERT INTO sample_table (name, age)
VALUES ('Bob', 30);
INSERT INTO sample_table (name, age)
VALUES ('Charlie', 35);

