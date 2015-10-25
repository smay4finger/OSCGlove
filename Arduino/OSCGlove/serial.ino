void serial_init() {
  pinMode(LED, OUTPUT);
  Serial.begin(115200);
  while (!Serial) {
    digitalWrite(LED, HIGH); delay(10);
    digitalWrite(LED, LOW); delay(50);
  }
}

void serial_guru_meditation(const __FlashStringHelper* error) {
  digitalWrite(LED, HIGH);
  while (true) {
    Serial.print("guru meditation: ");
    Serial.println(error);
    delay(1000);
  }
}

void serial_message(imu::Vector<3> euler,
                    imu::Vector<3> linear,
                    imu::Vector<3> gravity,
                    uint8_t sys,
                    uint8_t gyro,
                    uint8_t accel,
                    uint8_t mag) {
  Serial.print(F("{euler:{x:"));
  Serial.print(euler.x());
  Serial.print(F(",y:"));
  Serial.print(euler.y());
  Serial.print(F(",z:"));
  Serial.print(euler.z());
  Serial.print(F("},linear:{x:"));
  Serial.print(linear.x());
  Serial.print(F(",y:"));
  Serial.print(linear.y());
  Serial.print(F(",z:"));
  Serial.print(linear.z());
  Serial.print(F("},gravity:{x:"));
  Serial.print(gravity.x());
  Serial.print(F(",y:"));
  Serial.print(gravity.y());
  Serial.print(F(",z:"));
  Serial.print(gravity.z());
  Serial.print(F("},cal:{system:"));
  Serial.print(sys);
  Serial.print(F(",gyro:"));
  Serial.print(gyro);
  Serial.print(F(",accel:"));
  Serial.print(accel);
  Serial.print(F(",mag:"));
  Serial.print(mag);
  Serial.println(F("}}"));
}

