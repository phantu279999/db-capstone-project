import mysql.connector as connector

connection = connector.connect(user="root", password="1234", db='littlelemon')
cursor = connection.cursor()


show_tables_query = "SHOW tables"
cursor.execute(show_tables_query)
results = cursor.fetchall()
for it in results:
    print(it)



query_order = """
SELECT * FROM Orders o
INNER JOIN Bookings b ON b.OrderID = o.OrderID
WHERE o.TotalCost > 60;
"""
cursor.execute(query_order)
results = cursor.fetchall()
for it in results:
    print(it)
