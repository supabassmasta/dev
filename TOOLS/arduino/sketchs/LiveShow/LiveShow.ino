#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 13

Adafruit_NeoPixel strip = Adafruit_NeoPixel(300, PIN, NEO_GRB + NEO_KHZ800);

uint16_t intro_cnt = 0;

#define MOON_START 138
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
Perc perc2;
Perc perc3;
Perc perc4;
Perc perc5;

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
  int cnt = 1000;
 
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
RandTrain train2;

class RainbowStar {
  public :
  int pos = 150;
  int size = 40;
  int target = 90;
  int cnt_num = 1;
  int cnt_den = 2;
  int cnt_den_tmp = 0;

  // private
  int cnt = 1000;
 
  // constructor
  RainbowStar() {

  }

#define RAINBOW_START_SIZE 3

  void process(Adafruit_NeoPixel * s_p){
    int i, j;
    int p;
    if ( cnt < abs( target - pos )  ){

      if ( pos < target  ){
        // Print Star
        p = pos + cnt;

        for (i=0; i< RAINBOW_START_SIZE ; i++){
          strip.setPixelColor(p, 0x00FFFFFF );
          p--;
        }

        while( p >= 0 && p >= pos && p >= pos + cnt - size  ){
          strip.setPixelColor(p, Wheel(cnt + intro_cnt) );
          p--;
        }
      }

      if ( pos > target  ){
        // Print Star
        p = pos - cnt;

        for (i=0; i< RAINBOW_START_SIZE ; i++){
          strip.setPixelColor(p, 0x00FFFFFF );
          p++;
        }

        while( p < strip.numPixels() && p <= pos && p < pos - cnt + size  ){
          strip.setPixelColor(p, Wheel(cnt + intro_cnt) );
          p++;
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
RainbowStar rainbowStar1;
RainbowStar rainbowStar2;
RainbowStar rainbowStar3;
RainbowStar rainbowStar4;


class Fade_in_out {
  public:
    bool in = true;
    int cnt = 0;
    int cnt_num = 1;
    int cnt_den = 1;
    int cnt_den_tmp = 0;
    // constructor
    fade_in_out() {

    }

    void process(Adafruit_NeoPixel * s_p){
      int i;
      uint32_t c;
      int r;
      int g;
      int b;

      if (in && cnt > 0) {
        for (i=0; i< s_p->numPixels() ; i++){
          c =  strip.getPixelColor(i);
          r = (((c >> 16)       ) - cnt );
          g = (((c >> 8) & 0xFF ) - cnt );
          b = (((c     ) & 0xFF ) - cnt );
          if ( r < 0  ) r = 0;
          if ( g < 0  ) g = 0;
          if ( b < 0  ) b = 0;
          c = r << 16 | g << 8 | b ;
          strip.setPixelColor(i,c);
        }
        cnt_den_tmp ++;
        if (cnt_den_tmp >= cnt_den) {
          cnt -= cnt_num;
          cnt_den_tmp = 0;
        }

      }
      else if (  !in && cnt < 255  ){
        for (i=0; i< s_p->numPixels() ; i++){
          c =  strip.getPixelColor(i);
          r = (((c >> 16)       ) - cnt );
          g = (((c >> 8) & 0xFF ) - cnt );
          b = (((c     ) & 0xFF ) - cnt );
          if ( r < 0  ) r = 0;
          if ( g < 0  ) g = 0;
          if ( b < 0  ) b = 0;
          c = r << 16 | g << 8 | b ;
          strip.setPixelColor(i,c);
        }
        cnt_den_tmp ++;
        if (cnt_den_tmp >= cnt_den) {
          cnt += cnt_num;
          cnt_den_tmp = 0;
        }

      }
      else if (  !in  ){
        for (i=0; i< s_p->numPixels() ; i++){
          strip.setPixelColor(i,0);
        }
      }
    }

  void start_in(){
    in = true;
    cnt = 255;
  }

  void start_out(){
    in = false;
    cnt = 0;
  }
  

};
Fade_in_out fade_in_out;

int preset = 0;

void setup() {
  
  strip.begin();
  strip.setBrightness(255); // Max 255
  strip.show(); // Initialize all pixels to 'off'


  // Kaleido HACK ////////////////////////
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      
      init_colorRamps();
      init_kaleidoscope();

      preset = 11;
//////////////////////////////////////
      
  pinMode(LED_BUILTIN, OUTPUT);

  Serial.begin(115200);
  Serial.flush(); 
}

void error() {
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(10);                       // wait for a second
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
}

int bond_cnt = 0;
int bond_cnt2 = 0;

void loop() {
  read_serial();
  switch (preset) {
    case 0:
      allOff(); 
    break;
    case 1:
      blueriver();
    break;
    case 2:
      rg_rainbow();
      aya_randgreen();
    break;
    case 3:
      symetricmorseblue();
    break;
    case 4:
      randgreen();
    break;
    case 5:
      ederlezi(); 
    break;
    case 6:
      symetricmorseorange();
    break;
    case 7:
      rainbow();
      // greenblueriver();
    break;
    case 8:
      int r;

      allOff();
      
//      symetricmorsered();
      bond_cnt ++;
      if ( bond_cnt > 60 +train1.target /* (r & 0x7F ) */){
        bond_cnt = 0;

        r = msws();
        train1.pos = 86 + (r & 0x7F);
        train1.target = 35 + ((r>>8) & 0x3F);;
        long l = (long)(msws()<<16 | r ); 
        train1.color =  l;
//        train1.color = 0xFFFF0000; 
        train1.reload();
      }
      /*
      
      bond_cnt2 ++;
      if ( bond_cnt2 > 160 +train2.target ){
        bond_cnt2 = 0;

        r = msws();
        train2.pos = 86 + (r & 0x7F);
        train2.target = 35 + ((r>>8) & 0x0F);;
        train2.color = 0x00FFFFFF & (long)(r<<16 | r ); 


        train2.reload();
      }
      */
    break;
    case 9:
      randyellow();
    break;
    case 10:
      intro_stars();
    break;

    case 11:
      dhoomtala();
    randyellow();
    break;

    case 12:
      inawah_fire(true);
      moon();
      delay(5);
    break;
    case 13:
      allOff();
      randyellow();
      moon();
      // update this counter to keep moon oscillating
      intro_cnt ++;
    break;
    case 14:
      inawah_fire(false);
      moon();
      delay(5);
    break;
    case 15:
      earth();
      delay(10);
    break;




  }


//allOff();
//  show1(); 
//randblue();
//  randgreen();
//randall();
//mult();
//blueriver();
//symetricmorseblue();
//  rg_rainbow();
  perc1.process(&strip);
  perc2.process(&strip);
  perc3.process(&strip);
  perc4.process(&strip);
  train1.process(&strip);
  train2.process(&strip);
  rainbowStar1.process(&strip);
  rainbowStar2.process(&strip);
  rainbowStar3.process(&strip);
  rainbowStar4.process(&strip);
  kick();
  snare();
  fade_in_out.process(&strip);
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

class Star {
  public :
  uint8_t r,g,b;
  uint16_t arrival;
  uint16_t pos;
  Star() {
  }
};

#define STARS_NB 32
Star st[STARS_NB];


void init_stars (){ 
  uint8_t idx = 0;

  st[idx].r = 255 ;
  st[idx].g = 255 ;
  st[idx].b = 255;
  st[idx].arrival =  255 ;
  st[idx].pos =  150 ;
  idx++;
  st[idx].r = 0 ;
  st[idx].g = 0 ;
  st[idx].b = 20;
  st[idx].arrival =  255 ;
  st[idx].pos =  149 ;
  idx++;
  st[idx].r = 0 ;
  st[idx].g = 0 ;
  st[idx].b = 20;
  st[idx].arrival =  255 ;
  st[idx].pos =  151 ;
  idx++;

  st[idx].r = 100 ;
  st[idx].g = 100 ;
  st[idx].b = 255 ;
  st[idx].arrival =  1000 ;
  st[idx].pos =  273 ;
  idx++;

  st[idx].r = 240 ;
  st[idx].g = 240 ;
  st[idx].b = 100 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  63 ;
  idx++;

  st[idx].r = 255 ;
  st[idx].g = 100 ;
  st[idx].b = 100 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  0 ;
  idx++;

  st[idx].r = 200 ;
  st[idx].g = 75 ;
  st[idx].b = 75 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  200 ;
  idx++;

  st[idx].r = 100 ;
  st[idx].g = 100 ;
  st[idx].b = 100 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  295 ;
  idx++;

  st[idx].r = 100 ;
  st[idx].g = 75 ;
  st[idx].b = 110 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  130 ;
  idx++;

  st[idx].r = 150 ;
  st[idx].g = 150 ;
  st[idx].b = 75 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  230 ;
  idx++;

  st[idx].r = 50 ;
  st[idx].g = 50 ;
  st[idx].b = 200;
  st[idx].arrival =  255 ;
  st[idx].pos =  35 ;
  idx++;
  
  st[idx].r = 50 ;
  st[idx].g = 50 ;
  st[idx].b = 50 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  80 ;
  idx++;
  
  st[idx].r = 20 ;
  st[idx].g = 10 ;
  st[idx].b = 0 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  12 ;
  idx++;
 st[idx].r = 20 ;
  st[idx].g = 10 ;
  st[idx].b = 0 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  137 ;
  idx++;
 st[idx].r = 20 ;
  st[idx].g = 10 ;
  st[idx].b = 0 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  203 ;
  idx++;
 st[idx].r = 20 ;
  st[idx].g = 15 ;
  st[idx].b = 0 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  207 ;
  idx++;
   st[idx].r = 20 ;
  st[idx].g = 10 ;
  st[idx].b = 0 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  287 ;
  idx++;

 st[idx].r = 1 ;
  st[idx].g = 2 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  100 ;
  idx++;
st[idx].r = 1 ;
  st[idx].g = 3 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  110 ;
  idx++;
st[idx].r = 1 ;
  st[idx].g = 2 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  173 ;
  idx++;
st[idx].r = 1 ;
  st[idx].g = 2 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  257 ;
  idx++;
st[idx].r = 1 ;
  st[idx].g = 2 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  66 ;
  idx++;
  st[idx].r = 1 ;
  st[idx].g = 2 ;
  st[idx].b = 5 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  53 ;
  idx++;

  st[idx].r = 2 ;
  st[idx].g = 2 ;
  st[idx].b = 2 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  237 ;
  idx++;
st[idx].r = 3 ;
  st[idx].g = 2 ;
  st[idx].b = 2 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  240 ;
  idx++;
  st[idx].r = 2 ;
  st[idx].g = 1 ;
  st[idx].b = 3 ;
  st[idx].arrival =  255 ;
  st[idx].pos =  247 ;
  idx++;


} 
    

uint16_t fade_stars_sub_cnt = 0;

void intro_stars() {
  uint8_t r,g,b = 0;
  uint16_t fade_stars_cnt;
  uint16_t fade_red_cnt;
  uint16_t fade_blue_cnt;

  fade_stars_sub_cnt ++;
  if (intro_cnt < 254 && fade_stars_sub_cnt > 15  ){

    fade_stars_sub_cnt = 0;
    
    fade_stars_cnt = 255 - intro_cnt;

    for (int i=0; i<  STARS_NB ; i++){
      strip.setPixelColor(st[i].pos, st[i].r / fade_stars_cnt, st[i].g / fade_stars_cnt, st[i].b / fade_stars_cnt); 
    }

    intro_cnt ++;
  }
  else if ( intro_cnt >= 254 && intro_cnt < 3000) {
    // Stars No fade in
    for (int i=0; i<  STARS_NB ; i++){
      strip.setPixelColor(st[i].pos, st[i].r , st[i].g , st[i].b ); 
    }

    // Red  
    fade_red_cnt = (intro_cnt - 254) >> 4;
    if (fade_red_cnt > 151 ) fade_red_cnt = 151;
    for ( int i = 0; i <  fade_red_cnt; i++) {
      r = fade_red_cnt - i;
      strip.setPixelColor(i, r, 0, 0 ); 
      strip.setPixelColor(strip.numPixels() - i, r, 0, 0 ); 
    }
    intro_cnt ++;
     
  }
  else if ( intro_cnt >= 3000) {
     // Red  
//    fade_red_cnt = (intro_cnt - 254) >> 2;
//    if (fade_red_cnt > 151 ) fade_red_cnt = 151;

      // Blue
      fade_blue_cnt = (intro_cnt - 3000) >> 4;
      if (fade_blue_cnt > 300 ) fade_blue_cnt = 300;
    for ( int i = 0; i <  151; i++) {
      int16_t b16;
      int16_t r16;

      r16 = 151 - i - (fade_blue_cnt >> 1 ) ;
      if (r16 < 0) r = 0;
      else  if ( r16 > 255  )  r = 255; 
      else  r = r16;     
      
      b16 =  fade_blue_cnt  + i - 150  ; 

      if (b16 < 0) b = 0;
      else  if ( b16 > 255  )  b = 255; 
      else  b = b16;     
      

      strip.setPixelColor(i, r, 0, b ); 
      // symetry
      strip.setPixelColor(strip.numPixels() - i, r, 0 , b); 
    }
    intro_cnt ++;
     
  }

}


void inawah_fire(bool up) {    
  uint16_t fade_red_cnt;
  int16_t r;

  // Red  
  fade_red_cnt = (intro_cnt ) >> 6;
  if (fade_red_cnt > 151 ) fade_red_cnt = 151;
  for ( int i = 0; i <  MOON_START; i++) {
    if ( up  ){
      r = fade_red_cnt - i;
    } else {
      r = (151 - fade_red_cnt) - i;
    }
    if ( r < 0 ){
      r = 0;    
    }
    strip.setPixelColor(i, r, 0, 0 ); 
    strip.setPixelColor(strip.numPixels() - i, r, 0, 0 ); 
  }

  // Rand orange yellow
  {
    uint16_t r;
    uint16_t g;
    for (int i=0; i< 5 ; i++){

      r = msws();
      g = r >> 10;
      r = r & 0x7F ;
      if (  ( up && r < fade_red_cnt )
         || (!up &&  r < (151 - fade_red_cnt) ) ) 
      {
        strip.setPixelColor(r, strip.Color(255, g, 0 ));
        strip.setPixelColor(strip.numPixels() - r, strip.Color(255, g, 0 ));
      }
    }
  }

  // Trains
  {
    uint16_t r;
    bond_cnt ++;
    if ( bond_cnt > 60 +train1.target /* (r & 0x7F ) */){
      bond_cnt = 0;

      r = msws();
      if (  r & 0x1  ){
        train1.pos = 0;
      }
      else {
        train1.pos = strip.numPixels() - 10;
      }
      train1.target = 85 + ((r>>6) & 0x3F);
      train1.color =  0x00FF7000;
      train1.train_size = ((r>>8) & 0x1F);
      train1.train_mask = r & 0x1632; 
      //train1.color = 0xFFFF0000; 
      train1.reload();
    }

  }

  intro_cnt ++;
}

void moon() {
  int8_t g;
  uint8_t v, u;

  v = intro_cnt & 0xFF;
  if ( v > 128  ){
      v = 256 - v;
  }
  u = intro_cnt >> 1 & 0xFF;
  if ( u > 128  ){
      u = 256 - u;
  }
  
  for (int i=MOON_START ; i< strip.numPixels() - MOON_START + 1 ; i++){
     strip.setPixelColor(i, strip.Color(255, 127 + v, 127 + u  )); 
  }
}

void ederlezi_config() {
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
  t3.min = -256;
  t3.max = 16;
  t3.period_num = 4;
  t3.period_den = 1;
  t3.offset_num = 6;
  t3.offset_den = 1;
  t3.up_start = true;

  t4.offset_cnt = 0;
  t4.min = -512;
  t4.max = 16;
  t4.period_num = 4;
  t4.period_den = 1;
  t4.offset_num = 4;
  t4.offset_den = 1;
  t4.up_start = true;

  perc1.cnt_reload = 45;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;

  perc2.cnt_reload = 40;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x0FFFF00;

  perc3.cnt_reload = 40;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x0FFFF00;

}


void ederlezi() {
      t1.new_show();
      t2.new_show();
      t3.new_show();
      t4.new_show();

      for (uint16_t i=0; i < strip.numPixels() / 2 ; i++) {
          int g;
          int b;
          int r, r2;

          g = t1.process();
          b = t2.process();
          
          r = t3.process() + b  + g + 64;
          if (r<0) r = 0;
          if (r>255) r = 255;

          r2 = t4.process() ;
          if (r2<0) r2 = 0;
          if (r2>255) r2 = 255;

          r = r + r2;
          if (r<0) r = 0;
          if (r>255) r = 255;



          if (g<0) g = 0;
          if (g>255) g = 255;
          if (b<0) b = 0;
          if (b>255) b = 255;
         if (r<0) r = 0;
          if (r>255) r = 255;

          strip.setPixelColor(i, strip.Color(r, g, b));

          // SYMETRY !!!!!!!!
          strip.setPixelColor(strip.numPixels() - i, strip.Color(r, g, b));
      }

//      Serial.println("SHOW");

      


}

void config_intro_tempura() {
  perc1.cnt_reload = 45;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;

  train1.pos = strip.numPixels() / 2;
  train1.color = 0x0000FFFF;
  train1.train_size = 40;
  train1.train_mask = 0x32A6; // lower pixel density with simple mask
  train1.target = 120;
  train1.cnt_num = 1;
  train1.cnt_den = 2;
  train1.cnt_den_tmp = 0;

  perc2.cnt_reload = 40;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x0FFFF00;

  perc3.cnt_reload = 40;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x0FFFF00;

  train2.pos = 0;
  train2.color = 0x0000FF1F;
  train2.train_size = 80;
  train2.train_mask = 0x32A6; // lower pixel density with simple mask
  train2.target = strip.numPixels();
  train2.cnt_num = 1;
  train2.cnt_den = 2;
  train2.cnt_den_tmp = 0;

}

void config_ayawuaska() {
  perc1.cnt_reload = 20;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x000FFFF;
}

void config_indian_kid() {
  perc1.cnt_reload = 45;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;

  train1.pos = strip.numPixels() / 2;
  train1.color = 0x0000FFFF;
  train1.train_size = 40;
  train1.train_mask = 0x32A6; // lower pixel density with simple mask
  train1.target = 120;
  train1.cnt_num = 1;
  train1.cnt_den = 2;
  train1.cnt_den_tmp = 0;

  perc2.cnt_reload = 40;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x0FF00FF;

  perc3.cnt_reload = 40;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x0FF00FF;

}

void config_costa() {
  perc1.cnt_reload = 45;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;


  perc2.cnt_reload = 40;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x0FFFF00;

  perc3.cnt_reload = 20;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x0FF0F00;

  perc4.cnt_reload = 20;
  perc4.cnt_num = 1;      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_out();

  perc4.cnt_den = 1;
  perc4.color_fact = 15;
  perc4.max = 255;
  perc4.pos = strip.numPixels() * 7 / 8;
  perc4.color_mask = 0x00FFF00;

  train1.pos = strip.numPixels() / 2;
  train1.color = 0x0000FFFF;
  train1.train_size = 25;
  train1.train_mask = 0x0086; // lower pixel density with simple mask
  train1.target = 120;
  train1.cnt_num = 1;
  train1.cnt_den = 1;
  train1.cnt_den_tmp = 0;

  train2.pos = 0;
  train2.color = 0x0000FF1F;
  train2.train_size = 80;
  train2.train_mask = 0x32A6; // lower pixel density with simple mask
  train2.target = strip.numPixels();
  train2.cnt_num = 1;
  train2.cnt_den = 2;
  train2.cnt_den_tmp = 0;

}

void config_mantra(){
  perc1.cnt_reload = 30;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;

  perc2.cnt_reload = 30;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x000FF00;

  perc3.cnt_reload = 30;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x000FF00;
}

void config_bondlywood() {

  train1.pos = strip.numPixels() / 2;
  train1.color = 0x000000FF;
  train1.train_size = 70;
  train1.train_mask = 0x32A6; // lower pixel density with simple mask
  train1.target = 150;
  train1.cnt_num = 1;
  train1.cnt_den = 2;
  train1.cnt_den_tmp = 0;

  train2.pos = strip.numPixels() / 2;
  train2.color = 0x000000FF;
  train2.train_size = 70;
  train2.train_mask = 0x32A6; // lower pixel density with simple mask
  train2.target = 150;
  train2.cnt_num = 1;
  train2.cnt_den = 2;
  train2.cnt_den_tmp = 0;

  perc1.cnt_reload = 30;
  perc1.cnt_num = 1;
  perc1.cnt_den = 1;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FFFFFF;

  perc2.cnt_reload = 30;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x000FF;

  perc3.cnt_reload = 30;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x000FF;
}
void config_kudunbao() {

  train1.pos = strip.numPixels() / 2;
  train1.color = 0x000000FF;
  train1.train_size = 70;
  train1.train_mask = 0x32A6; // lower pixel density with simple mask
  train1.target = 150;
  train1.cnt_num = 1;
  train1.cnt_den = 2;
  train1.cnt_den_tmp = 0;

  perc1.cnt_reload = 60;
  perc1.cnt_num = 5;
  perc1.cnt_den = 2;
  perc1.color_fact = 15;
  perc1.max = 255;
  perc1.pos = strip.numPixels() / 2;
  perc1.color_mask = 0x0FF0000;

  perc2.cnt_reload = 30;
  perc2.cnt_num = 1;
  perc2.cnt_den = 1;
  perc2.color_fact = 15;
  perc2.max = 255;
  perc2.pos = strip.numPixels() / 4;
  perc2.color_mask = 0x000FF;

  perc3.cnt_reload = 30;
  perc3.cnt_num = 1;
  perc3.cnt_den = 1;
  perc3.color_fact = 15;
  perc3.max = 255;
  perc3.pos = strip.numPixels() * 3 / 4;
  perc3.color_mask = 0x000FF;
}


void config_inawah_part_1() {
  train1.pos = 0;
  train1.color = 0x00FFF000;
  train1.train_size = 60;
  train1.train_mask = 0x1002; // lower pixel density with simple mask
  train1.target = 120;
  train1.cnt_num = 1;
  train1.cnt_den = 2;
  train1.cnt_den_tmp = 0;

  intro_cnt = 0;
  bond_cnt = 0;
}

void config_inawah_part_2() {
rainbowStar1.pos = strip.numPixels() - MOON_START + 1;
rainbowStar1.size = 30;
rainbowStar1.target = 300;
rainbowStar1.cnt_num = 3;
rainbowStar1.cnt_den = 1;
rainbowStar1.cnt_den_tmp = 0;

rainbowStar2.pos = strip.numPixels() - MOON_START + 1;
rainbowStar2.size = 30;
rainbowStar2.target = 300;
rainbowStar2.cnt_num = 3;
rainbowStar2.cnt_den = 1;
rainbowStar2.cnt_den_tmp = 0;

rainbowStar3.pos = MOON_START - 1;
rainbowStar3.size = 30;
rainbowStar3.target = 0;
rainbowStar3.cnt_num = 3;
rainbowStar3.cnt_den = 1;
rainbowStar3.cnt_den_tmp = 0;

rainbowStar4.pos = MOON_START - 1;
rainbowStar4.size = 30;
rainbowStar4.target = 0;
rainbowStar4.cnt_num = 3;
rainbowStar4.cnt_den = 1;
rainbowStar4.cnt_den_tmp = 0;
}

int kick_cnt;
int snare_cnt;

void read_serial(){  
  byte b;
  int a;
  int valid = 0;

  valid = 0;
  
  a = Serial.available ();
  if ( a > 0 ){
    b = Serial.read();   

    // manage presets
    if (b == '0') {
      preset = 0;
     valid = 1;
    }
    else if (b == '&') {
      init_stars ();
      intro_cnt = 0;
      fade_stars_sub_cnt = 0;

      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 10;
      valid = 1;
    }
    else if (b == '1') {
      config_intro_tempura();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 1;
      valid = 1;
    }
    else if (b == '2') {
      config_ayawuaska();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 2;
      valid = 1;
    }
    else if (b == '3') {
      config_indian_kid();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 3;
      valid = 1;
    }
    else if (b == '4') {
      config_costa();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 4;
      valid = 1;
    }
    else if (b == '5') {
      ederlezi_config();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 5;
      valid = 1;
    }
    else if (b == '6') {
      config_mantra();
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 6;
      valid = 1;
    }
    else if (b == '7') {
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      preset = 7;
      valid = 1;
    }
    // MISSION BONDLLYWOOD
    else if (b == '8') {
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      config_bondlywood();
      preset = 8;
      valid = 1;
    }
    // KUDUMBAO
    else if (b == '9') {
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      config_kudunbao();
      preset = 9;
      valid = 1;
    }
    // DHOOMTALA CHILL
    else if (b == 'A') {
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();
      
      init_colorRamps();
      init_kaleidoscope();

      preset = 11;
      valid = 1;
    }
    // Inawah
    else if (b == 'B') {
      fade_in_out.cnt_num = 12;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_in();

      config_inawah_part_1();
      
      preset = 12;
      valid = 1;
    }
    else if (b == 'C') {

      config_inawah_part_2();
      
      preset = 13;
      valid = 1;
    }
    else if (b == 'D') {
      config_inawah_part_1();      
      preset = 14;
      valid = 1;
    }
    else if (b == 'E') {
      preset = 15;
      valid = 1;
    }
    else if (b == '!') {
      fade_in_out.cnt_num = 8;
      fade_in_out.cnt_den = 1;
      fade_in_out.start_out();
      valid = 1;
    }


    switch (preset) {

      case 0:
        if (b == 'k') {
          train1.reload();
          valid = 1;
        }
        break;
        /////////// INTRO TEMPURA ////////////////////////
      case 1:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'l' ){
          train1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        else if ( b == 'n' ){
          train2.reload();
          valid = 1;
        }
        break;

        /////////// AYAWUASKA ////////////////////////
      case 2:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        break;
        /////////// INDIAN KID ////////////////////////
      case 3:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'l' ){
          train1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        break;
        /////////// COSTA ////////////////////////
      case 4:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'l' ){
          perc2.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc3.reload();
          valid = 1;
        }
        else if ( b == 'n' ){
          perc4.reload();
          valid = 1;
        }
        else if ( b == 'o' ){
          train1.reload();
          valid = 1;
        }
        break;
        /////////// EDERLEZI ////////////////////////
      case 5:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        break;
        /////////// MANTRA ////////////////////////
      case 6:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        break;
        /////////// MISSION BONDLYWOOD ////////////////////////
      case 8:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        break;
        /////////// KUDUMBAO ////////////////////////
      case 9:
        if (b == 'k') {
          perc1.reload();
          valid = 1;
        }
        else if ( b == 'm' ){
          perc2.reload();
          perc3.reload();
          valid = 1;
        }
        break;
        /////////// INAWAH Part 2 ////////////////////////
      case 13:
        if (b == 'k') {
          rainbowStar1.reload();
          valid = 1;
        }
        if (b == 'l') {
          rainbowStar2.reload();
          valid = 1;
        }

        if (b == 'm') {
          rainbowStar3.reload();
          valid = 1;
        }

        if (b == 'n') {
          rainbowStar4.reload();
          valid = 1;
        }

        if (b == 'o') {
          // Thunder

          perc1.cnt_reload = 30;
          perc1.cnt_num = 1;
          perc1.cnt_den = 1;
          perc1.color_fact = 15;
          perc1.max = 150;
          perc1.pos = 200;
          perc1.color_mask = 0x07FFFFF;

          perc2.cnt_reload = 20;
          perc2.cnt_num = 1;
          perc2.cnt_den = 2;
          perc2.color_fact = 15;
          perc2.max = 150;
          perc2.pos = 120;
          perc2.color_mask = 0x07FFFFF;

          train1.pos = strip.numPixels() / 2;
          train1.color = 0x003F3F3F;
          train1.train_size = 60;
          train1.train_mask = 0x32A6; // lower pixel density with simple mask
          train1.target = 150;
          train1.cnt_num = 2;
          train1.cnt_den = 1;
          train1.cnt_den_tmp = 0;

          perc1.reload();      
          perc2.reload();
          train1.reload();

          valid = 1;
        }
        break;

        /*

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
         */
    }

    if ( !valid  ){
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
void randyellow() {
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
   b = b & 0x1FF;
    strip.setPixelColor(b, strip.Color(c, c,white ));
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
void greenblueriver() {
  long c;
  int g;
  int i;
//  dj ++;

//  if ( dj == 8  ){
  di ++;
//  dj =  0;
      
//  }

  for (i=0; i< strip.numPixels() / 2 ; i++){
     c = di + i;
     c = c * c;
//     if ( c > 128  ){
//      g = 128;
//        
//    }
//    else {
      g = c;   
//    }
   strip.setPixelColor(i,strip.Color(0 ,g,  c));

    //symetry
    strip.setPixelColor(strip.numPixels() - i,strip.Color(0 ,g,  c));
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

void symetricmorseorange() {
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
     g = (c & 0xFF) - 128; 
     if ( g < 0  ){
         g = 0;
     }
    strip.setPixelColor(i,strip.Color(c ,g, 0));
    strip.setPixelColor(strip.numPixels()/2 - i,strip.Color(c ,g,0));
    strip.setPixelColor(strip.numPixels()/2 + i,strip.Color(c ,g, 0));
    strip.setPixelColor(strip.numPixels() - i,strip.Color(c ,g, 0));
  }

}

void symetricmorsered() {
  long c;
  int g = 0;
  int i;
//  nj ++;

//  if ( nj == 1  ){
  ni -=1;
//  nj =  0;
      
//  }

  for (i=0; i< strip.numPixels()/4 ; i++){
     c = ni + i;
     c = (((c>>8)&0xF) & c) *c ;
    strip.setPixelColor(i,strip.Color(c ,0, 0));
    strip.setPixelColor(strip.numPixels()/2 - i - 1,strip.Color(c ,0,0));
    strip.setPixelColor(strip.numPixels()/2 + i ,strip.Color(c ,0, 0));
    strip.setPixelColor(strip.numPixels() - i -1,strip.Color(c ,0, 0));
  }

}

int rg_rainbow_j = 0;

void rg_rainbow() {
  uint16_t i;
  uint32_t color;

  for(i=0; i<strip.numPixels()/4; i++) {
    color = rg_Wheel((i*1+rg_rainbow_j*2) & 255);
    strip.setPixelColor(i + strip.numPixels()/4, color);
    // Symetry
    strip.setPixelColor(3 * strip.numPixels() / 4 -i-1, color);
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

void aya_randgreen() {
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
   b = b & 0x7F;
    strip.setPixelColor(b, strip.Color(0, c,white ));
    strip.setPixelColor(strip.numPixels() - b, strip.Color(0, c,white ));
  }
//  for (int i=0; i< 150 ; i++){
//    a = a*413 + 497; 
//    b = a & 0x1FF;
//    strip.setPixelColor(b, strip.Color(0,0, 0));
//  }


}


uint16_t rainbow_idx = 0;

void rainbow() {
  uint16_t i;
  uint32_t color;

    for(i=0; i<strip.numPixels()/2; i++) {
      color = Wheel((i*1+rainbow_idx*1) & 255);
      strip.setPixelColor(i, color);
      // Symetry
      strip.setPixelColor(strip.numPixels()-i-1, color);
    }
    
    rainbow_idx ++;
    if ( rainbow_idx > 255  ){
        rainbow_idx = 0;
    }
}
// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}

class colorRampElt {
  public:
  int16_t target;
  int8_t step;
  colorRampElt() {
  }
};

#define CRAMP_RED_NB 6
colorRampElt cramp_r[CRAMP_RED_NB];

#define CRAMP_GREEN_NB 6
colorRampElt cramp_g[CRAMP_GREEN_NB];

#define CRAMP_BLUE_NB 6
colorRampElt cramp_b[CRAMP_BLUE_NB];

void init_colorRamps() {
  uint8_t idx = 0;

  ////////////// RED //////////////////
  idx = 0;
  cramp_r[idx].target = 32;
  cramp_r[idx].step = 16;
  idx++;
  
  cramp_r[idx].target = -128;
  cramp_r[idx].step = -16;
  idx++;

  cramp_r[idx].target = 24;
  cramp_r[idx].step = 12;
  idx++;

  cramp_r[idx].target = -32;
  cramp_r[idx].step = -2;
  idx++;

  cramp_r[idx].target = 6;
  cramp_r[idx].step = 1;
  idx++;

  cramp_r[idx].target = -128;
  cramp_r[idx].step = -1;
  idx++;

  ////////////// GREEN //////////////////
  idx = 0;
  cramp_g[idx].target = -128;
  cramp_g[idx].step = -4;
  idx++;

  cramp_g[idx].target = 32;
  cramp_g[idx].step = 4;
  idx++;

  cramp_g[idx].target = -53;
  cramp_g[idx].step = -5;
  idx++;

  cramp_g[idx].target = 19;
  cramp_g[idx].step = 13;
  idx++;

  cramp_g[idx].target = 6;
  cramp_g[idx].step = 1;
  idx++;

  cramp_g[idx].target = -128;
  cramp_g[idx].step = -1;
  idx++;
  ////////////// BLUE //////////////////
  idx = 0;

  cramp_b[idx].target = -128;
  cramp_b[idx].step = -1;
  idx++;

  cramp_b[idx].target = 90;
  cramp_b[idx].step = 1;
  idx++;

  cramp_b[idx].target = -56;
  cramp_b[idx].step = -3;
  idx++;

  cramp_b[idx].target = 72;
  cramp_b[idx].step = 1;
  idx++;

  cramp_b[idx].target = 6;
  cramp_b[idx].step = 1;
  idx++;

  cramp_b[idx].target = -128;
  cramp_b[idx].step = -1;
  idx++;





}

uint8_t cramp_start = 0;
uint16_t cramp_sub_cnt = 0;

void colorRamp() {
  uint8_t led_i;
  uint8_t cramp_index_r = 0;
  int16_t cur_r;
  uint8_t r;
  uint8_t cramp_index_g = 0;
  int16_t cur_g;
  uint8_t g;
  uint8_t cramp_index_b = 0;
  int16_t cur_b;
  uint8_t b;

  led_i = cramp_start;
  // first element of Cramp is the init value
  r = cur_r = cramp_r[cramp_index_r].target;
  if ( cur_r < 0) r = 0;  if ( cur_r > 255) r = 255;

  g = cur_g = cramp_g[cramp_index_g].target;
  if ( cur_g < 0) g = 0;  if ( cur_g > 255) g = 255;

  b = cur_b = cramp_b[cramp_index_b].target;
  if ( cur_b < 0) b = 0;  if ( cur_b > 255) b = 255;

  strip.setPixelColor(led_i, r, g, b);

  led_i ++; if ( led_i >  strip.numPixels() / 2 ) led_i = 0;
  cramp_index_r++; if (cramp_index_r > CRAMP_BLUE_NB - 1  ) cramp_index_r = 0; 
  cramp_index_g++; if (cramp_index_g > CRAMP_BLUE_NB - 1  ) cramp_index_g = 0; 
  cramp_index_b++; if (cramp_index_b > CRAMP_BLUE_NB - 1  ) cramp_index_b = 0; 

  while (led_i != cramp_start) {

    r = cur_r = cur_r + cramp_r[cramp_index_r].step;
    if ( cur_r < 0) r = 0;  if ( cur_r > 255) r = 255;

    g = cur_g = cur_g + cramp_g[cramp_index_g].step;
    if ( cur_g < 0) g = 0;  if ( cur_g > 255) g = 255;
    
    b = cur_b = cur_b + cramp_b[cramp_index_b].step;
    if ( cur_b < 0) b = 0;  if ( cur_b > 255) b = 255;
    
    strip.setPixelColor(led_i, r, g, b);


    led_i ++; if ( led_i >  strip.numPixels() / 2 ) led_i = 0;
    if (   ( cramp_r[cramp_index_r].step < 0 && cur_r <  cramp_r[cramp_index_r].target )
        || ( cramp_r[cramp_index_r].step > 0 && cur_r >  cramp_r[cramp_index_r].target )  ){

      cramp_index_r++; if (cramp_index_r > CRAMP_BLUE_NB - 1  ) cramp_index_r = 0; 
    }

    if (   ( cramp_g[cramp_index_g].step < 0 && cur_g <  cramp_g[cramp_index_g].target )
        || ( cramp_g[cramp_index_g].step > 0 && cur_g >  cramp_g[cramp_index_g].target )  ){

      cramp_index_g++; if (cramp_index_g > CRAMP_BLUE_NB - 1  ) cramp_index_g = 0; 
    }

    if (   ( cramp_b[cramp_index_b].step < 0 && cur_b <  cramp_b[cramp_index_b].target )
        || ( cramp_b[cramp_index_b].step > 0 && cur_b >  cramp_b[cramp_index_b].target )  ){

      cramp_index_b++; if (cramp_index_b > CRAMP_BLUE_NB - 1  ) cramp_index_b = 0; 
    }

    /// MOVE
    cramp_sub_cnt ++;
    if ( cramp_sub_cnt > 200  ){
      cramp_sub_cnt = 0;
      cramp_start ++;
      if ( cramp_start >   strip.numPixels() / 2 ){
          cramp_start = 0;
      }
    }



  }
}

class kaleidoElt {
  public:
  uint8_t type; // 0: 0 to up, 1: end to down, 2: reverse, 3 : oposite
  uint8_t pix;
  uint8_t offset;
  kaleidoElt() {
  }
};

#define KALEIDO_NB_ELTS 8
kaleidoElt kaleidoElts[KALEIDO_NB_ELTS];
kaleidoElt * kaleidoElts_reord[KALEIDO_NB_ELTS];

uint16_t kal_sub_cnt = 0xFFF0;

void init_kaleidoscope(){

  /// /!\ WARNING : At least one type 0 needed !!!!!!

  uint8_t idx = 0;
  kaleidoElts[idx].type = 0;
  kaleidoElts[idx].pix = 0;
  kaleidoElts[idx].offset = -1;
  idx ++;

  kaleidoElts[idx].type = 0;
  kaleidoElts[idx].pix = 3 *strip.numPixels() / 8;
  kaleidoElts[idx].offset = 2;
  idx ++;

  kaleidoElts[idx].type = 0;
  kaleidoElts[idx].pix = strip.numPixels() / 2;
  kaleidoElts[idx].offset = -3;
  idx ++;

  kaleidoElts[idx].type = 1;
  kaleidoElts[idx].pix = strip.numPixels() / 4;
  kaleidoElts[idx].offset = 1;
  idx ++;

  kaleidoElts[idx].type = 1;
  kaleidoElts[idx].pix = strip.numPixels() / 8;
  kaleidoElts[idx].offset = -2;
  idx ++;

  kaleidoElts[idx].type = 1;
  kaleidoElts[idx].pix = 3 *strip.numPixels() / 8;
  kaleidoElts[idx].offset = 3;
  idx ++;

  kaleidoElts[idx].type = 1;
  kaleidoElts[idx].pix = strip.numPixels() / 2;
  kaleidoElts[idx].offset = -1;
  idx ++;

  kaleidoElts[idx].type = 1;
  kaleidoElts[idx].pix = strip.numPixels() / 2;
  kaleidoElts[idx].offset = 1;
  idx ++;

  // init sub cnt high to enter the "move" section on first call
  kal_sub_cnt = 0xFFF0 ;

}


// use first half strip to build 2nd half
// Then copy second half to the 1st
void kaleidoscope(){
  int16_t source_pix;
  uint16_t target_pix;
  uint16_t first_pix;
  uint8_t i, j;
  uint8_t elt_found ;
  uint8_t elt_cur ;
  uint8_t max;
  uint8_t up;


  // move (Note: kal_sub_cnt must be high enough to enter this on first call)
  kal_sub_cnt ++;

  if (kal_sub_cnt > 20) {
    int16_t new_pix;

    kal_sub_cnt = 0;

    // find first elt type 0 to start
    max = 255;
    i = 0;
    elt_found = 255;
    while( i < KALEIDO_NB_ELTS ){
      if (kaleidoElts[i].type == 0 && kaleidoElts[i].pix < max ){
        elt_found = i;
        max = kaleidoElts[i].pix;
      }
      i++;
    }

    if (elt_found == 255) {
      // No index found
      return;
    }

    first_pix = target_pix = kaleidoElts[elt_found].pix;

    // reorder elts
    i = first_pix + 1; if ( i > strip.numPixels() / 2 ) i = 0;
    kaleidoElts_reord[0] = & kaleidoElts[elt_found];
    elt_found = 1;
    while( i != first_pix ){
      for (j=0; j < KALEIDO_NB_ELTS; j++){
        if ( kaleidoElts[j].pix == i ){
          kaleidoElts_reord[elt_found] = & kaleidoElts[j];
          elt_found++;
        }
      }
      i++;  if ( i > strip.numPixels() / 2 ) i = 0;
    }

    i = 0;
    while( i < KALEIDO_NB_ELTS ){
      if (kaleidoElts[i].offset > 0) {
        new_pix = kaleidoElts[i].pix + kaleidoElts[i].offset;
        if ( new_pix > strip.numPixels() / 2  ){
          kaleidoElts[i].pix = 0;
        }
        else {
          kaleidoElts[i].pix = new_pix;
        }
      }
      else  if (kaleidoElts[i].offset < 0) {
        new_pix = kaleidoElts[i].pix + kaleidoElts[i].offset;
        if ( new_pix < 0  ){
          kaleidoElts[i].pix = strip.numPixels() / 2 - 1;
        }
        else {
          kaleidoElts[i].pix = new_pix;
        }
      }
      i++;
    }


  }


  // STEP First Pix before loop
  first_pix = target_pix  = kaleidoElts_reord[0]->pix;
  up = 1;
  strip.setPixelColor(strip.numPixels() / 2 + target_pix, strip.getPixelColor(0));
  // update target pix to enter the loop
  target_pix++; if ( target_pix > strip.numPixels() / 2 ) target_pix = 0;
  source_pix = 1;

  elt_cur = 0;
  while (target_pix != first_pix) {

    switch ( kaleidoElts_reord[elt_cur]->type ) {
      case 0:
        source_pix ++; if (source_pix > strip.numPixels() / 2 ) source_pix = 0;
        break;
      case 1:
        source_pix --; if (source_pix < 0) source_pix = strip.numPixels() / 2 - 1;
        break;
      case 2:
          if ( up  ) {
            source_pix ++; if (source_pix > strip.numPixels() / 2 ) source_pix = 0;
          }
          else {
            source_pix --; if (source_pix < 0) source_pix = strip.numPixels() / 2 - 1;
          }
        break;
    }

    strip.setPixelColor(strip.numPixels() / 2 + target_pix, strip.getPixelColor(source_pix));

    // check next element
    while( elt_cur + 1 < KALEIDO_NB_ELTS && kaleidoElts_reord[elt_cur + 1]->pix == target_pix ){
      elt_cur = elt_cur + 1;

      // Update source pix if needed
      switch ( kaleidoElts_reord[elt_cur]->type ) {
        case 0:
          source_pix = 0;
          up = 1;
          break;
        case 1:
          source_pix = strip.numPixels() / 2 - 1;
          up = 0;
          break;
        case 2:
          // don't change source pix
          // Change directrion
          if ( up  ) { up = 0; }
          else {up = 1; }

          break;
      }


    }

    target_pix++; if ( target_pix > strip.numPixels() / 2 ) target_pix = 0;
  }

  // Symetry
  for (i=0; i< strip.numPixels() / 2 ; i++){
     strip.setPixelColor(i, strip.getPixelColor(strip.numPixels() - i - 1)); 
  }

}

void dhoomtala() {
  colorRamp();
  
  kaleidoscope();

}

uint16_t earth_idx=0;
void earth() {
  uint16_t j = earth_idx;
  bool blue;
  for (int i = 0; i < strip.numPixels()      ; i++) {

    if ( i < 40  )  blue = 1;
    else if ( i < 38) blue = 0;
    else if ( i < 98) blue = 1;
    else if ( i < 103) blue = 0;
    else if ( i < 120) blue = 1;
    else if ( i < 129) blue = 0;
    else if ( i < 171) blue = 1;
    else if ( i < 196) blue = 0;
    else if ( i < 216) blue = 1;
    else if ( i < 248) blue = 0;
    else if ( i < 279) blue = 1;
    else if ( i < 284) blue = 0;
    else  blue = 1;
        
   if ( blue  ){
      strip.setPixelColor(j, 0, 0, 200);
   }
   else {
      strip.setPixelColor(j, 0, 200, 0);
   }

    j ++;
    if ( j > strip.numPixels()  ){
       j = 0; 
    }
  }

  earth_idx ++;
  if ( earth_idx > strip.numPixels()  ){
    earth_idx = 0;
  }
}

