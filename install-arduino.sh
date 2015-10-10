#!/bin/sh

arduino --pref boardsmanager.additional.urls=https://adafruit.github.io/arduino-board-index/package_adafruit_index.json \
        --install-boards adafruit:avr:1.3.3
arduino --install-library 'Adafruit BNO055':1.0.6
arduino --install-library 'Adafruit NeoPixel':1.0.3
arduino --install-library 'Adafruit Unified Sensor':1.0.2
