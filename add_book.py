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

    sql = """
    INSERT INTO Books
    (title, author, genre, publication_year,
     total_copies, available_copies, hall, shelf)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    values = (
        "Smart Library тест кітабы",
        "Аида Байбосын",
        "IT",
        2026,
        3,
        3,
        "B1",
        "S11"
    )

    cursor.execute(sql, values)
    connection.commit()

    print("✅ Жаңа кітап MySQL деректер қорына қосылды!")
    print("Кітап ID:", cursor.lastrowid)

except mysql.connector.Error as error:
    print("❌ Қате:", error)

finally:
    if "cursor" in locals():
        cursor.close()
    if "connection" in locals() and connection.is_connected():
        connection.close()