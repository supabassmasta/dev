
byte bytes[1024];

void setup()
{
  // start serial port at 9600 bps and wait for port to open:
  Serial.begin(115200);
  
  pinMode(LED_BUILTIN, OUTPUT);
}

void error() {
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);                       // wait for a second
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
}
long cksum;
void loop()
{
  //int nRead = Serial.readBytesUntil('\n', bytes, 300);
  int nRead = Serial.readBytes(bytes, 255);
  if(nRead > 0) {
    if (nRead != 255) {
       Serial.println(nRead);
       error();
    }

    /*
    Serial.println(bytes[0]);
    Serial.println(bytes[3]);       
    Serial.println(bytes[255]);
    */
       
    cksum = 0;
    for (int i = 0; i<255; i++) {
      cksum += bytes[i];
    }

    if (cksum != 32385) {
      Serial.println("KO");
      Serial.println(cksum);
      error();
    }

  }
  else {
    Serial.println(0);
    error();
  }
 //Serial.println("HELLO");
 //   delay (1000);
}
