20::second => dur note_dur;
24 => int start_note;
84 => int last_note;


////////////////////////////////////////////////////////////////////////////////
class syntL0 extends SYNT{

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
class syntR0 extends SYNT{
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

fun void  factory0  (int release, string name){ 

  syntL0 sl; 
  syntR0 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    60 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 

////////////////////////////////////////////////////////////////////////////////
class syntL1 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.62 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.61 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   4.27 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.28 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   5.30 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.31 => det_amount[i].next;      .03 => s[i].gain; i++;   

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class syntR1 extends SYNT{
  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.61 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.59 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   4.29 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.31 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   5.28 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.29 => det_amount[i].next;      .03 => s[i].gain; i++;   




  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory1  (int release, string name){ 

  syntL1 sl; 
  syntR1 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    60 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 


////////////////////////////////////////////////////////////////////////////////
class syntL2 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -1.51 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   1.51 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   2.32 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.32 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.30 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.26 => det_amount[i].next;      .03 => s[i].gain; i++;   

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class syntR2 extends SYNT{
  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .8 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -1.52 => det_amount[i].next;      .05 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   1.50 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   2.33 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.33 => det_amount[i].next;      .05 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];   3.29 => det_amount[i].next;      .03 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.27 => det_amount[i].next;      .03 => s[i].gain; i++;   




  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory2  (int release, string name){ 

  syntL2 sl; 
  syntR2 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    60 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 

////////////////////////////////////////////////////////////////////////////////
class syntL3 extends SYNT{

    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    2 => int n;
    0 => int k;

    4 => inlet.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.58 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.42 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.46 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.45 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.46 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.45 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.24 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.23 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   


    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

  }  

class syntR3 extends SYNT{
    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    2 => int n;
    0 => int k;

    4 => inlet.gain;


inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.54 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.38 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.42 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.41 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.50 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.26 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.27 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   



  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory3  (int release, string name){ 

  syntL3 sl; 
  syntR3 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    48 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 


////////////////////////////////////////////////////////////////////////////////
class syntL4 extends SYNT{

    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    2 => int n;
    1 => int k;

    4 => inlet.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.58 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.42 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.46 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.45 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.46 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.45 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.24 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.23 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   


    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

  }  

class syntR4 extends SYNT{
    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    2 => int n;
    1 => int k;

    4 => inlet.gain;


inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.54 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.38 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.42 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.41 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.50 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.26 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.27 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   



  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory4  (int release, string name){ 

  syntL4 sl; 
  syntR4 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    48 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 


////////////////////////////////////////////////////////////////////////////////
class syntL5 extends SYNT{

    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    22 => int n;
    0 => int k;

    4 => inlet.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.58 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.42 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.46 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.45 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.46 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.45 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.24 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.23 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   


    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

  }  

class syntR5 extends SYNT{
    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    22 => int n;
    0 => int k;

    4 => inlet.gain;


inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.54 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.38 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.42 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.41 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.50 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.26 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.27 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   



  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory5  (int release, string name){ 

  syntL5 sl; 
  syntR5 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    72 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    sl =< al;
    sr =< ar;

    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 


////////////////////////////////////////////////////////////////////////////////
class syntL6 extends SYNT{

    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    22 => int n;
    1 => int k;

    4 => inlet.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.58 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.42 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.46 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.45 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.46 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.45 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.24 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.23 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   


    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

  }  

class syntR6 extends SYNT{
    9 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SERUM0 s[synt_nb]; 
    Gain final => outlet; 0.8 => final.gain;

    22 => int n;
    1 => int k;

    4 => inlet.gain;


inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;     s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.54 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.38 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.42 => det_amount[i].next;      .1 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.41 => det_amount[i].next;      .1 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.50 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.26 => det_amount[i].next;      .05 => s[i].gain; s[i].config(n, k) ; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.27 => det_amount[i].next;      .05 => s[i].gain;  s[i].config(n, k) ; i++;   



  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  factory6  (int release, string name){ 

  syntL6 sl; 
  syntR6 sr;

  if ( ! release  ){
    // TEST
    Step stp => sl => ADSR al => dac.left;
         stp => sr => ADSR ar => dac.right;
    
    72 => Std.mtof => stp.next;
    
    3::second => dur rel;
    al.set(2::second, 0::ms, 1., rel);
    ar.set(2::second, 0::ms, 1., rel);

    al.keyOn(); ar.keyOn(); 

    10::second => now;

    al.keyOff(); ar.keyOff(); 

    rel => now;
    
    sl =< al;
    sr =< ar;
    1::ms => now;
  }
  else {

    SYNTLAB syntlab;
    syntlab.go( sl, sr, start_note /* start_note */, last_note /* last_note */, note_dur /* note_dur */,  3::ms /* attack */, 3000::ms /* release */, name /* base_name */ ); 

  }
   
} 



////////////////////////////////////////////////////////////////////////

factory2 (1, "../_SAMPLES/SYNTWAVS/MULTI2SIN0");
factory0 (1, "../_SAMPLES/SYNTWAVS/MULTI2SIN1");
factory1 (1, "../_SAMPLES/SYNTWAVS/MULTI2SIN2");

factory3 (1, "../_SAMPLES/SYNTWAVS/MULTI2GROAN0");
factory4 (1, "../_SAMPLES/SYNTWAVS/MULTI2GROAN1");

factory5 (1, "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH0");
factory6 (1, "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH1");
