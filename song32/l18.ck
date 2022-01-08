class KIK extends SYNT{

    // inlet 
  Step stp0 =>  Envelope fe =>  SinOsc sin0 =>  Envelope ge => outlet; 
  1.0 => stp0.next;
  0.0 => ge.value;
  1.0 => sin0.gain;
  
  float initSinPhase;
  float initfe;
  float initfg;

  float freqValue [0];
  dur freqDur [0];
  float gainValue [0];
  dur gainDur [0];

  fun void  addFreqPoint (float f, dur d){ 
     freqValue << f;
     freqDur << d;
  } 


  fun void  config  (float p, float ife, float ifg){ 
    p => initSinPhase;
    ife => initfe;
    ifg => initfg;
  } 

  

   fun void  trig_freq  (){ 
    initfe => fe.value;

    for (0 => int i; i <  freqValue.size() ; i++) {
      freqValue[i] =>  fe.target;
      freqDur[i] => fe.duration  => now;
    }
     
     
  } 
 
  fun void  trig_env  (){ 
//    <<<"TRIG">>>;

    initSinPhase => sin0.phase;

    // Attack
    initfg => ge.value;

    0.6 => ge.target;
    2::ms  => fe.duration  => now;

    0.3 => ge.target;
    10::ms  => fe.duration  => now;
    1.0 => ge.target;
    10::ms  => fe.duration  => now;

    // Rest
    171::ms => now;

    // Release
    0.0 => ge.target;
    4::ms => fe.duration  => now;


  }

  //fun void on()  { }  fun void off() { }  
  
  fun void new_note(int idx)  {
        spork ~ trig_freq();
        spork ~ trig_env();
  }
  
  1 => own_adsr;
} 

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.7 /* init Sin Phase */, 76 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0 , 10::ms);
kik.addFreqPoint (100.0 , 20::ms);
kik.addFreqPoint (35.0 , 17 * 10::ms);
//    233.0 => fe.target;
//    10::ms => fe.duration  => now;
//    100.0 => fe.target;
//    20::ms => fe.duration  => now;
//
//    35.0 => fe.target;
//    17 * 10::ms => fe.duration  => now;
 
 t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  !1" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
