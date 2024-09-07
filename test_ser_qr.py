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


import pandas as pd

# สร้างข้อมูลตัวอย่าง
data = {
    'date': pd.date_range(start='2024-01-01', periods=365, freq='D'),
    'value': range(365)
}
# print(data['value'])

df = pd.DataFrame(data)

# ตั้งค่า 'date' ให้เป็น index
df.set_index('date', inplace=True)

# แปลงข้อมูลเป็นรายสัปดาห์ (จะสรุปรวมในแต่ละสัปดาห์)
weekly_df = df.resample('W').sum()

# แปลงข้อมูลเป็นรายปี (จะสรุปรวมในแต่ละปี)
yearly_df = df.resample('Y').sum()

print("รายสัปดาห์:")
print(weekly_df.head())

print("\nรายปี:")
print(yearly_df.head())
