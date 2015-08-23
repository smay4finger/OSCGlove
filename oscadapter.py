#!/usr/bin/env python
import serial
import json

ser = serial.Serial('/dev/ttyACM0', 115200, timeout=1)
while(True):
    try:
        line = ser.readline()
        data = json.loads(line)
        print(data)
    except ValueError:
        print(line)
        pass # ignore

ser.close()
