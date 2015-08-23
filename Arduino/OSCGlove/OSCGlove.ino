#include <Wire.h>
#include <ITG3200.h>

#define DEVICE (0x53) // Device address as specified in data sheet 

byte _buff[6];

char POWER_CTL = 0x2D;	//Power Control Register
char DATA_FORMAT = 0x31;
char DATAX0 = 0x32;	//X-Axis Data 0
char DATAX1 = 0x33;	//X-Axis Data 1
char DATAY0 = 0x34;	//Y-Axis Data 0
char DATAY1 = 0x35;	//Y-Axis Data 1
char DATAZ0 = 0x36;	//Z-Axis Data 0
char DATAZ1 = 0x37;	//Z-Axis Data 1

ITG3200 gyro;

void setup()
{
  while(!Serial);
  Serial.begin(57000);  // start serial for output. Make sure you set your Serial Monitor to the same!
  
  Wire.begin();        // join i2c bus (address optional for master)
  
  gyro.initialize();

  //Put the ADXL345 into +/- 4G range by writing the value 0x01 to the DATA_FORMAT register.
  writeTo(DATA_FORMAT, 0x01);
  //Put the ADXL345 into Measurement Mode by writing 0x08 to the POWER_CTL register.
  writeTo(POWER_CTL, 0x08);
}

void loop()
{
  readAccel(); // read the x/y/z tilt
}

void readAccel() {
  uint8_t howManyBytesToRead = 6;
  readFrom(DATAX0, howManyBytesToRead, _buff); //read the acceleration data from the ADXL345

  // each axis reading comes in 10 bit resolution, ie 2 bytes.  Least Significat Byte first!!
  // thus we are converting both bytes in to one int
  int x = (((int)_buff[1]) << 8) | _buff[0];   
  int y = (((int)_buff[3]) << 8) | _buff[2];
  int z = (((int)_buff[5]) << 8) | _buff[4];

  // output to serial
  Serial.print("{\"acc\":{\"x\":");
  Serial.print(x);
  Serial.print(",\"y\":");
  Serial.print(y);
  Serial.print(",\"z\":");
  Serial.print(z);
  Serial.print("},\"gyro\":{\"x\":");
  Serial.print(gyro.x());
  Serial.print(",\"y\":");
  Serial.print(gyro.y());
  Serial.print(",\"z\":");
  Serial.print(gyro.z());
  Serial.println("}}");
}

void writeTo(byte address, byte val) {
  Wire.beginTransmission(DEVICE); // start transmission to device 
  Wire.write(address);             // send register address
  Wire.write(val);                 // send value to write
  Wire.endTransmission();         // end transmission
}

// Reads num bytes starting from address register on device in to _buff array
void readFrom(byte address, int num, byte _buff[]) {
  Wire.beginTransmission(DEVICE); // start transmission to device 
  Wire.write(address);             // sends address to read from
  Wire.endTransmission();         // end transmission

  Wire.beginTransmission(DEVICE); // start transmission to device
  Wire.requestFrom(DEVICE, num);    // request 6 bytes from device

  int i = 0;
  while(Wire.available())         // device may send less than requested (abnormal)
  { 
    _buff[i] = Wire.read();    // receive a byte
    i++;
  }
  Wire.endTransmission();         // end transmission
}
