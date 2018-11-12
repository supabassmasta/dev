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
     
      if (up_offset ) {
        offset_cnt += offset_num;
      }    
      else {
        offset_cnt -= offset_num;   
      }
    }
    cnt = offset_cnt;
    sub_cnt = 0;
    up = up_start;
    
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
Tri t2 = Tri();
Tri t3 = Tri();

void setup() {
  strip.begin();
  strip.setBrightness(32); // Max 255
  strip.show(); // Initialize all pixels to 'off'

  show1_conf();

//  Serial.begin(115200);
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
void show1_conf() {
  t1.offset_cnt = 0;
  t1.min = -255;
  t1.max = 255;
  t1.period_num = 4 * 16;
  t1.period_den = 1;
  t1.offset_num = 8 * 8;
  t1.offset_den = 1;
  t1.up_start = true;

  t2.offset_cnt = 0;
  t2.min = -64;
  t2.max = 64;
  t2.period_num = 7;
  t2.period_den = 0;
  t2.offset_num = 1;
  t2.offset_den = 1;
  t2.up_start = true;

}


void show1() {
      t1.new_show();
      t2.new_show();

      for (uint16_t i=0; i < strip.numPixels(); i++) {
          int g;
          int b;
          int r;

          g = t1.process();
//          b = t2.process();
//          r = g*b ;

          if (g<0) g = 0;
          if (g>255) g = 255;
          if (b<0) b = 0;
          if (b>255) b = 255;
         if (r<0) r = 0;
          if (r>255) r = 255;

          strip.setPixelColor(i, strip.Color(r, g, b));
      }

//      Serial.println("SHOW");

      strip.show();
      


}



