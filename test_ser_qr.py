# import serial.tools.list_ports
# import serial
# import threading
# import time

# def found_comport():
#     list_of_device = []
#     ports = list(serial.tools.list_ports.comports())
#     for port in ports:
#         list_of_device.append(port.device)
#     return list_of_device

# global_ser_scaner = None
# def run_comport():
#     global global_ser_scaner
#     print(found_comport())
#     com_port = input("device : ")
#     global_ser_scaner = serial.Serial(com_port, 115200, timeout=1)
#     global_ser_scaner.write(b'read_qr\n')
#     dataQr_fromscaner = ''
#     while True:
#         if(global_ser_scaner.is_open):
#             if global_ser_scaner and global_ser_scaner.in_waiting > 0:
#                 line = global_ser_scaner.readline().decode('utf-8').rstrip()
#                 print(f'Received: {line}')

# c1 = threading.Thread(target=run_comport)
# c1.daemon = True
# c1.start()

# def test():
#     global global_ser_scaner
#     while True:
#         if(input("agin(1):")=="1"):
#             global_ser_scaner.write(b'read_qr\n')

# time.sleep(5)
# while True:
#     if(input("agin(1):")=="1"):
#         global_ser_scaner.write(b'read_qr\n')

# import random
# from datetime import datetime, timedelta

# # Define the start and end dates
# start_date = datetime(2024, 1, 3)
# end_date = datetime(2024, 9, 3)

# # Open a file to write the SQL statements
# with open("insert_data.sql", "w") as f:
#     # Iterate over each day
#     while start_date <= end_date:
#         # Generate random values for A and B
#         A = random.randint(0, 100)
#         B = random.randint(0, 100)
        
#         # Format the date as a string
#         date_str = start_date.strftime('%Y-%m-%d')
        
#         # Write the SQL statement
#         sql_statement = f"INSERT INTO `graph` (`time`, `type_true`, `type_false`) VALUES ('{date_str}', {A}, {B});\n"
#         f.write(sql_statement)
        
#         # Move to the next day
#         start_date += timedelta(days=1)

# print("SQL statements generated successfully!")

# import mysql.connector
# db = mysql.connector.connect(
#         host="210.246.215.145",
#         user="root",
#         password="OKOEUdI1886*",
#         database="plasma"
#     )
# cursor = db.cursor()
# # print(cursor)
# #  '2024-08-05' AND '2024-08-20'
# start_date = '2024-08-05'
# end_date = '2024-08-20'

# query = """SELECT * FROM `graph`WHERE `time` BETWEEN %s AND %s;"""

# cursor.execute(query, (start_date, end_date))
# results = cursor.fetchall()
# for row in results:
#     print(row)
# cursor.close()
# db.close()


# import pandas as pd

# # สร้างข้อมูลตัวอย่าง
# data = {
#     'date': pd.date_range(start='2024-01-01', periods=365, freq='D'),
#     'value': range(365)
# }
# # print(data['value'])

# df = pd.DataFrame(data)

# # ตั้งค่า 'date' ให้เป็น index
# df.set_index('date', inplace=True)

# # แปลงข้อมูลเป็นรายสัปดาห์ (จะสรุปรวมในแต่ละสัปดาห์)
# weekly_df = df.resample('W').sum()

# # แปลงข้อมูลเป็นรายปี (จะสรุปรวมในแต่ละปี)
# yearly_df = df.resample('Y').sum()

# print("รายสัปดาห์:")
# print(weekly_df.head())

# print("\nรายปี:")
# print(yearly_df.head())

# from datetime import datetime
# import mysql.connector
# from mysql.connector import Error

# db = mysql.connector.connect(
#     host="210.246.215.145",
#     user="root",
#     password="OKOEUdI1886*",
#     database="plasma"
# )
# cursor = db.cursor()
# rr = {}

# rr[str(datetime.now().timestamp())] = {"Tube": "True", "Datetime": datetime.fromtimestamp(datetime.now().timestamp())}

# for key, value in rr.items():
#     timestamp_value = datetime.datetime.fromtimestamp(int(key)).strftime('%Y-%m-%d %H:%M:%S')
#     print(f"Converted Timestamp: {timestamp_value}")
    
#     data = value.get("Tube")
#     datetime_value = value.get("Datetime")

#     if data is None or datetime_value is None:
#         print(f"Missing data in value: {value}")
#         continue  # Skip this iteration if data is missing
    
#     try:
#         cursor.execute("""
#         INSERT INTO log (timestamp, data, datetime)
#         VALUES (%s, %s, %s)
#         """, (timestamp_value, data, datetime_value))
#     except Exception as e:
#         print(f"Failed to insert data: {e}")
#         db.rollback()  # Rollback if there's an error
#         continue

# try:
#     db.commit()
#     print("Database commit successful")
# except Exception as e:
#     print(f"Commit failed: {e}")

# try:
#     cursor.close()
#     db.close()
#     print("Database connection closed")
# except Exception as e:
#     print(f"Failed to close the database: {e}")

from datetime import datetime
import mysql.connector
from mysql.connector import Error

db = mysql.connector.connect(
    host="210.246.215.145",
    user="root",
    password="OKOEUdI1886*",
    database="plasma"
)
cursor = db.cursor()
rr = {}

rr[str(datetime.now().timestamp())] = {"Tube": "True", "Datetime": datetime.fromtimestamp(datetime.now().timestamp())}

for key, value in rr.items():
    # Convert the string timestamp back to datetime
    timestamp_value = datetime.fromtimestamp(int(float(key))).strftime('%Y-%m-%d %H:%M:%S')
    print(f"Converted Timestamp: {timestamp_value}")
    
    data = value.get("Tube")
    datetime_value = value.get("Datetime")

    if data is None or datetime_value is None:
        print(f"Missing data in value: {value}")
        continue  # Skip this iteration if data is missing
    
    try:
        cursor.execute("""
        INSERT INTO log (timestamp, data, datetime)
        VALUES (%s, %s, %s)
        """, (timestamp_value, data, datetime_value))
    except Exception as e:
        print(f"Failed to insert data: {e}")
        db.rollback()  # Rollback if there's an error
        continue

try:
    db.commit()
    print("Database commit successful")
except Exception as e:
    print(f"Commit failed: {e}")

try:
    cursor.close()
    db.close()
    print("Database connection closed")
except Exception as e:
    print(f"Failed to close the database: {e}")
