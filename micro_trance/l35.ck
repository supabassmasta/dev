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
fun void KICK3_HPF(string seq, string hpfseq) {

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


STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 


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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.2 =>p.phase; } 1 => own_adsr;
} 

fun void BASS0 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 27 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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
/////////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0_HPF (string seq, string hpfseq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 27 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

/////////////////////////////////////////////////////////////////////////////////////////////////

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

fun void  MODU (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


AUTO.freq(modf) =>  SinOsc sin0 => MULT m => s0.inlet;
AUTO.freq(modg) =>  m;


STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, cut /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////

fun void PLOC (string seq, int n, float lpf_f,  float v) {

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
t.set_adsrs(2::ms, 50::ms, .00002, 400::ms);
t.set_adsrs_curves(0.6, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  ARP arp;
  arp.t.dor();
  10::ms => arp.t.glide;
  "*8 1538 B2Ffc  " => arp.t.seq;
  arp.t.go();   

  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan("*2 1/88/55/88/11/33/1") => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}
/////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  NOISE3 s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => s.gain;
//   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
   attackRelease => now;
    
} 


// spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 


////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  








155 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

fun void LOOP_MOD   (){ 
   
  while(1) {
   
    spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ FFFF ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FF!88__ 8_5_3_1 " , "1", "f", 2500, 0.6); 
    8 * data.tick =>  w.wait;   
    spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_    " , "f", "f", 2500, 0.6); 
    8 * data.tick =>  w.wait;   
   spork ~   MODU (20, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FFFF__ 8_5_3_1 " , "f", "f", 2500, 0.6); 
   8 * data.tick =>  w.wait;   
   spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_    " , "f", "f", 2500, 0.6); 
   8 * data.tick =>  w.wait;   
 spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FFFF__ 8_5_3_1 " , "1", "f", 2500, 0.6); 
 8 * data.tick =>  w.wait;   



 spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ f////F ____ 1_2_  ____  3_2_ 1_0_ 1_2_  ____ FF!88__ 8_5_3_1   " , "f", "f", 2500, 0.6); 
 8 * data.tick =>  w.wait;   
    spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ FFFF ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FF!88__ 8_5_3_1 " , "1", "f", 2500, 0.6); 
    8 * data.tick =>  w.wait;   
    spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_    " , "f", "f", 2500, 0.6); 
    8 * data.tick =>  w.wait;   



   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 F/f", "f", 2500, 0.6); 
   8 * data.tick =>  w.wait;   
   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 f/m", ":8 f/m", 2500, 0.8); 
   8 * data.tick =>  w.wait;   
   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 F/f", "m", 2500, 1.0); 
   8 * data.tick =>  w.wait;   
   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 m/t", ":8 f/m", 2500, 1.2); 
   8 * data.tick =>  w.wait;   
   }
} 
//spork ~   LOOP_MOD (); 
// LOOP_MOD ();

/********************************************************/
//if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
//  spork ~   MODU (21, "{c   M////M *4 __M__M__M_M_M__M_M" , ":M m/t", ":M f/m", 2500, 0.8); 
//  spork ~   MODU (21, "{c   8////M *4 __M__M__M_M_M__M_M" , ":8 m/t", ":8 f/m", 2500, 0.8); 
//  spork ~   MODU (21, "{c   8////M *4 __M__M__M_M_M__M_M" , ":2 m/t", ":8 f/m", 2500, 0.8); 
//  spork ~   MODU (22, "{c   8////M *4 __M__M__M_M_M__M_M" , ":2 t/m", ":8 f/m", 2500, 0.8); 
//  spork ~   MODU (21, "{c   M////8 *4 __8__8__8_8_8__8_8" , ":8 m/t", ":8 f/m", 2500, 0.8); 
//  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 17, 29 * 100, 0.2 ); 
//  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 17, 29 * 100, 0.2 ); 
//  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 17, 29 * 100, 0.2 ); 
//  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 17, 29 * 100, 0.2 ); 



////////////////////////////////////////////////////////////////////////////////

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/



///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
1 => int rec_mode; // While playing song in compute mode, rec it

"l35_main.wav" => string name_main;
"l35_aux.wav" => string name_aux;
8 * data.tick => dur main_extra_time;
8 * data.tick => dur end_loop_extra_time;

1 => int end_loop_rec_once;

if ( !compute_mode && MISC.file_exist(name_main) && MISC.file_exist(name_aux)  ){
    LONG_WAV l;
    name_main => l.read;
    1.0 * data.master_gain => l.buf.gain;
    0 => l.update_ref_time;
    l.AttackRelease(0::ms, 10::ms);
    l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

    LONG_WAV l2;
    name_aux => l2.read;
    0.2 * data.master_gain => l2.buf.gain;
    0 => l2.update_ref_time;
    l2.AttackRelease(0::ms, 10::ms);
    l2.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

    STREVAUX strevaux;
    strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    // WAIT Main to finish
    l.buf.length() - main_extra_time =>  w.wait;
    
// END LOOP 
    0 => data.next;

    while (!data.next) {

      <<<"**********">>>;
      <<<" END LOOP ">>>;
      <<<"**********">>>;

      LONG_WAV l;
      name_main+"_end_loop" => l.read;
      1.0 * data.master_gain => l.buf.gain;
      0 => l.update_ref_time;
      l.AttackRelease(0::ms, 10::ms);
      l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

      LONG_WAV l2;
      name_aux+"_end_loop" => l2.read;
      0.2 * data.master_gain => l2.buf.gain;
      0 => l2.update_ref_time;
      l2.AttackRelease(0::ms, 10::ms);
      l2.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

      STREVAUX strevaux;
      strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

      // WAIT end loop to finish
      l.buf.length() - end_loop_extra_time =>  w.wait;
    }
 
    
}
else {


// REC  MAIN /////////////////////////////////////////     
  STREC strec;
  STREC strecaux;
  if (rec_mode) {     
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strec.connect(last $ ST); strec $ ST @=>  last;  
    0 => strec.gain;
    strec.rec_start(name_main, 0::ms, 1);

    // REC AUX //////////////////////////////////////////
    ST staux; staux $ ST @=>   last;

    if ( MISC.check_output_nb() >= 4  ){
      // Rec out Aux
      dac.chan(2) => staux.outl;
      dac.chan(3) => staux.outr;
    } else {
      // rec Default reverb STREV1
      global_mixer.rev1_left => staux.outl;
      global_mixer.rev1_right => staux.outr;
    }

    /// START REC

    strecaux.connect(last $ ST); strecaux $ ST @=>  last;  

    strecaux.rec_start(name_aux, 0::ms, 1);
  }
//////////////////////////////////////////////////




  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_kk *2 kkkk*2kkkk kkkk   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   


    spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ FFFF ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FF!88__ 8_5_3_1 " , "1", "f", 2500, 0.6); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 17, 29 * 100, 0.2 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 17, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   


    spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_    " , "f", "f", 2500, 0.6); 
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 18, 29 * 100, 0.3 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 16, 29 * 100, 0.3 ); 
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

   spork ~   MODU (20, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_  ____ FFFF__ 8_5_3_1 " , "f", "f", 2500, 0.6); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 19, 29 * 100, 0.3 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 19, 29 * 100, 0.3 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

   spork ~   MODU (22, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_ ____ F////f ____ 1_2_  ____ 3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_ 1_2_ {c  3_2_ 1_0_    " , "f", "f", 2500, 0.6); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 22, 29 * 100, 0.4 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 23, 29 * 100, 0.3 ); 
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   



//************************************************************************




   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 F/f", "f", 2500, 0.6); 
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  " , ":8 M/5"); 
  spork ~  BASS0_HPF ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1", ":8 M/5"); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 f/m", ":8 f/m", 2500, 0.8); 
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  " , ":8 5/f"); 
  spork ~  BASS0_HPF ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1", ":8 5/f"); 
  8 * data.tick =>  w.wait;   


   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_" , ":8 F/f", "m", 2500, 1.0); 
  8 * data.tick =>  w.wait;   

   spork ~   MODU (21, "*4 {c *2   ____ 3_2_ 1_0_ 1_2_  3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ 1_2_3_2_ 1_0_ " , ":8 m/t", ":8 f/m", 2500, 1.2); 
  spork ~  KICK3 ("____ __ *4 ___k k_kkk_  ");
  4 * data.tick =>  w.wait;   
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 4* data.tick /* dur */, .9 /* width */, .24 /* gain */); 
  4 * data.tick =>  w.wait;   

//************************************************************************


  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }

  
///////////////////////// END LOOP ///////////////////////////////////::
0 => data.next;

while (!data.next) {

  <<<"**********">>>;
  <<<" END LOOP ">>>;
  <<<"**********">>>;

// REC  MAIN END LOOP /////////////////////////////////////////     
  STREC strecendloop;
  STREC strecendloopaux;
  if (rec_mode && end_loop_rec_once) {     
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strecendloop.connect(last $ ST); strecendloop $ ST @=>  last;  
    0 => strecendloop.gain;
    strecendloop.rec_start(name_main +"_end_loop", 0::ms, 1);

    // REC AUX END LOOP //////////////////////////////////////////
    ST staux; staux $ ST @=>   last;

    if ( MISC.check_output_nb() >= 4  ){
      // Rec out Aux
      dac.chan(2) => staux.outl;
      dac.chan(3) => staux.outr;
    } else {
      // rec Default reverb STREV1
      global_mixer.rev1_left => staux.outl;
      global_mixer.rev1_right => staux.outr;
    }

    /// START REC

    strecendloopaux.connect(last $ ST); strecendloopaux $ ST @=>  last;  

    strecendloopaux.rec_start(name_aux + "_end_loop", 0::ms, 1);
  }
//////////////////////////////////////////////////


  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 17, 29 * 100, 0.2 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 17, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_k___  "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 __!3!2 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   PLOC ("  {c *8 1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_1__1 __1_", 18, 29 * 100, 0.3 ); 
  spork ~   PLOC ("     *8 ____1 __1____1 ____1__1 ____1__1 ____1__1 __1____1 ____1___ __1____1 1_1_", 16, 29 * 100, 0.3 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k_kk k___   "); 
  spork ~  BASS0 ("*4   __!3!2 __!1!2 __!3!2 __!1!1   __!3!2 __!1!2 !3!2!1!5 !4!3!2!1      "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

  
  //// STOP REC ///////////////////////////////
  if (rec_mode && end_loop_rec_once) {     
    end_loop_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strecendloop.rec_stop( 0::ms, 1);
    strecendloopaux.rec_stop( 0::ms, 1);
    0 => end_loop_rec_once;
    2::ms => now;
  }


}

}

 

