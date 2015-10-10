static const int LED = 7;

void setup() {

  while (!Serial);
  Serial.begin(115200);
  Serial.println("boot");

  pinMode(LED, OUTPUT);
}

void loop() {
  digitalWrite(LED, HIGH);
  delay(100);
  digitalWrite(LED, LOW);
  delay(500);
  Serial.println("alive");
}
