class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1538" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

class STREC extends ST {
  Gain in[2];
  Gain dummy[2];
  Gain out[2];
  out[0] => outl;
  out[1] => outr;

  in => out;

  fun void f1 ( dur d, string name, dur sync_dur){ 
    // sync
    if (sync_dur == 0::ms)  {
      // sync on full seq
      d - ((now - data.wait_before_start)%d) => now;
    }
    else {
      sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
    }

    <<<"********************">>>; 
    <<<"********************">>>; 
    <<<"***   REC       ****">>>; 
    <<<"********************">>>; 
    <<<"********************">>>; 

    in => dummy => WvOut2 w => blackhole;
    name => w.wavFilename;

    d => now ;

    <<<"********************">>>; 
    <<<"********************">>>; 
    <<<"***  END  REC   ****">>>; 
    <<<"********************">>>; 
    <<<"********************">>>; 

    w =< blackhole;
//    in[0] =< dummy[0];
//    in[1] =< dummy[1];
//    w =< out;
//    in =< w; 

    1::ms => now;

  } 


  fun void connect(ST @ tone, dur d, string name,  dur sync_dur ) {
    tone.left() => in[0];
    tone.right() => in[1];

    spork ~ f1 (d, name, sync_dur);

  }

}

STREC strec;
strec.connect(last $ ST, 8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); strec $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
