#include <SPI.h>
void setup() {
  Serial.begin(9600);
  SPI.begin();
  SPI.setClockDivider(SPI_CLOCK_DIV4);
  SPI.setBitOrder(MSBFIRST);
  SPI.setDataMode(SPI_MODE0);
  pinMode(8,INPUT);
}
void loop() {
  Serial.print("0x");
  Serial.print(SPI.transfer(0),HEX);
  Serial.print(" (");
  Serial.print(digitalRead(8));
  Serial.println(")");
}
