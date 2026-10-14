import mysql.connector
from getpass import getpass

password = getpass("MySQL паролін енгіз: ")

try:
    connection = mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password=password,
        database="smart_library"
    )

    cursor = connection.cursor()

    cursor.execute(
        "SELECT book_id, title, author FROM Books WHERE book_id = %s",
        (11,)
    )

    book = cursor.fetchone()

    if book:
        print("✅ MySQL-ден кітап табылды!")
        print("Кітап ID:", book[0])
        print("Атауы:", book[1])
        print("Авторы:", book[2])
    else:
        print("❌ Кітап табылмады")

except mysql.connector.Error as error:
    print("❌ Қате:", error)

finally:
    if "cursor" in locals():
        cursor.close()
    if "connection" in locals() and connection.is_connected():
        connection.close()