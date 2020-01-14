#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 13

Adafruit_NeoPixel strip = Adafruit_NeoPixel(300, PIN, NEO_GRB + NEO_KHZ800);

class Tri {
  public :
  int cnt;
  bool up = true;
  bool up_start = true;

  int offset_cnt = 0;
  bool up_offset = true;

  int min = 0;
  int max = 255;

  int period_num = 6;
  int period_den = 1;

  int offset_num = 4;
  int offset_den = 1;
  
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
     
      if (offset_cnt > max) {
        up_offset = false;
      }
       if (offset_cnt < min) {
        up_offset = true;
      }

//      if (offset_num < 0){
//        up_offset = ! up_offset;
//     }

      if (up_offset ) {
        offset_cnt += offset_num;
      }    
      else {
        offset_cnt -= offset_num;   
      }
    }
    cnt = offset_cnt;
    sub_cnt = 0;
    up = up_offset;
    
  }

  int process () {
    sub_cnt ++;
    if (sub_cnt > period_den) {
      sub_cnt = 0;

      if (cnt > max) {
        cnt = max;
        up = 0;
      }
      else if (cnt < min) {
        cnt = min;
        up = 1;
      }

      if (up) {
        cnt += period_num;
      }
      else {
        cnt -= period_num;
      }
    }
    
    return cnt;

  }


};


Tri t1 = Tri();
void setup() {
  // put your setup code here, to run once:
  strip.begin();
  strip.setBrightness(255); // Max 255
  strip.show(); // Initialize all pixels to 'off'

  t1.offset_cnt = 0;
  t1.min = -128;
  t1.max = 128;
  t1.period_num = 1 * 16;
  t1.period_den = 1;
  t1.offset_num = 16;
  t1.offset_den = 1;
  t1.up_start = true;    


}

void loop() {
  // put your main code here, to run repeatedly:
       int g,r,b;
      t1.new_show();

      for (uint16_t i=0; i < strip.numPixels() / 2 ; i++) {
        g= t1.process();
        if ( g < 0  ){
           g = 0; 
        }

        b = g;
        r=g=0;
        r = b >> 1;
        strip.setPixelColor(i, strip.Color(r, g, b));
        // SYMETRY !!!!!!!!
        strip.setPixelColor(strip.numPixels() - i, strip.Color(r, g, b));
     
      }
  strip.show(); // Initialize all pixels to 'off'
}
