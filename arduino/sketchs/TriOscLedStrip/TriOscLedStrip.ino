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
Tri t2 = Tri();
Tri t3 = Tri();
Tri t4 = Tri();
Tri t5 = Tri();

class Perc {
  public :
  int cnt = 0;
  int cnt_reload = 50;
  int cnt_dec = 1;
  int color_fact = 1;
  int max = 255;
  int pos = 0;
  int color_mask = 0x00FFFFFF;

  // constructor
  Perc() {
  }

  void process(Adafruit_NeoPixel * s_p){
    int i, j;
    int c;
    if ( cnt > 0  ){
       // up ramp
       for (i = pos - cnt, j = 0; i< pos  ; i++, j++){
          if ( i > 0 && i < s_p->numPixels() ){
            c = j * color_fact;
            if (c > max) c = max;
            strip.setPixelColor(i, color_mask & (c<<16 | c<<8 | c));
          }
       }
       for (i = pos , j = cnt; i< cnt + pos  ; i++, j--){
         if ( i > 0 && i < s_p->numPixels() ){
            c = j * color_fact;
            if (c > max) c = max;
            strip.setPixelColor(i, color_mask & (c<<16 | c<<8 | c));
         }
       }
      cnt -= cnt_dec;
    }
  }

  void reload()  {
    cnt = cnt_reload;
  }
};

Perc perc1;

void setup() {
  strip.begin();
  strip.setBrightness(64); // Max 255
  strip.show(); // Initialize all pixels to 'off'

  show1_conf();

  pinMode(LED_BUILTIN, OUTPUT);

  Serial.begin(115200);
}

void error() {
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(10);                       // wait for a second
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
}

void loop() {
//  show1(); 
//randblue();
//  randgreen();
//randall();
mult();
//blueriver();
  read_serial();
  perc1.process(&strip);
  kick();
  snare();
  strip.show();

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
  t1.period_num = 2 * 16;
  t1.period_den = 1;
  t1.offset_num = 7;
  t1.offset_den = 1;
  t1.up_start = true;    

  t2.offset_cnt = 0;
  t2.min = -24;
  t2.max = 64;
  t2.period_num = 1;
  t2.period_den = 8;
  t2.offset_num = 1;
  t2.offset_den = 3;
  t2.up_start = true;

  t3.offset_cnt = 0;
  t3.min = -6*256;
  t3.max = 64;
  t3.period_num = 10;
  t3.period_den = 0;
  t3.offset_num = 43;
  t3.offset_den = 1;
  t3.up_start = true;

  t4.offset_cnt = 0;
  t4.min = -256;
  t4.max = 64;
  t4.period_num = 7;
  t4.period_den = 0;
  t4.offset_num = 30;
  t4.offset_den = 1;
  t4.up_start = true;

  perc1.cnt_reload = 50;
  perc1.cnt_dec = 1;
  perc1.color_fact = 2;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x00000FF;
}


void show1() {
      t1.new_show();
      t2.new_show();
      t3.new_show();

      for (uint16_t i=0; i < strip.numPixels() / 6 ; i++) {
          int g;
          int b;
          int r;

          g = t1.process();
          b = t2.process();
//          r = t3.process() ;

          if (g<0) g = 0;
          if (g>255) g = 255;
          if (b<0) b = 0;
          if (b>255) b = 255;
         if (r<0) r = 0;
          if (r>255) r = 255;

          strip.setPixelColor(i, strip.Color(r, g, b));

          // SYMETRY !!!!!!!!
          strip.setPixelColor(2*strip.numPixels()/6 -  i, strip.Color(r, g, b));
          strip.setPixelColor(4*strip.numPixels()/6 + i, strip.Color(r, g, b));
          strip.setPixelColor(strip.numPixels() - i, strip.Color(r, g, b));
      }

//      Serial.println("SHOW");

      


}

int kick_cnt;
int snare_cnt;

