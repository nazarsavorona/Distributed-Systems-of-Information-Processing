-- delete columnstore_db if it exists
DROP DATABASE IF EXISTS columnstore_db;

-- create database
CREATE DATABASE columnstore_db;

-- use database
USE columnstore_db;

-- Create table for stores
CREATE TABLE Stores
(
    store_id   INT          NULL COMMENT 'autoincrement=1',
    store_name VARCHAR(255) NOT NULL,
    location   VARCHAR(255) NOT NULL
) ENGINE = Columnstore
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- Create table for products
CREATE TABLE Products
(
    product_id   INT            NULL COMMENT 'autoincrement=1',
    product_name VARCHAR(255)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL
) ENGINE = Columnstore
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- Create table for transactions
CREATE TABLE Transactions
(
    transaction_id   INT NULL COMMENT 'autoincrement=1',
    store_id         INT,
    transaction_date DATE
) ENGINE = Columnstore
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;

-- Create table for transaction details
CREATE TABLE Transaction_Details
(
    transaction_details_id INT NULL COMMENT 'autoincrement=1',
    transaction_id         INT,
    product_id             INT,
    quantity               INT
) ENGINE = Columnstore
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8mb3_general_ci;
