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


48 => int start_note;
49 => int last_note;

3000::ms => dur note_dur;

1000::ms => dur attack;
1000::ms => dur release;

"../_SAMPLES/ambient_universe/SYNTTEST" => string base_name;

// INPUT
ST stin;

Step freq => syntL sL => stin.outl;
     freq => syntR sR => stin.outr;


stin $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(attack /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  release /* release */);
////stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 


STREC strec;
1 => int first;
for (start_note=> int i; i <  last_note + 1  ; i++) {

  Std.mtof(i) => freq.next;
  1::samp => now;

  stadsr.keyOn();

  if ( first  ){
    strec.connect(last $ ST, note_dur, base_name + i + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  
    0 => first;
  }
  else {
    strec.rec(note_dur, base_name + i + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  
  }

  note_dur - release => now; 
  stadsr.keyOff();

  release => now;

}

<<<">>>>>>>>>>>>>>>>>>>>>>>">>>;
<<<">>  END REC SESSION  >>">>>;
<<<">>>>>>>>>>>>>>>>>>>>>>>">>>;
 10::ms => now;



