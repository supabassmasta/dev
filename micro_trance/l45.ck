21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.28 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////


class SERUM00X extends SYNT{

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
  

  fun void config(int wn /* wave number */) {



  list_SERUM0.get(wn) => string wstr;
    
   if ( wstr == ""  ){
    list_SERUM0.get(0) => wstr;
   }
   else {
      <<<"serum wavtable :", wn, wstr>>>;
   }

   wstr => s.read;


    0 => int start;

    for (start => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.50 =>p.phase; } 1 => own_adsr;
} 

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

fun void BASS0 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2369 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(0::ms, 10::ms, 1, 4::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 1* 10.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 58 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.19 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", .06); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   0.8 => s.wav_o["S"].wav0.rate;
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

fun void  ACID  (string seq, int nb,string target_f, string base_f, string target_q, int mix, float g){ 
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
                      //s0.config(1234 /* synt nb */ ); 
  s0.config(nb/* synt nb */ ); 
  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
          //*8 1_1_1___1_1___1_ :8 
  seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STQSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 15 * 100 /* Variable */);
  stsynclpfx0.q(1 /* Base */, 8 /* Variable */);
  stsynclpfx0.adsr_set(.02 /* Relative Attack */, .3/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.q_adsr_set(.1 /* Relative Attack */, 0.8/* Relative Decay */, 0.0 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  1::samp => stsynclpfx0.nio.period;



AUTO.freq(target_f) =>  stsynclpfx0.nio.padsr;
AUTO.freq(base_f) => stsynclpfx0.nio.filter_freq;
AUTO.gain(target_q) =>  stsynclpfx0.nio.q_padsr;


  STMIX stmix;
  stmix.send(last, mix);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
 
} 


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

//STMIX stmix;
//stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

fun void EFFECT1   (){ 

  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 

  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .04 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

//  STECHO ech;
//  ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 


} 
EFFECT1();







150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

/********************************************************/

fun void  LOOPKICKBASS  (int n){ 
  while(n) {
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
      
    1 -=> n;

    8 * data.tick => w.wait;
  }
} 

/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"

  spork ~ LOOPKICKBASS   (4); 
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 4_3_ 2_11 __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c 3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6_5_ 4_3_ 2_1_ 6_5_ 4_3_ 1_0_ ", 1232, ":2 1" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);    8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 5_4_ 5_6_ __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5_6_ 7_8_ 7_8_ __5_ 4_3_ 1_2_ 3_4_ 55__ 6___ 7_8_ 7_66 __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
// ----------------------------------------------------------------
  spork ~ LOOPKICKBASS   (4); 
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 4_3_ 2_11 __5_ 4_3_ 1___ ", 1232, ":2 1////5" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c 3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6_5_ 4_3_ 2_1_ 6_5_ 4_3_ 1_0_ ", 1232, ":2 5////8" /*target_f*/, ":2 1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);    8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 5_4_ 5_6_ __5_ 4_3_ 1___ ", 1232, ":2 8////5" /*target_f*/, ":2 1" /*base_f*/, ":2 9" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5_6_ 7_8_ 7_8_ __5_ 4_3_ 1_2_ 3_4_ 55__ 6___ 7_8_ 7_66 __5_ 4_3_ 1___ ", 1232, ":2 5////1" /*target_f*/, ":2 1" /*base_f*/, ":2 a" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
// ----------------------------------------------------------------
  spork ~ LOOPKICKBASS   (4); 
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 4_3_ 2_11 __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 1////8" /*base_f*/, ":2 b" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c 3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6_5_ 4_3_ 2_1_ 6_5_ 4_3_ 1_0_ ", 1232, ":2 1" /*target_f*/, ":2 8////f" /*base_f*/, ":2 a" /*target_q*/, mixer + 1, .3);    8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5___ 4_3_ 2_11 __5_ 4_3_ 1___ 3_2_ 11__ 6___ 5_4_ 5_6_ __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 f////8" /*base_f*/, ":2 9" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
  spork ~   ACID ("*8 }c   3_2_ 11__ 5_6_ 7_8_ 7_8_ __5_ 4_3_ 1_2_ 3_4_ 55__ 6___ 7_8_ 7_66 __5_ 4_3_ 1___ ", 1232, ":2 1" /*target_f*/, ":2 8////1" /*base_f*/, ":2 8" /*target_q*/, mixer + 1, .3);  8 * data.tick =>  w.wait;   
// ----------------------------------------------------------------

}
