#include <Arduino.h>
#include <Adafruit_DotStar.h>
#include <SPI.h>

#define LED_DATA_PIN  13
#define LED_CLOCK_PIN 11
#define NUM_LEDS 70

Adafruit_DotStar strip = Adafruit_DotStar(NUM_LEDS,
  LED_DATA_PIN, LED_CLOCK_PIN, DOTSTAR_GBR);

void setup() {
  strip.begin(); // Allocate DotStar buffer, init SPI
  strip.setBrightness(64);
  strip.clear(); // Make sure strip is clear
  strip.show();  // before measuring battery
  
}

int i = 0;
int j = 70;

void loop() {
strip.setPixelColor(i, 0x00, 0xFF, 0x00);
strip.setPixelColor(i + 17, 0x00, 0xFF, 0x00);
strip.setPixelColor(i + 35, 0x00, 0xFF, 0x00);
strip.setPixelColor(i + 58, 0x00, 0xFF, 0x00);

strip.setPixelColor(j , 0x00, 0x00, 0xFF);
strip.setPixelColor(j - 35 , 0x00, 0x00, 0xFF);

strip.show();
//delay(100);

strip.setPixelColor(i, 0x00, 0x00, 0x00);
strip.setPixelColor(i + 17, 0x00, 0x00, 0x00);
strip.setPixelColor(i + 35, 0x00, 0x00, 0x00);
strip.setPixelColor(i + 58, 0x00, 0x00, 0x00);

strip.setPixelColor(j , 0x00, 0x00, 0x00);
strip.setPixelColor(j - 35 , 0x00, 0x00, 0x00);

i++;
j = j - 2;
if ( i > NUM_LEDS / 4  + 5 ){ i=0; j = 70; }


}

