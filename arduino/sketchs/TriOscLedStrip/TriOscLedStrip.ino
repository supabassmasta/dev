#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 13

Adafruit_NeoPixel strip = Adafruit_NeoPixel(300, PIN, NEO_GRB + NEO_KHZ800);

// Middle Square Weyl Sequence PRNG
// 16 bits implementation attempt
long x = 0, w = 0, s = 0xb5ad4ece; // sizeof long == 32 bits on Uno

int msws() {
  x *= x;
  x += (w += s);
  x = (x>>16) | (x<<16);
  return (int) x;
}


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
  int cnt_num = 1;
  int cnt_den = 1;
  int cnt_den_tmp = 0;
  int color_fact = 1;
  int max = 255;
  int pos = 0;
  long color_mask = 0x00FFFFFF;

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
            strip.setPixelColor(i, color_mask & ((long)c<<16 | c<<8 | c));
          }
       }
       // down ramp
       for (i = pos , j = cnt - 1; i< cnt + pos  ; i++, j--){
         if ( i > 0 && i < s_p->numPixels() ){
            c = j * color_fact;
            if (c > max) c = max;
            strip.setPixelColor(i, color_mask & ((long)c<<16 | c<<8 | c));
         }
       }

      cnt_den_tmp ++;
      if (cnt_den_tmp >= cnt_den) {
        cnt -= cnt_num;
        cnt_den_tmp = 0;
      }
    }
  }

  void reload()  {
    cnt = cnt_reload;
  }
};

Perc perc1;

class RandTrain {
  public :
  int pos = 150;
  long color = 0x00FFFFFF;
  int train_size = 40;
  int train_mask = 0x32A6; // lower pixel density with simple mask
  int target = 90;
  int cnt_num = 1;
  int cnt_den = 2;
  int cnt_den_tmp = 0;

  // private
  int cnt = 100;
 
  // constructor
  RandTrain() {

  }

  void process(Adafruit_NeoPixel * s_p){
    int i, j;
    int train;
    int p;
    if ( cnt < target  ){
      train = msws();
      train = train & (train_mask << (0x3 & train)); // randomly shift tain mask
//      train = train_mask;

      for (i = 0, j=0; i < train_size; i++, j++) {
        // round around train
        if ( j>= 16  ){
          j = 0;
        }

        // check pixel is active
        if ( (train >> j) & 0x1 ) {
          // pixel after pos
          p = pos + cnt + i;
          if (p < s_p->numPixels() && p < pos + target) {
            strip.setPixelColor(p, color );
          }
          // pixel before pos
          p = pos - cnt - i;
          if ( p > 0 && p > pos - target){
            strip.setPixelColor(p, color );
          }
        }

      }

      cnt_den_tmp ++;
      if (cnt_den_tmp >= cnt_den) {
        cnt += cnt_num;
        cnt_den_tmp = 0;
      }
      
    }

  }

  void reload()  {
    cnt = 0;
  }

};

RandTrain train1;

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
//allOff();
//  show1(); 
//randblue();
//  randgreen();
//randall();
//mult();
//blueriver();
//symetricmorseblue();
  rg_rainbow();
  read_serial();
  perc1.process(&strip);
  train1.process(&strip);
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

void allOff() {
  for (uint16_t i=0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, 0); 
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

  perc1.cnt_reload = 40;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFF00;
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
    else if (b == 't') {
      train1.reload();
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

int ni = 0;
int nj = 0;
void symetricmorseblue() {
  long c;
  int g = 0;
  int i;
//  nj ++;

//  if ( nj == 1  ){
  ni +=1;
//  nj =  0;
      
//  }

  for (i=0; i< strip.numPixels()/4 ; i++){
     c = ni + i;
     c = (((c>>8)&0xF) & c) *c ;
//     g = (c & 0xFF) ^ 0xFF - 199; 
    strip.setPixelColor(i,strip.Color(0 ,0, c));
    strip.setPixelColor(strip.numPixels()/2 - i,strip.Color(0 ,g, c));
    strip.setPixelColor(strip.numPixels()/2 + i,strip.Color(0 ,g, c));
    strip.setPixelColor(strip.numPixels() - i,strip.Color(0 ,0, c));
  }

}

int rg_rainbow_j = 0;

void rg_rainbow() {
  uint16_t i;
  uint32_t color;

  for(i=0; i<strip.numPixels()/2; i++) {
    color = rg_Wheel((i*1+rg_rainbow_j*2) & 255);
    strip.setPixelColor(i, color);
    // Symetry
    strip.setPixelColor(strip.numPixels()-i-1, color);
  }
  rg_rainbow_j ++;
//  if ( rg_rainbow_j > 254  ){
//    rg_rainbow_j =  0;
//  }

}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g back to r.
uint32_t rg_Wheel(byte WheelPos) {
//  WheelPos = 255 - WheelPos;
  if(WheelPos < 128) {
    return strip.Color(255 - WheelPos * 2, WheelPos * 2, 0);
  }
  
  WheelPos -= 128;
  return strip.Color(WheelPos * 2, 255 - WheelPos * 2, 0);
}