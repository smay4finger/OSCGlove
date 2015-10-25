#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>

static const int LED = 7;

static const int ERROR_BNO055 = 0x5206;

static const int cycle_time_ms = 20; // millisecons

Adafruit_BNO055 bno = Adafruit_BNO055();

void setup(void) {
  serial_init();

  if (!bno.begin()) {
    serial_guru_meditation(F("BNO055 initialization"));
  }
  bno.setExtCrystalUse(true);

  delay(3000);
}

void serial_message(imu::Vector<3> euler,
                    imu::Vector<3> linear,
                    imu::Vector<3> gravity,
                    uint8_t sys,
                    uint8_t gyro,
                    uint8_t accel,
                    uint8_t mag);

void loop(void) {
  static long next = (long)millis();

  if ((long)millis() - next >= 0) {
    next = millis() + cycle_time_ms;

    imu::Vector<3> euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);
    imu::Vector<3> linear = bno.getVector(Adafruit_BNO055::VECTOR_LINEARACCEL);
    imu::Vector<3> gravity = bno.getVector(Adafruit_BNO055::VECTOR_GRAVITY);

    uint8_t sys, gyro, accel, mag = 0;
    bno.getCalibration(&sys, &gyro, &accel, &mag);

    serial_message(euler, linear, gravity, sys, gyro, accel, mag);

    if ((long)millis() - next >= 0) {
      serial_guru_meditation(F("short cycle"));
    }
  }
}
