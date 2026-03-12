1 => int mixer;
20::ms => dur local_delay;

///////////////////////////////////////////////////////////////////////////////////////////////////////
fun void  MOD0  (string seq, int mix, float g){ 
  local_delay => now;
  TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(1 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_
//8_8_ 8_8_ 8_8_ 8_8_ ____ ____ ____ ____ 
//5_3_ 2_1_ 5_3_ 2_1_ 5_3_ 2_1_ 5_3_ ____
seq => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); //
//16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  


SinOsc sin0 =>  s0.inlet;
30.0 => sin0.freq;
300.0 => sin0.gain;

  

STMIX stmix;
stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
 
} 

///////////////////////////////////////////////////////////////////::
class synt0 extends SYNT{

      8 => int synt_nb; 0 => int i;
      Gain detune[synt_nb];
      SERUM00 s[synt_nb];

      123 => int n; 
       
      Gain final => outlet; 1.0 => final.gain;

      s[i].config(n /* synt nb */ );inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
      s[i].config(n /* synt nb */ );inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .3 => s[i].gain; i++;  
      s[i].config(n /* synt nb */ );inlet => detune[i] => s[i] => final;    0.997 => detune[i].gain;    .3 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void GLIDE (string seq, int n, float lpf_f, int mix,  float v) {
  local_delay => now;

  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; 
  40::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(15::ms, 20::ms, .8, 40::ms);
t.set_adsrs_curves(0.6, 1.3, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}
///////////////////////////////////////////////////////////////////::

fun void PLOC (string seq, int n, float lpf_f, int mix,  float v) {
  local_delay => now;

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
//  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 150::ms, .00002, 400::ms);
t.set_adsrs_curves(0.6, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}
///////////////////////////////////////////////////////////////////////
fun void TRIBAL(string seq, int nb, int mix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  
  if ( nb == 0  ){
    SET_WAV.TRIBAL0(s);
  }
  else if (  nb == 1  ){
    SET_WAV.TRIBAL1(s);
  }
  else {
    SET_WAV.TRIBAL(s);
  }
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  if ( mix  ){
    STMIX stmix;
    stmix.send(last, mixer + mix);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* mix */, .5 /* gain */);
////////////////////////////////////////////////////////////////////////////////////////////

fun void  CELLO0  (string seq, int mix, float g){ 
  local_delay - 15::ms => now;
  TONE t;
  t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              //t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 27 * 100 /* Variable */, 2. /* Q */);
stsynclpfx0.adsr_set(.3 /* Relative Attack */, .1/* Relative Decay */, 0.6 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STMIX stmix;
stmix.send(last, mixer + mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////////
// spork ~ RING("1111 1111 1////F F////1", ":4 H/G"/*fmod*/, ":41/8"/*gmod*/,65/*k*/,1*data.tick, 4,.2);
fun void  RING( string seq, string fmod, string gmod, int k, dur d, int mix, float g){ 
  TONE t;
  t.scale.size(0);
  t.scale << 1 << 3 << 1 << 2 << 3 << 2;
  t.reg(SERUM00 s0); s0.config(k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
                                     // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;

  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(3::samp , 10::ms, 1., 3::samp);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  // Ring mod
  3 => s0.inlet.op;
  
  // MOD
  AUTO.freq(fmod) =>  SqrOsc s => Gain gsin=> Gain out;
  3 => gsin.op;
  AUTO.gain(gmod) => gsin; // Simple gain with mod

  out => s0.inlet;

  STMIX stmix;
  stmix.send(last, mixer + mix);

  d => now; 
} 

////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////// BPM
//BPM
//143 => data.bpm;   (60.0/data.bpm)::second => data.tick;
//53 => data.ref_note;

SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//1::ms => w.fixed_end_dur;
8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 


//  STCONVREV stconvrev;
//  stconvrev.connect(last $ ST , 29/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .001 * 6 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
STCONVREV stconvrev;
stconvrev.connect(last $ ST , 119/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .05 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last; 
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

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix2;
  stmix2.send(last, mixer + 2);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT3();

fun void EFFECT4   (){ 
   STMIX stmix;
   stmix.receive(mixer + 4); stmix $ ST @=> ST @ last; 
 
   STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
   stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 25 * 10 /* freq base */, 75 * 10 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
   8 => stautoresx0.gain;
   //
   STECHO ech;
   ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 
 
   STAUTOPAN autopan;
   autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 
 
   STLIMITER stlimiter;
   3. => float in_gainl;
   stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT4();
fun void EFFECT5   (){ 
  STMIX stmix;
  stmix.receive(mixer + 5); stmix $ ST @=> ST @ last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 13 * 100 /* freq var */, data.tick * 34 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STMIX stmix2;
  stmix2.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT5();

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

fun void  LOOPPROG  (){ 
//  while(1) {

    spork ~ TRIBAL("*4 q____", 1 /* bank */, 2 /* mix */, .6 /* gain */);
    8 * data.tick => w.wait;
    spork ~ RING(":2  1111 1111 1////F F////1", ":2 A/GG/A"/*fmod*/, ":4f/1"/*gmod*/,64/*k*/,4*data.tick, 4,.1);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*6 }c *8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3*8:7 8_7_6_5_ }3 ", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL(" {9 S____ ____", 1 /* bank */, 1 /* mix */, .8 /* gain */);
    8 * data.tick => w.wait;

    spork ~ RING(":2  1111 1111 1////F F////1", ":2 H/GG/H"/*fmod*/, ":41/8"/*gmod*/,64/*k*/,4*data.tick, 4,.1);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c }c {1 !3!2_ {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_    ", 3, .5); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL(" Y____ ___", 1 /* bank */, 2 /* mix */, .5 /* gain */);
    8 * data.tick => w.wait;
    spork ~ RING(":2    WWWW", "*2 Z/GG/ZZ/GG/ZZ/GG/ZZ/GG/Z"/*fmod*/, ":4t/f"/*gmod*/,59/*k*/,4*data.tick, 4,.1);
    8 * data.tick => w.wait;

    spork ~   MOD0 ("*4 }c }1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1  ", 3, .6); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 ABC_u__ ____", 1 /* bank */, 3 /* mix */, 0.5 /* gain */);
    8 * data.tick => w.wait;
    spork ~ RING(":2    F////1", ":2 Z/GG/Z"/*fmod*/, ":41/f"/*gmod*/,60/*k*/,4*data.tick, 4,.15);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*8 }c }1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_}1 !1!2!3_ ", 3, .7); 
    8 * data.tick => w.wait;

     spork ~ RING(":2 {c 1111 1111 ", ":8 H//F"/*fmod*/, ":8 1/88/f"/*gmod*/,65/*k*/,16*data.tick, 4,.1);
    16 * data.tick => w.wait;
    //-------------------------------------------
//  }
} 
//spork ~ LOOPPROG();

fun void  LOOPSAW  (){ 
  while(1) {
    24 * data.tick => w.wait;
    spork ~   CELLO0 (":4 B///B_", 4, 1.6); 
    32 * data.tick => w.wait;
    spork ~   CELLO0 (":4 3//3_", 4, 1.6); 
    32 * data.tick => w.wait;
    spork ~   CELLO0 (":4 1///1_", 4, 1.6); 
    24 * data.tick => w.wait;
    spork ~   CELLO0 (":4 A____", 4,  1.6); 
    spork ~   CELLO0 (":4 _0___", 4,  1.6); 
    spork ~   CELLO0 (":4 __1//1_", 4,1.6); 
    16 * data.tick => w.wait;
    //-------------------------------------------
  }
} 
//spork ~ LOOPSAW();

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
fun void  LOOPGLIDE  (){ 
//  while(1) {
  spork ~   GLIDE ("*2 }c  3153153153153153153153153FB31c38   ", 17, 56 * 100, 5,  0.3 ); 
  16 * data.tick => w.wait;
  spork ~   GLIDE ("*2 }c  31531531531531531531531531B3f5D8   ", 17, 56 * 100, 5,  0.3 ); 
  16 * data.tick => w.wait;
  spork ~   GLIDE ("*2 }c  31531531531531531531531B315D1531   ", 17, 56 * 100, 5,  0.3 ); 
  16 * data.tick => w.wait;
  spork ~   GLIDE ("*2 }c  3153153153153153153153153853f531   ", 17, 56 * 100, 5,  0.3 ); 
  16 * data.tick => w.wait;
//  }
} 
//spork ~ LOOPGLIDE();
 
fun void  LOOPPLOC  (){ 
//  while(1) {
  spork ~   PLOC ("  {c 5_3_ 2_1_   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c 5_3_ 2_1!8   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c 5_a_ 2_1_   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c 5_3_ 2_1!8   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c B_3_ 2_1_   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c 5_3_ 2_f!8   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c B_3_ 2_F_   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
  spork ~   PLOC ("  {c 5_3_ 2_8!f   ", 17, 29 * 100, 2,  0.6 ); 
  8 * data.tick => w.wait;
//  }
} 
//spork ~ LOOPPLOC();


//spork ~ LOOPLAB();
//LOOPLAB(); 

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
    spork ~ TRIBAL("*4 q____", 1 /* bank */, 2 /* mix */, .7 /* gain */);
    8 * data.tick => w.wait;
    spork ~ RING(":2   1////F F////1", ":2 Z//WW//Z"/*fmod*/, ":4f/1"/*gmod*/,65/*k*/,4*data.tick, 4,.15);
    8 * data.tick => w.wait;
    spork ~   PLOC ("*4  {c 5_5_5_5_   ", 14, 29 * 100, 2,  0.3 ); 
    8 * data.tick => w.wait;
   spork ~   PLOC ("  {c #4___ 5___   ", 17, 29 * 100, 2,  0.6 ); 
    8 * data.tick => w.wait;

   spork ~   MOD0 ("*2 }c }c #4#4#__ 55__    ", 3, .3); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c }c {1 !3!2_ {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_  {1 !3!2_    ", 3, .3); 
    spork ~   PLOC ("  {c 5___ #4___   ", 17, 29 * 100, 2,  0.6 ); 
    8 * data.tick => w.wait;
    spork ~   PLOC ("*4  {c  #4_#4_#4_#4_  ", 14, 29 * 100, 2,  0.3 ); 
    8 * data.tick => w.wait;
    spork ~ RING(":2  1111 1111 1////F F////1", ":2 A/GG/A"/*fmod*/, ":4f/1"/*gmod*/,64/*k*/,4*data.tick, 4,.05);
    8 * data.tick => w.wait;
 

}


