import serial.tools.list_ports
import serial
import threading
import time

def found_comport():
    list_of_device = []
    ports = list(serial.tools.list_ports.comports())
    for port in ports:
        list_of_device.append(port.device)
    return list_of_device

global_ser_scaner = None
def run_comport():
    global global_ser_scaner
    print(found_comport())
    com_port = input("device : ")
    global_ser_scaner = serial.Serial(com_port, 115200, timeout=1)
    global_ser_scaner.write(b'read_qr\n')
    dataQr_fromscaner = ''
    while True:
        if(global_ser_scaner.is_open):
            if global_ser_scaner and global_ser_scaner.in_waiting > 0:
                line = global_ser_scaner.readline().decode('utf-8').rstrip()
                print(f'Received: {line}')

c1 = threading.Thread(target=run_comport)
c1.daemon = True
c1.start()

def test():
    global global_ser_scaner
    while True:
        if(input("agin(1):")=="1"):
            global_ser_scaner.write(b'read_qr\n')

time.sleep(5)
while True:
    if(input("agin(1):")=="1"):
        global_ser_scaner.write(b'read_qr\n')