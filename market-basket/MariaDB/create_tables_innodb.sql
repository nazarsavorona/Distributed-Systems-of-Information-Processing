-- drop relational_db
DROP DATABASE IF EXISTS relational_db;

-- create new database
CREATE DATABASE relational_db;

-- use the database
USE relational_db;

-- create table for stores
CREATE TABLE Stores
(
    store_id   INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    location   VARCHAR(255) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- create table for products
CREATE TABLE Products
(
    product_id   INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- create table for transactions
CREATE TABLE Transactions
(
    transaction_id   INT AUTO_INCREMENT PRIMARY KEY,
    store_id         INT,
    transaction_date DATE,
    FOREIGN KEY (store_id) REFERENCES Stores (store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- create table for transaction details
CREATE TABLE Transaction_Details
(
    transaction_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id        INT,
    product_id            INT,
    quantity              INT,
    FOREIGN KEY (transaction_id) REFERENCES Transactions (transaction_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- create index for faster search
CREATE INDEX idx_product ON Transaction_Details (product_id);
CREATE INDEX idx_transaction ON Transaction_Details (transaction_id);




