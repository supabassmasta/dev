#include <Arduino.h>
#include <Adafruit_DotStar.h>
#include <SPI.h>

#define LED_DATA_PIN  13
#define LED_CLOCK_PIN 11
#define NUM_LEDS 70

Adafruit_DotStar strip = Adafruit_DotStar(NUM_LEDS,
  LED_DATA_PIN, LED_CLOCK_PIN, DOTSTAR_GBR);

// Middle Square Weyl Sequence PRNG
// 16 bits implementation attempt
long x = 0, w = 0, s = 0xb5ad4ece; // sizeof long == 32 bits on Uno

int msws() {
  x *= x;
  x += (w += s);
  x = (x>>16) | (x<<16);
  return (int) x;
}


void setup() {
  strip.begin(); // Allocate DotStar buffer, init SPI
  strip.setBrightness(32);
  strip.clear(); // Make sure strip is clear
  strip.show();  // before measuring battery
  
}
void randgreen() {
  int b;
  int c;
  int white;
  for (int i=0; i< 5 ; i++){
    b = msws();
    c = b >> 9;
    if ( (b & 0x10) && (c & 0x08) && (c & 0x01)){
      white = b >> 15;    
    }
    else {
      white = 0;
    }
   b = b & 0x3F;
    strip.setPixelColor(b, strip.Color(0, c,white ));
  }
//  for (int i=0; i< 150 ; i++){
//    a = a*413 + 497; 
//    b = a & 0x1FF;
//    strip.setPixelColor(b, strip.Color(0,0, 0));
//  }


}

int di = 0;
int dj = 0;
void blueriver() {
  long c, d;
  int i;
  dj += 1;
  d = dj >> 3;
 d = (d * d) & 0x7F;
 if ( d > NUM_LEDS  ){ d = NUM_LEDS; }

  di ++;

  for (i=0; i< d  ; i++){
     c = di + i;
     c = c * c;
    strip.setPixelColor(i,strip.Color(0 ,0,  c));

  }

}


void loop() {

blueriver();
//randgreen();

strip.show();
//delay(100);



}
