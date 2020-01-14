#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 13

Adafruit_NeoPixel strip = Adafruit_NeoPixel(120, PIN, NEO_GRB + NEO_KHZ800);

// Middle Square Weyl Sequence PRNG
// 16 bits implementation attempt
long x = 0, w = 0, s = 0xb5ad4ece; // sizeof long == 32 bits on Uno

int msws() {
  x *= x;
  x += (w += s);
  x = (x>>16) | (x<<16);
  return (int) x;
}



int preset = 15;

void setup() {
  preset = 15;
  strip.begin();
  strip.setBrightness(255); // Max 255
  strip.show(); // Initialize all pixels to 'off'

  init_colors();
  init_colorRamps();
  init_kaleidoscope();
}

uint16_t gcnt = 0;

void loop() {

  if (gcnt < 3) {
    circle_flash();
  }
  else if (gcnt < 4) {
    circle_loop(8);
  }
  else if (  gcnt <  900 ){
     rainbow(); 
  }
  else if (  gcnt <  902 ){
    reverse_circle_loop(16);
  }
  else if (  gcnt <  2000 ){
    colorRamp();
    kaleidoscope();
  }
  else if (  gcnt <  2001 ){
    reverse_circle_loop(6);
  }
  else {
    gcnt = 0;   
  }

  gcnt ++;

  strip.show();

}


// COLORS
#define NB_COLORS  6

long colors[NB_COLORS];

void init_colors() {
  int i = 0;
  //  red  green blue
  colors[i] = strip.Color ( 255,   0,   0);   i++;
  colors[i] = strip.Color (   0, 255,   0);   i++;
  colors[i] = strip.Color (   0,   0, 255);   i++;
  colors[i] = strip.Color ( 128, 128,   0);   i++;
  colors[i] = strip.Color (   0, 128, 128);   i++;
  colors[i] = strip.Color ( 128,   0, 128);   i++;

}




void circle_flash(){

  int d = 100;
  int j = 0;

  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
  for (int i=0; i< 120 ; i++){ strip.setPixelColor(i, colors[j]); } strip.show(); delay(d); j++;
}


void circle_loop(int ray_size){
  int i, j, k;
  
  allOff();

  for (i=0; i< NB_COLORS ; i++){
      for (j=0; j <  strip.numPixels() ; j++){
         for (k=0; k< ray_size ; k++){
             strip.setPixelColor(j+k, colors[i]); 
         }
         if ( j> 0  ){
             strip.setPixelColor(j-1, 0); 
         }
      strip.show();
    } 
  }

}

void reverse_circle_loop(int ray_size){
  int i, j, k;

  allOff();
  
  
  for (i=0; i< NB_COLORS ; i++){
      for (j=0; j <  strip.numPixels() + 2 ; j++){
         for (k=0; k< ray_size ; k++){
             strip.setPixelColor(strip.numPixels()-j-k, colors[i]); 
         }
         if ( j> 0  ){
             strip.setPixelColor(strip.numPixels()-j+1, 0); 
         }
      strip.show();
    } 
  }

}



void allOff() {
  for (uint16_t i=0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, 0); 
  }
}





uint16_t rainbow_idx = 0;

void rainbow() {
  uint16_t i;
  uint32_t color;

    for(i=0; i<strip.numPixels(); i++) {
      color = Wheel((i*1+rainbow_idx*1) & 255);
      strip.setPixelColor(i, color);
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

#define CRAMP_RED_NB 2
colorRampElt cramp_r[CRAMP_RED_NB];

#define CRAMP_GREEN_NB 2
colorRampElt cramp_g[CRAMP_GREEN_NB];

#define CRAMP_BLUE_NB 2
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

  ////////////// GREEN //////////////////
  idx = 0;
  cramp_g[idx].target = -128;
  cramp_g[idx].step = -4;
  idx++;

  cramp_g[idx].target = 32;
  cramp_g[idx].step = 4;
  idx++;

  ////////////// BLUE //////////////////
  idx = 0;


  cramp_b[idx].target = 56;
  cramp_b[idx].step = 1;
  idx++;

  cramp_b[idx].target = -64;
  cramp_b[idx].step = -3;
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
