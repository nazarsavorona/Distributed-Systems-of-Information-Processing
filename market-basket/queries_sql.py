import mariadb
import time
from datetime import datetime
import pandas as pd


def create_connection(database_name):
    try:
        return mariadb.connect(
            user="admin",
            password="C0lumnStore!",
            host="localhost",
            port=3307,
            database=database_name
        )
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB {database_name}: {e}")
        return None


def execute_query(database_name, sql_query, data=None):
    conn = create_connection(database_name)
    if conn is None:
        return None
    try:
        cursor = conn.cursor()
        start_time = time.time()
        cursor.execute(sql_query, data)

        if sql_query.strip().upper().startswith("SELECT"):
            records = cursor.fetchall()
            results = records
        else:
            conn.commit()
            results = None

        end_time = time.time()
        duration = end_time - start_time

        return results, duration
    except mariadb.Error as error:
        print(f"Error while executing query in {database_name}", error)
    finally:
        if conn:
            cursor.close()
            conn.close()


queries = {
    "1. quantity of goods sold": """
    SELECT 
    p.product_name,
    SUM(td.quantity) AS total_quantity_sold
FROM 
    Products p
JOIN 
    Transaction_Details td ON p.product_id = td.product_id
GROUP BY 
    p.product_name;

    """,
    "2. cost of goods sold": """
    SELECT 
    p.product_name,
    SUM(td.quantity * p.price) AS cost_of_goods_sold
FROM 
    Products p
JOIN 
    Transaction_Details td ON p.product_id = td.product_id
GROUP BY 
    p.product_name;

    """,
    "3. goods sold for the period": """
    SELECT 
    SUM(td.quantity * p.price) AS cost_of_goods_sold
FROM 
    Products p
JOIN 
    Transaction_Details td ON p.product_id = td.product_id
JOIN 
    Transactions t ON td.transaction_id = t.transaction_id
WHERE 
    t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31';
    
        """,
    "4. how much of product A was purchased in the shop B in period C": """
    SELECT 
    p.product_name,
    s.store_name,
    SUM(td.quantity) AS total_quantity_sold
FROM 
    Products p
JOIN 
    Transaction_Details td ON p.product_id = td.product_id
JOIN 
    Transactions t ON td.transaction_id = t.transaction_id
JOIN 
    Stores s ON t.store_id = s.store_id
WHERE 
    p.product_id = 2
    AND s.store_id = 15
    AND t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    p.product_name, s.store_name;
""",

    "5. amount of product A purchased in all stores during period C": """
    SELECT 
    p.product_name,
    SUM(td.quantity) AS total_quantity_sold
FROM 
    Products p
JOIN 
    Transaction_Details td ON p.product_id = td.product_id
JOIN 
    Transactions t ON td.transaction_id = t.transaction_id
WHERE 
    p.product_id = 34
    AND t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    p.product_name;
    """,

    "6. total revenue of all stores during a specified period": """
    SELECT 
    s.store_name,
    SUM(td.quantity * p.price) AS total_revenue
FROM 
    Stores s
JOIN 
    Transactions t ON s.store_id = t.store_id
JOIN 
    Transaction_Details td ON t.transaction_id = td.transaction_id
JOIN 
    Products p ON td.product_id = p.product_id
WHERE 
    t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    s.store_name;
    """,

    "7. top 10 purchases of two products in period C": """
    SELECT 
    p1.product_name AS product1,
    p2.product_name AS product2,
    COUNT(*) AS pair_count
FROM 
    Transaction_Details td1
JOIN 
    Transaction_Details td2 ON td1.transaction_id = td2.transaction_id AND td1.product_id < td2.product_id
JOIN 
    Transactions t ON td1.transaction_id = t.transaction_id
JOIN 
    Products p1 ON td1.product_id = p1.product_id
JOIN 
    Products p2 ON td2.product_id = p2.product_id
WHERE 
    t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    p1.product_name, p2.product_name
ORDER BY 
    pair_count DESC
LIMIT 10;
    """,

    "8. top 10 purchases of three products in period C": """
    SELECT 
    p1.product_name AS product1,
    p2.product_name AS product2,
    p3.product_name AS product3,
    COUNT(*) AS triplet_count
FROM 
    Transaction_Details td1
JOIN 
    Transaction_Details td2 ON td1.transaction_id = td2.transaction_id AND td1.product_id < td2.product_id
JOIN 
    Transaction_Details td3 ON td1.transaction_id = td3.transaction_id AND td2.product_id < td3.product_id
JOIN 
    Transactions t ON td1.transaction_id = t.transaction_id
JOIN 
    Products p1 ON td1.product_id = p1.product_id
JOIN 
    Products p2 ON td2.product_id = p2.product_id
JOIN 
    Products p3 ON td3.product_id = p3.product_id
WHERE 
    t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    p1.product_name, p2.product_name, p3.product_name
ORDER BY 
    triplet_count DESC
LIMIT 10;
""",
    "9. top 10 purchases of four products in period C": """
    SELECT 
    p1.product_name AS product1,
    p2.product_name AS product2,
    p3.product_name AS product3,
    p4.product_name AS product4,
    COUNT(*) AS quartet_count
FROM 
    Transaction_Details td1
JOIN 
    Transaction_Details td2 ON td1.transaction_id = td2.transaction_id AND td1.product_id < td2.product_id
JOIN 
    Transaction_Details td3 ON td1.transaction_id = td3.transaction_id AND td2.product_id < td3.product_id
JOIN 
    Transaction_Details td4 ON td1.transaction_id = td4.transaction_id AND td3.product_id < td4.product_id
JOIN 
    Transactions t ON td1.transaction_id = t.transaction_id
JOIN 
    Products p1 ON td1.product_id = p1.product_id
JOIN 
    Products p2 ON td2.product_id = p2.product_id
JOIN 
    Products p3 ON td3.product_id = p3.product_id
JOIN 
    Products p4 ON td4.product_id = p4.product_id
WHERE 
    t.transaction_date BETWEEN '2021-01-01' AND '2021-10-31'
GROUP BY 
    p1.product_name, p2.product_name, p3.product_name, p4.product_name
ORDER BY 
    quartet_count DESC
LIMIT 10;
""",
}

if __name__ == "__main__":
    databases = ["columnstore_db", "relational_db"]
    row_list = []

    for database_name in databases:
        for query_name, query in queries.items():
            _, duration = execute_query(database_name, query)
            row_list.append({"query": query_name, "database": database_name, "duration": duration})

    summary = pd.DataFrame(row_list)
    # group by query and database for better visualization
    summary = summary.groupby(["query", "database"]).mean().unstack()
    print(summary)
