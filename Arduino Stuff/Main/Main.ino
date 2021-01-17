#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include <SoftwareSerial.h>

MPU6050 accelgyro;

SoftwareSerial mySerial(3, 2); // RX, TX


int16_t ax, ay, az, gx, gy, gz;

double timeStep, time, timePrev;
double arx, ary, arz, grx, gry, grz, gsx, gsy, gsz, rx, ry, rz;

int numPushups = 0;
int numSitups = 0;

int i;
double gyroScale = 131;
bool restingPos = true;
bool countingPushups = false;
bool countingSitups = false;
const int numReadings = 10;

int readingsX[numReadings];
int readingsY[numReadings];

void setup() {
  // put your setup code here, to run once:

  Wire.begin();
//  Serial.begin(9600);
  mySerial.begin(9600);
  accelgyro.initialize();

  time = millis();

  i = 1;

  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readingsX[thisReading] = 0;
    readingsY[thisReading] = 0;

  }



}

void loop() {
  // put your main code here, to run repeatedly:
      MPUCalc();

  if (countingPushups) {
    countPushup();
  }
  if (countingSitups) {
    countSitup();
  }
  if (mySerial.available()) {
    char k = mySerial.read();
//    Serial.println(k);
//    delay(10);
    if (k == 'P') {
      numPushups = 0;
      numSitups = 0;
      restingPos = true;
      countingSitups = false;
      countingPushups = true;
    }
    if (k == 'S') {
      numPushups = 0;
      numSitups = 0;
      restingPos = true;
      countingPushups = false;
      countingSitups = true;
    }
    if (k == 'F') {
      numPushups = 0;
      numSitups = 0;
      restingPos = true;
      countingPushups = false;
      countingSitups = false;

    }
  }


}





void MPUCalc() {
  timePrev = time;
  time = millis();
  timeStep = (time - timePrev) / 1000; // time-step in s

  // collect readings
  accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

  // apply gyro scale from datasheet
  gsx = gx / gyroScale;   gsy = gy / gyroScale;   gsz = gz / gyroScale;

  // calculate accelerometer angles
  arx = (180 / 3.141592) * atan(ax / sqrt(square(ay) + square(az)));
  ary = (180 / 3.141592) * atan(ay / sqrt(square(ax) + square(az)));
  arz = (180 / 3.141592) * atan(sqrt(square(ay) + square(ax)) / az);
  // set initial values equal to accel values
  if (i == 1) {
    grx = arx;
    gry = ary;
    grz = arz;
  }
  // integrate to find the gyro angle
  else {
    grx = grx + (timeStep * gsx);
    gry = gry + (timeStep * gsy);
    grz = grz + (timeStep * gsz);
  }

  // apply filter
  rx = (0.96 * arx) + (0.04 * grx);
  ry = (0.96 * ary) + (0.04 * gry);
  double sumX = 0;
  double sumY = 0;

  for (int i = 0; i < numReadings - 1; i++) {
    readingsX[i] = readingsX[i + 1];
    sumX += readingsX[i];
    readingsY[i] = readingsY[i + 1];
    sumY += readingsY[i];

  }
  readingsX[numReadings - 1] = rx;
  sumX += rx;
  readingsY[numReadings - 1] = ry;
  sumY += ry;

  rx = sumX / numReadings;
  ry = sumY / numReadings;

  // print result
  i = i + 1;
  delay(50);
}



void countPushup() {

  bool prevRestingPos = restingPos;
  if (ry < 2) {
    restingPos = true;
  }

  if (ry > 18) {
    restingPos = false;
  }



  if (!prevRestingPos && restingPos) {
    numPushups += 1;
//    Serial.println("ok");
    mySerial.write('a');
  }


}


void countSitup() {

  bool prevRestingPos = restingPos;
  if (ry < -5) {
    restingPos = true;
  }

  if (ry > 26) {
    restingPos = false;
  }



  if (prevRestingPos && !restingPos) {
    numSitups += 1;
    mySerial.write('a');
  }


}
