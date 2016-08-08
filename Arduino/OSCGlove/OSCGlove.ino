#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>

static const int LED = 7;

static const int ERROR_BNO055 = 0x5206;

static const int cycle_time_ms = 30; // millisecons

Adafruit_BNO055 bno = Adafruit_BNO055();

void setup(void) {
  pinMode(LED, OUTPUT);
  Serial.begin(115200);
  while (!Serial) {
    digitalWrite(LED, HIGH); delay(10);
    digitalWrite(LED, LOW); delay(50);
  }

  if (!bno.begin()) {
    for (;;) {
      digitalWrite(LED, LOW); delay(10);
      digitalWrite(LED, HIGH); delay(50);
    }
  }
  bno.setExtCrystalUse(true);

  delay(300);
}

void serial_message(imu::Vector<3> euler,
                    imu::Vector<3> linear,
                    imu::Vector<3> gravity,
                    uint8_t sys,
                    uint8_t gyro,
                    uint8_t accel,
                    uint8_t mag,
                    uint16_t a1,
                    uint16_t a2,
                    uint16_t a3);

imu::Vector<3> euler;
imu::Vector<3> linear;
imu::Vector<3> gravity;
uint8_t sys, gyro, accel, mag;
uint16_t middle_finger;
uint16_t ring_finger;
uint16_t little_finger;
uint8_t buttons;

void loop_button(long now, long cycle_time) {
  static long next = now;
  if (now - next >= 0) {
    next = now + cycle_time;

    Wire.requestFrom(0x20, 1);
    if (Wire.available()) {
      buttons = ~ Wire.read();
    }
  }
}

void loop_serial(long now, long cycle_time) {
  static long next = now;
  if (now - next >= 0) {
    next = now + cycle_time;
    Serial.print(F("{e:{x:"));
    Serial.print(euler.x());
    Serial.print(F(",y:"));
    Serial.print(euler.y());
    Serial.print(F(",z:"));
    Serial.print(euler.z());
    Serial.print(F("},l:{x:"));
    Serial.print(linear.x());
    Serial.print(F(",y:"));
    Serial.print(linear.y());
    Serial.print(F(",z:"));
    Serial.print(linear.z());
    Serial.print(F("},g:{x:"));
    Serial.print(gravity.x());
    Serial.print(F(",y:"));
    Serial.print(gravity.y());
    Serial.print(F(",z:"));
    Serial.print(gravity.z());
    Serial.print(F("},c:{s:"));
    Serial.print(sys);
    Serial.print(F(",g:"));
    Serial.print(gyro);
    Serial.print(F(",a:"));
    Serial.print(accel);
    Serial.print(F(",m:"));
    Serial.print(mag);
    Serial.print(F("},m:"));
    Serial.print(middle_finger);
    Serial.print(F(",r:"));
    Serial.print(ring_finger);
    Serial.print(F(",lf:"));
    Serial.print(little_finger);
    Serial.print(F(",b:"));
    Serial.print(buttons);
    Serial.println(F("}"));
  }
}

void loop_analog(long now, long cycle_time) {
  static long next = now;
  if (now - next >= 0) {
    next = now + cycle_time_ms;

    middle_finger = analogRead(A11);
    ring_finger = analogRead(A10);
    little_finger = analogRead(A9);
  }
}

void loop_imu(long now, long cycle_time) {
  static long next = now;
  if (now - next >= 0) {
    next = now + cycle_time_ms;

    euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);
    linear = bno.getVector(Adafruit_BNO055::VECTOR_LINEARACCEL);
    gravity = bno.getVector(Adafruit_BNO055::VECTOR_GRAVITY);

    bno.getCalibration(&sys, &gyro, &accel, &mag);
  }
}

void loop(void) {
  long timestamp = millis();
  loop_imu(timestamp, cycle_time_ms);
  loop_analog(timestamp, cycle_time_ms);
  loop_button(timestamp, cycle_time_ms * 4);
  loop_serial(timestamp, cycle_time_ms);
}

