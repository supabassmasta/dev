10 => int mixer;

20::ms => dur local_delay;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.2 /* init Sin Phase */, 21 * 100 /* init freq env */, 0.9 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 10 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .40 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");

class SERUM_WT0 extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;

  1 => w.sync;
  1 => w.interpolate;
  //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
  //[-1.0,  1] @=> float myTable[];
  float myTable[0];

  SndBuf s => blackhole;
  


//   saw_wt_name + ".wav" => s.read;
"../_SAMPLES/wavetable/perso/psybass0.wav" => s.read;

    0 => int start;

    for (start => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 1 * 0.01 =>p.phase; } 1 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////


fun void BASS1 (string seq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(SERUM_WT0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


  t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  0.65 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              //t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 59 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.015 /* Relative Attack */, 38*  .01/* Relative Decay */, 0.38 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,47 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  //STOVERDRIVE stod;
  //stod.connect(last $ ST, 70 * 0.010 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
  //1.4 => stod.gain;

  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff();

  //STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  //stlpfx0.connect(last $ ST ,  stlpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  //STDUCK duck;
  //duck.connect(last $ ST);      duck $ ST @=>  last; 
28::samp => dur convrevin_dur;
// IR generation examples:
//KIK kik;
//kik.config(0.4 /* init Sin Phase */,76 * 100 /* init freq env */, 0.4 /* init gain env */);
//kik.addFreqPoint (188, 20::samp);
//kik.addFreqPoint (.0, convrevin_dur -25::samp );
//kik.addGainPoint (0.2, 20::samp); 
//kik.addGainPoint (0.0, convrevin_dur -25::samp ); 
//kik.outlet => Gain ir;
//kik.new_note(0);

SndBuf n => LPF lpf =>  PowerADSR padsr => Gain  ir;
padsr.set(1::samp, convrevin_dur, .000007 , 2::ms);
padsr.setCurves(.6, .1, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 

"../_SAMPLES/noise_ref.wav" => n.read;
//41 => n.pos;
144 => n.pos;
//4543 => n.pos;
//<<<"N SAMPLES:", n.samples()>>>;

95 *10 => lpf.freq;
0.14 => padsr.gain;
padsr.keyOn();

//STCONVREVIN stconvrevin;
//stconvrevin.connect(last $ ST , ir/*UGen Input Reponse*/ , convrevin_dur /*rev_dur*/, 1.0 /* rev gain */  , 0.0 /* dry gain */  );  stconvrevin   $ ST @=>  last;


  STADSR stadsr;
  stadsr.set(1::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////
float wt_table[0];
fun void  prepare_WT  (){ 
    1::second => dur wt_dur;

    Step stp0 =>  Envelope e0 =>  SinOsc sin0 => blackhole; 
    1.0 => sin0.gain;

    1.0 => stp0.next;
    110.0 => e0.value;
    6.7 => e0.target;
    wt_dur * 2 / 8 => e0.duration ;// => now;
    6.7 => e0.value;
    1.5 => e0.target;
    wt_dur * 6  / 8 => e0.duration ;// => now;

    now => time start;
    while (now < start + wt_dur) {
      wt_table << sin0.last();
      1::samp => now;
    }

} 
prepare_WT();


class SERUM_WT1 extends SYNT{

  inlet => Gain factor => Phasor p => Gain g0 =>SinOsc curve => Wavetable w =>  outlet; 
  SinOsc sin1 => OFFSET ofs0 =>   g0; 
  1. => ofs0.offset;
  0.05 => ofs0.gain;

  0.8 => sin1.freq;
  1. => sin1.gain;

  1.0 => g0.gain; 
  .2 => p.gain; 
  1 => curve.sync; // phase sync

  .5 => w.gain;
  .5 => factor.gain;

//  1. => p.gain;

  1 => w.sync;
  1 => w.interpolate;
  //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
  //[-1.0,  1] @=> float myTable[];

    w.setTable (wt_table);

  fun void on()  {0 * 0.00 =>p.phase; 0 => sin1.phase; }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0 (string seq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(SERUM_WT1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  1.75 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              t.set_adsrs(2::ms, 10::ms, 1., 2::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


//  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
//  stsynclpfx0.freq(25 * 10 /* Base */, 59 * 10 /* Variable */, 1.0 /* Q */);
//  stsynclpfx0.adsr_set(.015 /* Relative Attack */, 38*  .01/* Relative Decay */, 0.38 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
//  stsynclpfx0.nio.padsr.setCurves(1.0,47 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
//  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  //STOVERDRIVE stod;
  //stod.connect(last $ ST, 70 * 0.010 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
  //1.4 => stod.gain;

  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff();

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 330.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 
//28::samp => dur convrevin_dur;
// IR generation examples:
//KIK kik;
//kik.config(0.4 /* init Sin Phase */,76 * 100 /* init freq env */, 0.4 /* init gain env */);
//kik.addFreqPoint (188, 20::samp);
//kik.addFreqPoint (.0, convrevin_dur -25::samp );
//kik.addGainPoint (0.2, 20::samp); 
//kik.addGainPoint (0.0, convrevin_dur -25::samp ); 
//kik.outlet => Gain ir;
//kik.new_note(0);


//  STADSR stadsr;
//  stadsr.set(1::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
//  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
///////////////////////////////////////////////////////////////////////////////////////////
fun void BASS0_ATTACK(string seq, float r, float g) {
  local_delay => now;

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
// SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
  "../_SAMPLES/wavetable/perso/psybassAttack0.wav" => s.wav["a"];
  seq => s.seq;
  g * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('a') != -1 ){
//    s.gain("S", .08); // for single wav 
    r => s.wav_o["a"].wav0.rate;
  }
   // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 5. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////////


fun void TRANCEHH(string seq) {
  local_delay => now;

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  1.9 * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('S') != -1 ){
    s.gain("S", .08); // for single wav 
    0.8 => s.wav_o["S"].wav0.rate;
  }
  if(seq.find('s') != -1 ){
    s.gain("s", .8); // for single wav 
    0.65 => s.wav_o["s"].wav0.rate;
  }
  if(seq.find('h') != -1 ){
    s.gain("h", 2.4); // for single wav 
    0.85 => s.wav_o["h"].wav0.rate;
  }
   // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 5. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////

fun void  test_convrev_delay  (){ 
   <<<"!!!!!! TEST_CONVREV_DELAY !!!!!">>>;

  ST st;
  Step s => st.mono_in;

  // Direct out
  STGAIN stgain;
  stgain.connect(st $ ST , 1. /* static gain */  );    

  // REV 
  STCONVREV stconvrev;
  stconvrev.connect(st , 15/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .5 /* rev gain */  , 0. /* dry gain */  );    

  .3 => s.next;
  1::ms => now;
  0 => s.next;

   while(1) {
          100::ms => now;
   }
    
} 
//test_convrev_delay  ();


fun void  test_convrev_delay_2  (){ 
   <<<"!!!!!! TEST_CONVREV_DELAY_2 !!!!!">>>;

  ST st;
  Step s => st.mono_in;

  // Direct out
  STGAIN stgain;
  stgain.connect(st $ ST , 1. /* static gain */  );    

133::ms => dur convrevin_dur;
// IR generation examples:
KIK kik;
kik.config(0.4 /* init Sin Phase */, 76 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (188, 1 * 10::ms);
kik.addFreqPoint (.0, convrevin_dur -10::ms);
kik.addGainPoint (0.2, 1 * 10::ms); 
kik.addGainPoint (0.0, convrevin_dur -10::ms); 
kik.outlet => Gain ir;
kik.new_note(0);

//Noise n => LPF lpf => Envelope e0 =>   ir;
//821 => lpf.freq;
//8 * 0.01 => e0.value;
//0.0 => e0.target;
//convrevin_dur => e0.duration ;// => now;

STCONVREVIN stconvrevin;
stconvrevin.connect(st , ir/*UGen Input Reponse*/ , convrevin_dur /*rev_dur*/, .1 /* rev gain */  , 0.0 /* dry gain */  );     

convrevin_dur + 10::ms => now;
  .3 => s.next;
  1::ms => now;
  0 => s.next;

   while(1) {
          100::ms => now;
   }
    
} 
//test_convrev_delay_2 ();

   fun void TRIBAL_CUSTOM(string seq, int tomix, float g) {
     local_delay => now;
   
     SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
   
     SET_WAV.TRIBALR(s);
//     s.wav["M"] => s.wav["a"];  // act @=> s.action["a"]; 
//     s.wav["M"] => s.wav["b"];  // act @=> s.action["a"]; 
   
     // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
     seq => s.seq;
     g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
     s.no_sync();// s.element_sync(); //s.no_sync()
                 //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
                 // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
                 //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
//     if(seq.find('a') != -1 ){
//       1.2=> s.wav_o["a"].wav0.rate;
//     }
//     if(seq.find('b') != -1 ){
//       1.4=> s.wav_o["b"].wav0.rate;
//     }
     s.go();     s $ ST @=> ST @ last; 
   
     if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
     }
   
     1::samp => now; // let seq() be sporked to compute length
     s.s.duration => now;
   }


 class synt2 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
 } 

   fun void SYNTFROG (string seq, dur gldur, dur d, int tomix, float v) {
     local_delay => now;
   
     TONE t;
     t.reg(synt2 s0);  //data.tick * 8 => t.max; 
     gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
     //t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
     t.set_scale(data.scale.my_string);
     // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
     seq => t.seq;
     v * data.master_gain => t.gain;
     //t.sync(4*data.tick);// t.element_sync();// 
     t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
     // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
     //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
     //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
     t.go();   t $ ST @=> ST @ last; 
   
      if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
     }
     d => now;
   
   }
   class syntcomb extends SYNT{
   
       inlet => SawOsc s =>  outlet; 
         .5 => s.gain;
   
           fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { .4 => s.phase;} 0 => own_adsr;
   } 
   
   fun void  COMB  (string seq, dur comb_dur, float comb_res, int tomix,  float g){ 
     local_delay => now;
      
      TONE t;
      t.reg(syntcomb s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
      t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
      // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
      seq => t.seq;
      .9 * data.master_gain => t.gain;
      //t.sync(4*data.tick);// t.element_sync();//
      t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
      // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
      t.set_adsrs(3::ms, 3::ms, .0002, 4::ms);
      t.set_adsrs_curves(0.8, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
      1 => t.set_disconnect_mode;
      t.go();   t $ ST @=> ST @ last; 
   
   STECHO ech;
   ech.connect(last $ ST , comb_dur , comb_res);  ech $ ST @=>  last; 
   
   //STFLANGER ech;
   //ech.connect(last $ ST); ech $ ST @=>  last; 
   //ech.add_line(0 /* 0 : left, 1: right 2: both */, comb_res /* delay line gain */,  comb_dur /* dur base */, 1::ms /* dur range */, 1 /* freq */); 
   
   //"FEDCBA0 1234567 89abcde fghijkl mnop"=> string filternotes;
   //" MLKJIHGFEDCBA0123456789a "=> string notes;
   "MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnop "=> string notes;
   //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnop"=> string notes;
   
    
   //"6"=> string notes;
   RAND.char(notes, 16)=> string filternotes;
   //"M" + filternotes => filternotes;
   //"}c}c M/NN/OO/PP/aa/BB/CC/ff/M" => filternotes;
   
   
   10::ms => dur gl;
   
   
     STFREEFILTERX stfreeresx0; RES_XFACTORY stfreeresx0_fact;
     stfreeresx0.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx0 $ ST @=>  last; 
     AUTO.freqglide("*4 " + filternotes, gl) => stfreeresx0.freq; // CONNECT THIS 8
     
     STFREEFILTERX stfreeresx1;
     stfreeresx1.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx1 $ ST @=>  last; 
     AUTO.freqglide("*4}c" + filternotes, gl) => stfreeresx1.freq; // CONNECT THIS 8
     
     STFREEFILTERX stfreeresx2;
     stfreeresx2.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx2 $ ST @=>  last; 
     AUTO.freqglide("*4}c}c" + filternotes, gl)  => stfreeresx2.freq; // CONNECT THIS 8
     
     STGAIN stgain;
     stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
     stgain.connect(stfreeresx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
     stgain.connect(stfreeresx1 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   
   STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
   stlpfx0.connect(last $ ST ,  stlpfx0_fact, 153 * 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
   
   STLIMITER stlimiter;
   1. => float in_gainl;
   stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
   
   g => stlimiter.gain;
   
   
   //STLHPFC lhpfc;
   //lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 
   
   
     if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
     }
   
     1::samp => now;
     t.s.duration => now;
   
   } 

   fun void  SPECTR (int note, int nfile, float loopStart, float loopEnd, float pitchShift, int robotize, int whisperize,float spectralBlur,float spectralGate,dur att, dur rel, dur d, int tomix, float v){ 
   
     ST stmonoin; stmonoin $ ST @=> ST @ last;
   
     STADSR stadsr;
     stadsr.set(att /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */,0.0/* Sustain dur of Relative release pos (float) */,  rel /* release */);
     stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
   
     SpectralSynth ss => stmonoin.mono_in ;
     ss.open(SYNTWAV.syntwavs_files(nfile) + note + ".wav");
     while( ss.loaded() == 0 )
     {   ss.loadSamples(44100);    // ~1s of audio per batch
         1::samp => now;
     }
     //4096 => ss.fftSize;
     //8 => ss.overlap;
     // load the audio buffer
     ss.pitchShift( pitchShift );
     ss.robotize( robotize );
     ss.whisperize( whisperize );
     ss.spectralBlur( spectralBlur );
     ss.spectralGate( spectralGate );
     ss.loopStart(loopStart);
     ss.loopEnd(loopEnd);
   
     ss.prepare();
     <<< "  numFrames:", ss.numFrames() >>>;
     while( ss.analyzed() == 0 )       // analyze in batches
     {   ss.analyzeFrames(25);
   //      1::samp => now;
   //    me.yield();
       10::ms =>now;
     }
     // process in batches of 50 frames, yielding between each
     while( ss.ready() == 0 )
     {
       ss.processFrames( 25 );
   //    1::samp => now;
   //    me.yield();
       10::ms =>now;
     }
     <<< "  ready:", ss.ready() >>>;
   
     ss.loop( 1 );
     ss.crossfade(16 * 2048 );
     v * data.master_gain => ss.gain;
   
     ss.play();
     stadsr.keyOn(); 
   
     if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
     }
   
     d => now;
     stadsr.keyOff(); 
     rel => now;
     ss.stop();
   } 
   

   

////////////////////////////////////////////////////////////////////////////////////////////
//BPM
143 => data.bpm;   (60.0/data.bpm)::second => data.tick;
48 => data.ref_note;

SYNC sy;
//sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::ms => w.fixed_end_dur;
//8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 


  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 29/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .001 * 6 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 12/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  
  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive(mixer + 2); stmix $ ST @=> ST @ last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

  STMIX stmix2;
  stmix2.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT2();
  fun void EFFECT3   (){ 
    STMIX stmix;
    stmix.receive(mixer + 3); stmix $ ST @=> ST @ last; 

STFREEFILTERX stfreeresx0; RES_XFACTORY stfreeresx0_fact;
stfreeresx0.connect(last $ ST , stfreeresx0_fact, 3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreeresx0 $ ST @=>  last; 
SinOsc sin0 => OFFSET ofs0  => stfreeresx0.freq; // CONNECT THIS
0.1 => sin0.freq;
249* 10.0 => sin0.gain;

444 * 10. => ofs0.offset;
1.0 => ofs0.gain;
 

TriOsc tri0 =>  ofs0;
0.13 => tri0.freq;
3333.0 => tri0.gain;
0.5 => tri0.width;


STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

    STMIX stmix2;
    stmix2.send(last, mixer + 2);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
  
    while(1) {
           100::ms => now;
    }
     
  } 
  spork ~  EFFECT3();
//////////////////////////////////////////////////////////////////////////////
fun void  LOOP_SPECTR  (){ 
    8 * 8 * data.tick => w.wait;
    spork ~ SPECTR (36/*note*/,19/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,2 * 8 * data.tick/*att*/,2 * 8 * data.tick/*rel*/, 2 * 8 * data.tick, 1, 0.6); 
    8 * 8 * data.tick => w.wait;
    spork ~ SPECTR (38/*note*/,19/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,2 * 8 * data.tick/*att*/,2 * 8 * data.tick/*rel*/, 2 * 8 * data.tick, 1, 0.6); 
    8 * 8 * data.tick => w.wait;
    spork ~ SPECTR (36/*note*/,19/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,1/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,2 * 8 * data.tick/*att*/,2 * 8 * data.tick/*rel*/, 2 * 8 * data.tick, 1, 1.0); 
    8 * 8 * data.tick => w.wait;
    spork ~ SPECTR (38/*note*/,19/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,1/*robotize*/,1/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,2 * 8 * data.tick/*att*/,2 * 8 * data.tick/*rel*/, 2 * 8 * data.tick, 1, 1.0); 
    8 * 8 * data.tick => w.wait;


} 


fun void  LOOPLAB  (){ 
  while(1) {
     1::second / Std.mtof(data.ref_note) => dur comb_dur;
 


    spork ~ SYNTFROG ("{c{c{c *2 " + RAND.seq("8/1_,F/1_,__,__,__,__,f/8_,1/8_,F//1,1//F,B//8",8) , 2::ms, 8* data.tick, 3, 3.8);
    
    spork ~ TRIBAL_CUSTOM("*4  __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR __RR  ", 1 /* tomix */, 0.7 /* gain */);

    spork ~ TRIBAL_CUSTOM("*4 __Z_ ____ Y_Y_ ____ __X_    ", 1 /* tomix */, 1.0 /* gain */);
    spork ~ TRIBAL_CUSTOM("*4 ____ ____ ____ ____ ____ ____ aa__    ", 2 /* tomix */, 1.0 /* gain */);
     8 * data.tick => w.wait;
//<<<"comb_dur",comb_dur/1::ms>>>;
spork ~   COMB ("*8   " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",6) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,2,1.0); 
     8 * data.tick => w.wait;

    spork ~ SYNTFROG ("{c{c{c *2 " + RAND.seq("8/1_,F/1_,__,__,__,__,f/8_,1/8_,F//1,1//F,B//8",8) , 2::ms, 8* data.tick, 3, 3.8);

    spork ~ TRIBAL_CUSTOM("*4  __RR __RR __RR __RR __RR __RR __RR __RR   __RR __RR __RR __RR __RR __RR __RR __RR  ", 1 /* tomix */, 0.7 /* gain */);

    spork ~ TRIBAL_CUSTOM("*4 __Z_ ____ Y_V_ ____ X___    ", 1 /* tomix */, 1.0 /* gain */);
    spork ~ TRIBAL_CUSTOM("*4 ____ ____ ____ ____ ____ ____ fb__    ", 2 /* tomix */, 1.0 /* gain */);
    8 * data.tick => w.wait;
    spork ~   COMB ("*8   " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",6) ,2*comb_dur/*comb_dur*/,.94/*comb_res*/,2,1.0); 
    8 * data.tick => w.wait;
    //-------------------------------------------
  }
} 
spork ~ LOOPLAB();
spork ~  LOOP_SPECTR  (); 
//LOOPLAB(); 

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
  spork ~KICK("*4     k___ k___ k___ k___ k___ k___ k___ k___");
  spork ~ BASS0(" *4 !1111 __11 ____ __11!1111 __33 __11 ____     ");
  8 * data.tick =>  w.wait; 

//spork ~ BASS0(" *2 _!1_!1_!1_!1_!1_!1_!1_!1___ ");
//  spork ~ BASS0("{c {c *4  1//1__ ____  1//1__ _1__  1//1__ 1//1__  1//1__ 5!5__  ");
//  spork ~ BASS0(" *2   _1 _1 _1 _1 _1 _1 _1 _1   ");
//  spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
//    spork ~  BASS0_ATTACK ("*4    __aa __aa __aa __aa __aa __aa __aa __aa  ", 0.7 /* rate */, .16 /* g */); 
//  spork ~ BASS0(" *4  _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1   ");
//    spork ~  BASS0_ATTACK ("*4   aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa        ", 0.7 /* rate */, .16 /* g */); 
//  spork ~ BASS0(" *4  __11 1111 1111 11__ 1111 1111 1111 11__     ");
//  spork ~ BASS0(" *4  __11 1111 1111 11__ ____ 1111 1111 11__      ");
//  spork ~ BASS0(" *4  1111 1111 __11 1111 1111 __11 1111 1111      ");

//    spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
//    spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
//    spork ~  TRANCEHH ("*4 -4   jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  "); 
//  spork ~ SEQ0( "*4 ____ ____ ____ _ab_ ____ ____ ___b ____  ", 0, .3);
//  spork ~ SYNT0("*4 ____ __ " + RAND.char("351_", 3) +RAND.seq("-5f,1,8,1", 1)  +"_  ", 2, 1.5);

//  spork ~   ACID ("*8 }c  1_1_1_1_ 5_1_ __1_ __1_ 1_1_  1_1_1_1_ 5_1_ __1_ __1_ 1_1_1_1_1_1_", 1232, ":2 8/ff///8" /*target_f*/, ":2 1//55//1" /*base_f*/, " 1///FF///1" /*target_q*/, 2, .15);  
//
  // 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);
}  


