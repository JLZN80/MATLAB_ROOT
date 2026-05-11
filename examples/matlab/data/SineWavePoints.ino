/*
 SineWavePoints
 
 Write sinewave points to the serial port, followed by the Carriage Return and LineFeed terminator.
 */

int i = 0;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  // Write the sinewave points, followed by the terminator "CR" and "LF"
  Serial.print(sin(i*50.0/360.0));
  Serial.write(13);
  Serial.write(10);
  i += 1;
}
