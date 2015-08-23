#include <Wire.h>
#include <ITG3200.h>

ITG3200 itg;

void setup() {
    while(!Serial);

    Serial.begin(9600);
    Serial.println("Hello World");

    itg.initialize();
}

void loop() {
    Serial.println(itg.x());
    Serial.println(itg.y());
    Serial.println(itg.z());
}
