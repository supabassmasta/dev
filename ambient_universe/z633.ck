class syntL extends SYNT{
  inlet => SqrOsc s =>  outlet; 
  .5 => s.gain;

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class syntR extends SYNT{
  inlet => TriOsc s =>  outlet; 
  .5 => s.gain;

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

syntL sl; syntR sr;

SYNTLAB syntlab;
syntlab.go( sl, sr, 48 /* start_note */, 49 /* last_note */, 3000::ms /* note_dur */,  1000::ms /* attack */, 1000::ms /* release */, "../_SAMPLES/ambient_universe/SYNTTEST" /* base_name */ ); 
