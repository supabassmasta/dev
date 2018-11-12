#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 13

Adafruit_NeoPixel strip = Adafruit_NeoPixel(300, PIN, NEO_GRB + NEO_KHZ800);

class Tri {
  public :
  int cnt;

  int offset_cnt = 128;

  int min = 0;
  int max = 255;

  int period_num = 1;
  int period_den = 4*32;

  int offset_num = 1;
  int offset_den = 4*32;
  
  // private TODO Clean
  int sub_cnt_offset = 0;
  int sub_cnt = 0;

  // constructor
  Tri() {
  }
  
  void new_show() {
    // compute offsets
    sub_cnt_offset ++;
    if (sub_cnt_offset > offset_den) {
      sub_cnt_offset = 0;
      offset_cnt += offset_num;
      
      cnt = offset_cnt;
    }
    
  }

  int process () {
    sub_cnt ++;
    if (sub_cnt > period_den) {
      sub_cnt = 0;
      cnt += period_num;

      if (cnt > 255) cnt = 0; // SAWTOOTH, TODO make Tri
    }
    
    return cnt;

  }


};

  Tri t1 = Tri();

void setup() {
  strip.begin();
  strip.setBrightness(64); // Max 255
  strip.show(); // Initialize all pixels to 'off'


}

void loop() {
  show1(); 
//  theaterChase(strip.Color(0, 127, 0), 50); // Red
}

void theaterChase(uint32_t c, uint8_t wait) {
  for (int j=0; j<10; j++) {  //do 10 cycles of chasing
    for (int q=0; q < 3; q++) {
      for (uint16_t i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, c);    //turn every third pixel on
      }
      strip.show();

      delay(wait);

      for (uint16_t i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, 0);        //turn every third pixel off
      }
    }
  }
}

void show1() {
      for (uint16_t i=0; i < strip.numPixels(); i++) {
          int g;

          g = t1.process();

          if (g<0) g = 0;
          if (g>255) g = 255;
          strip.setPixelColor(i, strip.Color(0, g, 0));
      }

      strip.show();
      
      t1.new_show();

}



