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

void serial_message(sensors_event_t& event, uint8_t sys, uint8_t gyro, uint8_t accel, uint8_t mag) {
  /* ARDUINO IST SCHEISSE!!! */
  Serial.print(F("{orientation:{x:"));
  Serial.print((float)event.orientation.x);
  Serial.print(F(",y:"));
  Serial.print((float)event.orientation.y);
  Serial.print(F(",z:"));
  Serial.print((float)event.orientation.z);
  Serial.println(F("}}"));
}

