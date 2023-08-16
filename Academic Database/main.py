import mysql.connector
from mysql.connector import errorcode
from dotenv import load_dotenv
import os
from db import *

load_dotenv('.env') 

try:
  connection = mysql.connector.connect(user=os.getenv('USER'), password=os.getenv('PASSWORD'), database=os.getenv('DB'))
except mysql.connector.Error as err:
    print(err)
else:
	cursor = connection.cursor()
	program(connection, cursor)
	cursor.close()
	connection.close()
