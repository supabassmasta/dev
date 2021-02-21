class syntL extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.51 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   2.51 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.32 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.32 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   4.30 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.26 => det_amount[i].next;      .03 => s[i].gain; i++;   

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class syntR extends SYNT{
  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.52 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   2.50 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.33 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.33 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   4.29 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.27 => det_amount[i].next;      .03 => s[i].gain; i++;   




  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

syntL sl; syntR sr;

SYNTLAB syntlab;
syntlab.go( sl, sr, 60 /* start_note */, 72 /* last_note */, 20::second /* note_dur */,  1000::ms /* attack */, 1000::ms /* release */, "../_SAMPLES/ambient_universe/SYNTTEST" /* base_name */ ); 
