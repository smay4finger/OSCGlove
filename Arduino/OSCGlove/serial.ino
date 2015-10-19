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
  Serial.print(F("Orientation: "));
  Serial.print((float)event.orientation.x);
  Serial.print(F(" "));
  Serial.print((float)event.orientation.y);
  Serial.print(F(" "));
  Serial.print((float)event.orientation.z);
  Serial.println(F(""));
  Serial.print(F("Calibration: "));
  Serial.print(sys, DEC);
  Serial.print(F(" "));
  Serial.print(gyro, DEC);
  Serial.print(F(" "));
  Serial.print(accel, DEC);
  Serial.print(F(" "));
  Serial.println(mag, DEC);

//  uint8_t message[] = {
//    0x80 + 9,  // fixmap of three
//    0xa1, 't', 0xce, (t >> 24), (t >> 16), (t >> 8), (t >> 0),
//    0xa2, 'l', 't', 0xd2, (lt >> 24), (lt >> 16), (lt >> 8), (lt >> 0),
//    0xa2, 'l', 'g', 0xd2, (lg >> 24), (lg >> 16), (lg >> 8), (lg >> 0),
//    0xa1, 'v', 0xcd, (v >> 8), (v >> 0),
//    0xa1, 'h', 0xcd, (h >> 8), (h >> 0),
//    0xa1, 'e', 0xd2, (e >> 24), (e >> 16), (e >> 8), (e >> 0),
//    0xa2, 'h', 'd', 0xcc, hd,
//    0xa2, 'v', 's', 0xcc, vs,
//    0xa2, 's', 's', 0xcc, ss,
//  };
}

