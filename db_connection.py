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

    if connection.is_connected():
        print("✅ VS Code пен MySQL байланысы орнатылды!")

    connection.close()

except mysql.connector.Error as error:
    print("❌ Қате:", error)