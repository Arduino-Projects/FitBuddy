#include <SoftwareSerial.h>

SoftwareSerial mySerial(3, 2); // RX, TX

void setup()
{
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Native USB only
  }


  Serial.println("Goodnight moon!");

  // set the data rate for the SoftwareSerial port
  mySerial.begin(9600);
  mySerial.println("AT");
}

void loop() // run over and over
{
  if (mySerial.available())
    mySerial.write(mySerial.read());

  
}