void read_serial(){  
  byte b;
  int a;
  a = Serial.available ();
  if ( a > 0 ){
    b = Serial.read();   
    if (b == 'k') {
      kick_cnt = 30;
      //error();
    }
    else if (b == 's') {
      snare_cnt = 30;
      //error();
    }
    else if (b == 'K') {
      perc1.reload();
      //error();
    }
    else {
     error();
     Serial.flush();
    }

  }
}


void kick() {
  if (kick_cnt > 0 ) {
    kick_cnt --;

    int kick_color = kick_cnt*8;

    for (int i= 3 * strip.numPixels() >> 3; i < ( 5 * strip.numPixels() >> 3 ); i++){
       strip.setPixelColor(i, /* strip.getPixelColor(i) | */ (/*kick_color << 16  |*/ kick_color << 8 | kick_color ));
    }
  }


}


void snare() {

  if (snare_cnt > 0 ) {
    snare_cnt --;

    int snare_color = snare_cnt*8;

    for (int i= 2 * strip.numPixels() >> 3; i < ( 3 * strip.numPixels() >> 3 ); i++){
       strip.setPixelColor(i, strip.Color(snare_color,0, 0));
    }
  }


}

  int a = 346211;

void randblue() {
  int b;

  for (int i=0; i< 10 ; i++){
    a = a*413 + 537- a>>2; 
    b = a & 0x1FF;
    strip.setPixelColor(b, strip.Color( 128, 0, 0));
  }
  for (int i=0; i< 150 ; i++){
    a = a*413 + 497; 
    b = a & 0x1FF;
    strip.setPixelColor(b, strip.Color(0,0, 0));
  }


}


// Middle Square Weyl Sequence PRNG
// 16 bits implementation attempt
long x = 0, w = 0, s = 0xb5ad4ece; // sizeof long == 32 bits on Uno

int msws() {
  x *= x;
  x += (w += s);
  x = (x>>16) | (x<<16);
  return (int) x;
}


void randgreen() {
  int b;
  int c;
  int white;
  for (int i=0; i< 10 ; i++){
    b = msws();
    c = b >> 9;
    if ( (b & 0x10) && (c & 0x08) && (c & 0x01)){
      white = b >> 15;    
    }
    else {
      white = 0;
    }
   b = b & 0x1FF;
    strip.setPixelColor(b, strip.Color(0, c,white ));
  }
//  for (int i=0; i< 150 ; i++){
//    a = a*413 + 497; 
//    b = a & 0x1FF;
//    strip.setPixelColor(b, strip.Color(0,0, 0));
//  }


}
void randall() {
  int b;
  int c;
  int j, nb;
  int i = 0;
  while( i <strip.numPixels()  ){

    b = msws();
    c = msws();
    nb = c >> 11;
    for (j=i; j< nb + i  ; j++){

      strip.setPixelColor(j, strip.Color(b>>8, b & 0xFF, c & 0xFF ));
    }
    i +=nb;
  }
  //  for (int i=0; i< 150 ; i++){
  //    a = a*413 + 497; 
  //    b = a & 0x1FF;
  //    strip.setPixelColor(b, strip.Color(0,0, 0));
  //  }


}

int mi = 0;
int mj = 0;
void mult() {
  long c;
  int i;
  mj ++;

  if ( mj == 1  ){
  mi ++;
  mj =  0;
      
  }

  for (i=0; i< strip.numPixels() ; i++){
     c = mi + i;
     c = c *c;
    strip.setPixelColor(i, c);
  }

}

int di = 0;
int dj = 0;
void blueriver() {
  long c;
  int i;
//  dj ++;

//  if ( dj == 8  ){
  di ++;
//  dj =  0;
      
//  }

  for (i=0; i< strip.numPixels() / 2 ; i++){
     c = di + i;
     c = c * c;
    strip.setPixelColor(i,strip.Color(0 ,0,  c));


    //symetry
    strip.setPixelColor(strip.numPixels() - i,strip.Color(0 ,0,  c));
  }

}
