5 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 11 * 100 /* init freq env */, 0.5 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 70::ms);
kik.addFreqPoint (31.0, 11 * 10::ms);

kik.addGainPoint (0.3, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 30::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 11 *10::ms); 

fun void KICK(string seq) {
  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .7 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 48* 10.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .4 /* Slope */, 4::ms /* Attack */, 20::ms /* Release */ );      duckm $ ST @=>  last; 
1. => duckm.gain;

//  STCONVREV stconvrev;
//  stconvrev.connect(last $ ST , 22/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, 1 * .01 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;

}
//spork ~ KICK("*4 k___ k___ k___ k___");

///////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0(string seq, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
//  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  //
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{
  inlet => SinOsc s =>  outlet; 
  .5 => s.gain;
  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void SYNT0 (string seq, int n, int mix, float g) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);

  // s0.pos s0.rate s0.lastbuf 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last,mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void SYNT1 (string seq, int n, float f, int mix, float g) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);

  // s0.pos s0.rate s0.lastbuf 

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, f  /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last,mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");
////////////////////////////////////////////////////////////////////////////////////////////
fun void SYNT2 (string seq, int n, dur att, int mix, float g) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, att/* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s1.config(.5 /* G */, att/* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);

  // s0.pos s0.rate s0.lastbuf 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last,mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void GLITCHMOD (string seq, int n, float gmod, float fmod, float pmod, float f,  int mix, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 

  // s0.pos s0.rate s0.lastbuf 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, f  /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


    STMIX stmix;
    stmix.send(last,mixer + mix);

SinOsc sin0 =>  s0.inlet;
fmod => sin0.freq;
gmod => sin0.gain;
pmod => sin0.phase;


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////
fun void GLITCH (string seq, int n,float f,  int mix, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 

  // s0.pos s0.rate s0.lastbuf 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, f  /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


    STMIX stmix;
    stmix.send(last,mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS (string seq, int n,float f,  int mix, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 

  // s0.pos s0.rate s0.lastbuf 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(10::ms, 10::ms, 1., 40::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, f  /* freq */ , 1.2 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STCONVREV stconvrev;
//stconvrev.connect(last $ ST , 7/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .01 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

//    STMIX stmix;
//    stmix.send(last,mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////

//148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
//55 => data.ref_note;

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//8 *data.tick => w.fixed_end_dur;
4*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 


STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 

  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 12/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .2 /* rev gain */  , 0.7 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
} 
spork ~   EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive(mixer + 2); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, data.tick * 11 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

//STMIX stmix2;
//stmix2.send(last, mixer + 1);

while(1) {
       100::ms => now;
}
 
} 
spork ~   EFFECT2();

fun void EFFECT3   (){ 
  STMIX stmix;
  stmix.receive(mixer + 3); stmix $ ST @=> ST @ last; 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .8 /* span 0..1 */, data.tick * 11 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .8);  ech $ ST @=>  last; 

//STMIX stmix2;
//stmix2.send(last, mixer + 1);

while(1) {
       100::ms => now;
}
 
} 
spork ~   EFFECT3();

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 


// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
  spork ~   BASS ("{c 41_4454__", 6, 19 *10, 0, 2.8); 
  spork ~   KICK ("kkkkkkkk"); 
  spork ~ SEQ0(RAND.char("FEDCBA__", Std.rand2(1,3)),Std.rand2(2,3), 0.6);
 8 * data.tick => w.wait;
 
  spork ~   BASS ("{c{c 88//4444!8__", 6, 19 *10, 0, 2.8); 
  spork ~   KICK ("kkkkkkkk"); 
  spork ~ SEQ0(RAND.char("FEDCBA__", Std.rand2(1,3)),Std.rand2(2,3), 0.6);
 8 * data.tick => w.wait;
 
}  

