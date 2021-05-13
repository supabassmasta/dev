
17 => int mixer;
///////////////////////////////////////////////////////////////////////
fun void TRIBAL(string seq, int nb, int tomix, float g) {

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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
// spork ~ TRIBAL("*4 __a_", 0, .5);

/////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCE(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" 
  SET_WAV.TRANCE_KICK(s); 
  s.wav["k"]=> s.wav["k"];

  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .6 * data.master_gain => s.gain; //
  s.gain("s", .8); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//spork ~  TRANCE ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 

////////////////////////////////////////////////////////////////////////////////////////

fun void BASS (string seq) {
  TONE t;
  t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .47 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 270.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void SYNTGLIDE (string seq, dur d, dur gldur, float v) {

  TONE t;
  t.reg(SERUM3 s0);  //data.tick * 8 => t.max; 
  s0.config(3 /* synt nb */ );
//  STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
//  stepc.out => s0.in; s0.control_update(10::ms); 

   SinOsc sin0 =>  OFFSET ofs0  => s0.in; s0.control_update(1::ms);
   0.3 => ofs0.offset;
   1. => ofs0.gain;
   
   0.01 => sin0.freq;
   0.2 => sin0.gain;


  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(10::ms, 10::ms, 1., 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFADEIN fadein;
  fadein.connect(last, 16*data.tick);     fadein  $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer);

//  1::samp => now; // let seq() be sporked to compute duration
//  t.s.duration => now;

d => now;
}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 50::ms /* glide dur */, .19 /* gain */);


////////////////////////////////////////////////////////////////////////////////////////////
fun void SYNTGLIDE2 (string seq, dur d, dur gldur, float v) {

  TONE t;
  t.reg(SERUM3 s0);  //data.tick * 8 => t.max; 
  s0.config(2 /* synt nb */ );
//  STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
//  stepc.out => s0.in; s0.control_update(10::ms); 

   SinOsc sin0 =>  OFFSET ofs0  => s0.in; s0.control_update(1::ms);
   0.5 => ofs0.offset;
   1. => ofs0.gain;
   
   0.01 => sin0.freq;
   0.5 => sin0.gain;


  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(10::ms, 10::ms, 1., 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);

//  1::samp => now; // let seq() be sporked to compute duration
//  t.s.duration => now;

d => now;
}

//spork ~ SYNTGLIDE2("*4 }c }c 92921204_" /* seq */, 50::ms /* glide dur */, .19 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////////

fun void PLOC (string seq) {
  TONE t;
  t.reg(PLOC1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.gypsy_minor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  1.0 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer+1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ BLIP("}c *8 4103124801234 :8 ____ ____");


////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////


148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

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

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 9 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


////////// REV ////////////////
STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=> last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .10 /* mix */, 4 * 10. /* room size */, 2::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

// LOOP
int j;

/********************************************************/
if (    0     ){
 }/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
  

//  spork ~ SYNTGLIDE("*4 }c  1212 a01_ 1111 5432 101_" /* seq */, 64 * data.tick, 50::ms /* glide dur */, .4 /* gain */);
  spork ~ SYNTGLIDE("*4 }c}c 
  845231 
  " /* seq */, 64 * data.tick, 50::ms /* glide dur */, .3 /* gain */);
  
  
  4 =>  j;
  while(j) {
    1 -=> j;

    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ ___d", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1___1__"); 
    spork ~   PLOC ("*4 }c ____ ____ ____ _1__"); 


    4 * data.tick =>  w.wait; 
    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ __uA", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1___1__"); 

    4 * data.tick =>  w.wait; 

  }

  4 =>  j;
  while(j) {
    1 -=> j;

    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ ___d", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1_1_1__"); 
    spork ~   PLOC ("*4 }c ____ ____ 1_1_ _1__"); 


    4 * data.tick =>  w.wait; 

    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ __xy", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1_1_1_3"); 

    4 * data.tick =>  w.wait; 

  }


  spork ~ SYNTGLIDE2("*4 }c}c}c 
  845231 
  " /* seq */, 64 * data.tick, 50::ms /* glide dur */, .2 /* gain */);
   
//  spork ~ SYNTGLIDE2("*4 }c}c 
//  845231 
//  " /* seq */, 64 * data.tick, 50::ms /* glide dur */, .2 /* gain */);
   
//  spork ~ SYNTGLIDE2("*4 }c}c 
//  1212 a01_ 1111 5432  101_ 1212 a01_ 1111 
//  1212 1212 1212 1265  4545 a01_ a01_ 1111   
//  
//  " /* seq */, 64 * data.tick, 50::ms /* glide dur */, .2 /* gain */);
   
  8 =>  j;
  while(j) {
    1 -=> j;

    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ ___d", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1_1_1__"); 
    spork ~   PLOC ("*4 }c 1_1_ _1_1!1_1_ _1__"); 

    4 * data.tick =>  w.wait; 

    spork ~ TRIBAL("*2 __ _<1 x <5a_ _<1 x ", 0 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ _e__", 1 /* bank */, 0 /* tomix */, .4 /* gain */);
    spork ~ TRIBAL("*4 ____ __xy", 1 /* bank */, 1 /* tomix */, .4 /* gain */);
    spork ~  TRANCE ("*2_+9h+9+3sh_hsh"); 
    spork ~  TRANCE ("MMMM"); 
    spork ~  BASS ("*2 _1_1_1_3"); 
    spork ~   PLOC ("*4 }c 1!1!1_ _1_1!1_1_ _1__"); 

    4 * data.tick =>  w.wait; 

  }

 
} 
