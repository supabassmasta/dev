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
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
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

////////////////////////////////////////////////////////////////////////////////////////

fun void MEGAMOD (int n, int nmod, string seq, string modf, string modg, string arpi, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.config(n /* synt nb */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   .2 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();// 
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(2::ms, 30::ms, .7, 40::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 


STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan("*2 1//88/5/8/1*28/11/88/11/88/11/88/11/8")  => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

//STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
//stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
//AUTO.freq(arpi)  => stfreelpfx0.freq; // CONNECT THIS 
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


STREVAUX strevaux;
strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  

//SERUM00 s1;
//s1.config(nmod /* synt nb */ ); 

//AUTO.freq(modf) =>  s1 => MULT m0 => s0.inlet;
AUTO.freq(modf) =>  SinOsc sin0 =>  MULT m0 => s0.inlet;
AUTO.freq(modg) =>  m0; 
//
//ARP arp;
//arp.t.dor();
//50::ms => arp.t.glide;
////arpi => arp.t.seq;
//arp.t.go();   
////
// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 


  d => now; // let seq() be sporked to compute length
}


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

//STMIX stmix;
//stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;








150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

fun void  LAB_LOOP(){ 
 while(1) {
  //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
  //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
   
 int a[0];
 a << 137;
 a << 138;
 a << 141;
 a << 170;
 a << 208;
// spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "TFTF8" /*modg*/, "}c mn/tn/Tmt" /* lpf */, 16 * data.tick)  ;
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 " + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*4 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c:4 g/11/FF/g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   
 }
} 
spork ~ LAB_LOOP();
//LAB_LOOP();

/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!8!1 __8//1 __!1!1 __!1!1 __!B!1 __b//1_   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ ____ k___ _____  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!8!1 __8//1 __!1!1 !1!1!1!1 __!B!1!1!1!b//1_   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!8!1 __8//1 __!1!1 __!1!1 __!B!1 __b//1_   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ ____ k_k_ kkkk_  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!8!1 __8//1 __!1!1 !1!1!1!1 __   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   


}