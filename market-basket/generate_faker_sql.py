import random
from datetime import date
from datetime import timedelta

import mariadb
import numpy as np
from faker import Faker

fake = Faker()


def create_connection(database_name):
    try:
        conn = mariadb.connect(
            user="admin",
            password="C0lumnStore!",
            host="localhost",
            port=3307,
            database=database_name,
        )
        return conn
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB: {e}")
        return None


def add_stores(cursor, num_stores=10):
    store_data = [(fake.company(), fake.city()) for _ in range(num_stores)]

    # Create a string of comma-separated values
    values_str = ', '.join(map(str, store_data))

    # Insert all data in one run
    cursor.execute(f"INSERT INTO Stores (store_name, location) VALUES {values_str}")

    cursor.connection.commit()  # Commit after all stores have been added

    print(f"Added {num_stores} stores")


def add_products(cursor, num_products=10):
    product_data = [(fake.word(), round(random.uniform(1, 100), 2)) for _ in range(num_products)]

    # Create a string of comma-separated values
    values_str = ', '.join(map(str, product_data))

    # Insert all data in one run
    cursor.execute(f"INSERT INTO Products (product_name, price) VALUES {values_str}")

    cursor.connection.commit()  # Commit after all products have been added

    print(f"Added {num_products} products")


def add_transactions(cursor, num_transactions=10, start_date=date(2021, 1, 1), end_date=date(2021, 12, 31)):
    cursor.execute("SELECT store_id FROM Stores")
    store_ids = np.array([row[0] for row in cursor.fetchall()], dtype=np.int32)

    # Number of days between start_date and end_date
    days_range = (end_date - start_date).days + 1

    # Generate random days and store ids
    random_days = np.random.randint(0, days_range, num_transactions)
    random_store_ids = np.random.choice(store_ids, num_transactions)

    # Prepare transaction data
    transaction_data = [
        (int(store_id), (start_date + timedelta(days=int(day))).isoformat())
        for store_id, day in zip(random_store_ids, random_days)
    ]

    # Create a string of comma-separated values
    values_str = ', '.join(map(str, transaction_data))

    # Insert all data in one run
    cursor.execute(f"INSERT INTO Transactions (store_id, transaction_date) VALUES {values_str}")

    cursor.connection.commit()  # Commit after all transactions have been added

    print(f"Added {num_transactions} transactions")


def add_transaction_details(cursor, num_details=100):
    cursor.execute("SELECT product_id FROM Products")
    product_ids = np.array([row[0] for row in cursor.fetchall()], dtype=np.int32)

    cursor.execute("SELECT transaction_id FROM Transactions")
    transaction_ids = np.array([row[0] for row in cursor.fetchall()], dtype=np.int32)

    # Generate random transaction ids and product ids
    random_transaction_ids = np.random.choice(transaction_ids, num_details)
    random_product_ids = np.random.choice(product_ids, num_details)

    # Prepare transaction details data
    details_data = []
    unique_pairs = set()
    for transaction_id, product_id in zip(random_transaction_ids, random_product_ids):
        pair = (transaction_id, product_id)
        if pair not in unique_pairs:
            unique_pairs.add(pair)
            details_data.append((transaction_id, product_id, random.randint(1, 10)))

    # Create a string of comma-separated values
    values_str = ', '.join(map(str, details_data))

    # Insert all data in one run
    cursor.execute(
        f"INSERT INTO Transaction_Details (transaction_id, product_id, quantity) VALUES {values_str}")

    cursor.connection.commit()  # Commit after all transactions have been added

    print(f"Added {num_details} transaction details")


# Example usage within a database connection context
def generate_data(database_name, num_stores=10, num_products=100, num_transactions=10000, num_details=70000):
    conn = create_connection(database_name)
    if conn is not None:
        cursor = conn.cursor()
        add_stores(cursor, num_stores)
        add_products(cursor, num_products)
        add_transactions(cursor, num_transactions)
        add_transaction_details(cursor, num_details)
        conn.commit()  # Final commit for any remaining operations
        cursor.close()
        conn.close()


if __name__ == "__main__":
    databases = ["columnstore_db", "relational_db"]

    for database in databases:
        generate_data(database)
        print(f"Generated data for {database}")
