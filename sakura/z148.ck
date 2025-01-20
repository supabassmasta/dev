1 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 18 * 100 /* init freq env */, 0.5 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 6 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 6 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");
///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik2;
kik2.config(0.1 /* init Sin Phase */, 45 * 100 /* init freq env */, 0.5 /* init gain env */);
kik2.addFreqPoint (433.0, 2::ms);
kik2.addFreqPoint (150.0, 16::ms);
   
kik2.addGainPoint (0.6, 13::ms);
kik2.addGainPoint (0.4, 25::ms);
kik2.addGainPoint (0.0, 15::ms); 

fun void KICK2(string seq) {
  TONE t;
  t.reg( kik2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");


///////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0(string seq) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  //  STMIX stmix;
  //  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0RATE(string seq, float r, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  r => s.wav_o["T"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");
//////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ1RATE(string seq, string c, float r, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  r => s.wav_o[c].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{
  5. => float amp;
  inlet => PowerADSR padsr => SinOsc s =>  outlet; 
  padsr.set(1::ms, 5::ms, 1. / amp , 200::ms);
  padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  amp => padsr.gain;
  padsr => Gain two => SinOsc s2 =>  outlet; 
  2 => two.gain;
//  .45 => s.width;
  .4 => s.gain;
  .1 => s2.gain;
  fun void on()  {padsr.keyOn(); }  fun void off() { }  fun void new_note(int idx)  {padsr.keyOn(); } 0 => own_adsr;
} 


fun void SYNT0 (string seq, int mix, float g) {
  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(1::ms, 19::ms, .3, 40::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 6 *10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____", mixer, .4);

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, dur d, dur offset, dur a, dur r, int mix, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  STADSR stadsr;
  stadsr.set(a /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, .0 /* Sustain dur of Relative release pos (float) */,  r /* release */);
  //   stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  stadsr.keyOn(); 

  STMIX stmix;
  stmix.send(last, mix);

  g => s.gain;

  file => s.read;
  ( offset / 1::samp ) $ int => s.pos;

  if(d == 0::ms) 
    s.length() => now;
  else
    d => now;

  stadsr.keyOff(); 
  r => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  .4); 

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATE  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   s.length() * (1./r) => now;
} 

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 


////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATEECHO  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STECHO ech;
   ech.connect(last $ ST , data.tick * 4 / 4 , .8);  ech $ ST @=>  last; 
//   STMIX stmix;
//   stmix.send(last, mixer);

   r => s.rate;
   g => s.gain;

   file => s.read;

   12 * data.tick => now;
}

//spork ~   SINGLEWAVRATEECHO("../_SAMPLES/", 1.8, .6); 
///////////////////////////////////////////////////////////////////

fun void MEGAMOD (int n, string seq, string modf, string modg, string g_curve, dur d, int mix, float g){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.config(n /* synt nb */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   g * .6 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();// 
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(2::ms, 30::ms, .7, 40::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STFREEGAIN stfreegain;
stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
AUTO.gain(g_curve) => stfreegain.g; // connect this 

STMIX stmix;
stmix.send(last, mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 



//AUTO.freq(modf) =>  s1 => MULT m0 => s0.inlet;
AUTO.freq(modf) =>  SinOsc sin0 =>  MULT m0 => s0.inlet;
AUTO.freq(modg) =>  m0; 

<<<"MEGAMOD seq", seq>>>;


  d => now; // let seq() be sporked to compute length
}
//     spork ~ MEGAMOD (Std.rand2(237,240)  /*137*/ , "*4 }c 8 " + RAND.char("fc54188bcf3____", 8)  + "_"," 1//ff/BB/1 "  /* modf */, "*2 a" /*modg*/, "8" /* g curve */, 4 * data.tick, mixer, 1.1)  ;

////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE (string seq, int n, float lpf_f,  dur gldur, dur d, int mix, float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mix);

  <<<"SEQ SYNTGLIDE: ", seq>>>;

  d => now;

}

/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, int mix, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mix);
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


////////////////////////////////////////////////////////////////////////////////////////
fun void  SUPSAW  (string seq, float ph, string pans, int mix, float g){ 
  TONE t;
  t.reg(SUPERSAW1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//"
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

//STFILTERMOD fmod2;
//fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 50 * 100  /* f_var */, 1.03::second / (3 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 
STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
ph => stautoresx0.sin0.phase;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 2.0 /* Q */,600 /* freq base */, 50 * 100 /* freq var */, data.tick * 3 / 2/* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan(pans) => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

//mod
SinOsc sin0 => s0.inlet; 
0.4 => sin0.freq;
3 * 100.0 => sin0.gain;
//Std.rand2f(0., 1.) => sin0.phase;
.5 => sin0.phase;




STMIX stmix;
stmix.send(last, mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
  

   
} 

////////////////////////////////////////////////////////////////////////////////////////

fun void MEGADIG (int n,  string seq, string ech_curve, string g_curve, dur d, int mix, float g){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.config(n /* synt nb */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   g * .6 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();// 
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(2::ms, 30::ms, .7, 40::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STDIGIT dig;
dig.connect(last $ ST , 1::samp /* sub sample period */ , .0 /* quantization */);      dig $ ST @=>  last; 

AUTO.freq(ech_curve) => Gain f => blackhole; // CONNECT THIS 



STFREEGAIN stfreegain;
stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
AUTO.gain(g_curve) => stfreegain.g; // connect this 

//STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
//stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//3 => stautoresx0.gain;

STMIX stmix;
stmix.send(last, mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 
//d => now;

now + d => time end;
while(end > now) {
//47 => int di;
(2000 / f.last()) $ int => int  di;
if ( di < 1  ){
    1 => di;
}
// ((100::ms / f.last() / 1::samp) $ int)::samp => dur e;
// if (! now%1::secongd)
// <<<"_-'-__-'-__-'-__-'-__-'-__-'-__-'-_  " + di + "   _-'-__-'-__-'-__-'-__-'-__-'-_">>>;
//<<<e>>>;


di * 1::samp => dur e;
   dig.set( e , 0.);
//   dig.set( 47::samp, 0.);

    1::samp=> now;
//    2 * data.tick=> now;
}

}

/////////////////////////////////////////////////////////////////////////////////

fun void  PART_DISPLAY  (){ 
   <<<"INTRO">>>;
   8 * data.tick => now;
   <<<"TEK">>>;
   128 * data.tick => now;
   <<<"PONT CHANT">>>;
   32 * data.tick => now;
   <<<"HIP HOP">>>;
   32 * data.tick => now;
   <<<"MONTEE">>>;
   32 * data.tick => now;
   <<<"TEK SITAR BASS">>>;
   32 * data.tick => now;
   <<<"TEK DIDGE">>>;
   32 * data.tick => now;
   <<<"MISTERIOUS SITAR">>>;
   32 * data.tick => now;
   <<<"MISTERIOUS DIDGE (Continuous)">>>;
   32 * data.tick => now;
   <<<"TEK DIDGE">>>;
   32 * data.tick => now;
   <<<"VOICE cut">>>;
   64 * data.tick => now;
   <<<"VOICE">>>;
   32 * data.tick => now;
   <<<"END">>>;
   
} 


////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

//data.bpm => data.bpm;   (60.0/data.bpm)::second => data.tick;
//data.ref_note => data.ref_note;

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//8 *data.tick => w.fixed_end_dur;
1*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

fun void  BEAT_COUNTER  (){ 
  1 => int i;
    while(1) {
      <<<"-------------------">>>;
      <<<"-        " + i + "        -">>>;
      <<<"-------------------">>>;
      1 +=> i;
      data.tick => now;
    }
} 
spork ~   BEAT_COUNTER (); 


// OUTPUT

6. => float CHASS_GAIN;

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 30* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 
  STAUTOPAN autopan;
  autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 6 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 
} 
EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive(mixer + 2); stmix $ ST @=> ST @ last; 
  STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 0.6 /* Q */, 7 * 100 /* freq base */, 12 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
  STAUTOPAN autopan;
  autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 6 / 2 /* period */, 0.5 /* phase 0..1 */ );       autopan $ ST @=>  last; 
  STECHO ech;
  ech.connect(last $ ST , data.tick * 6 / 4 , .4);  ech $ ST @=>  last; 
} 
EFFECT2();

fun void EFFECT3   (){ 
  STMIX stmix;
  stmix.receive(mixer + 3); stmix $ ST @=> ST @ last; 
 STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .85);  ech $ ST @=>  last; 
} 
EFFECT3();

fun void EFFECT4   (){ 
  STMIX stmix;
  stmix.receive(mixer + 4); stmix $ ST @=> ST @ last; 
  
  STGVERB stgverb;
  stgverb.connect(last $ ST, .005 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 
} 
EFFECT4();


/////////////////////////////////////////////////////////////////////////

fun void ONESHOTEFFECT11   (){ 
  STMIX stmix;
  stmix.receive(mixer + 11); stmix $ ST @=> ST @ last; 

 STDIGIT dig;
 dig.connect(last $ ST , 3::samp /* sub sample period */ , .0 /* quantization */);      dig $ ST @=>  last; 

//STMIX stmix2;
//stmix2.send(last, mixer+ 2);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  .5 *data.tick => now;
 dig.set(6::samp  , 0.);
 .5 *data.tick => now;
 dig.set(12::samp  , 0.);
   .5 *data.tick => now;
 dig.set(18::samp  , 0.);
  .5 *data.tick => now;
 dig.set(42::samp  , 0.);
  .5 *data.tick => now;
 
 } 
//  spork ~ ONESHOTEFFECT11  (); 



/////////////////////////////////////////////////////////////////////////
fun void  LOOP_TEK1  (){ 
    spork ~   SUPSAW (" *8 h_h_h_h_h_h_h_h_", .6, "3/6" ,mixer + 3,1.0); 
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 3.0);
    8 * data.tick => w.wait;
     spork ~ MEGAMOD (129  /*137*/ , "*4 }c}c 8 _31_3_"  ," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 2 * data.tick, mixer + 1, 1.3)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
    spork ~ SYNTGLIDE("*4  3455158b " /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, 4 * data.tick, mixer + 2, 0.55 );
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
     spork ~ MEGAMOD (129  /*137*/ ,  " *4 }c}c 8 1_//_a1_"," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 3 * data.tick, mixer + 1, 1.3)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
    spork ~ SYNTGLIDE("*4  a011321_51345" /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, 6 * data.tick, mixer + 2, 0.65 );
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
    spork ~   SUPSAW (" __ -4 g//H", .3, "1/8" ,mixer + 4,1.8); 
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
     spork ~ MEGAMOD (114  /*137*/ ,  "*4 }c}c 8 1_//_a1_ _"," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 4 * data.tick, mixer + 1, 1.0)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer + 0, 1.5);
    8 * data.tick => w.wait;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer + 1, 1.5);
    spork ~   SUPSAW (" __ H/pp//1", .8, "8/11/8" ,mixer + 3,1.2);
    8 * data.tick => w.wait;

  /////////////////////////////////////////


    spork ~   SUPSAW (" *8 h_h_h_h_h_h_h_h_", .9, "6/3" ,mixer + 3,1.2);
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 3.0);
    8 * data.tick => w.wait;
     spork ~ MEGAMOD (129  /*137*/ ,  "*4  }c}c  a011321_51345_"," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 4 * data.tick, mixer + 1, 1.3)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;

    spork ~ SYNTGLIDE("*4  3a013213a01" /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, 4 * data.tick, mixer + 2, 0.65 );
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
    spork ~   SUPSAW (" *8 h_f_h_f_h_f_h_f_", .7, "3/6" ,mixer + 3,1.2); 
     spork ~ MEGAMOD (129  /*137*/ ,  "*4 }c}c 8 1//8_33a1___"," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 5 * data.tick, mixer + 1, 1.3)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    spork ~   SUPSAW (" __ p/HH//1", .8, "8/11/8" ,mixer + 3,1.2);
    8 * data.tick => w.wait;
    spork ~ SYNTGLIDE("*4  _332131345321583 " /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, 7 * data.tick, mixer + 2, 0.65 );
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;


    spork ~   SUPSAW (" __ H/p", .1, "8/1" ,mixer + 3,1.2); 
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer, 1.5);
    8 * data.tick => w.wait;
     spork ~ MEGAMOD (114  /*137*/ ,  "*8 }c}c 1 1a_/a83/31__G/f_ "," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 6 * data.tick, mixer + 1, 1.0)  ;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer + 0, 1.5);
    8 * data.tick => w.wait;
    spork ~ SYNT0("}c  ____   ___*2_3:2", mixer + 1, 1.5);
    8 * data.tick => w.wait;
  
 
} 
fun void  HIPHOP_LOOP  (){ 
    spork ~   MEGADIG (124, "  *4  Db3}cDb3}cDb3}cDb3}cDb3}cDb3}cDb3}cDb3}cDb3}cDb3", "f"/*ech_curve*/, "8////5"/*g*/, 4 * data.tick, mixer + 4, 3.0 /*g*/); 
    4 * data.tick => w.wait;
    spork ~   MEGADIG (4, "__ }c  *8 D_D_D___ D_D_D___ b_3_D___ ", "DDD"/*ech_curve*/, "8"/*g*/, 6 * data.tick, mixer + 3, 1.0 /*g*/); 
    4 * data.tick => w.wait;
   spork ~   MEGADIG (124, " }c}c   *8  b_3_D_b_3_b___", "f"/*ech_curve*/, "8"/*g*/, 3 * data.tick, mixer + 4, 2.0 /*g*/); 
    4 * data.tick => w.wait;
     spork ~   MEGADIG (258, "__ }c  *8 DCBA 01234 5678 9abb:4 ", "m"/*ech_curve*/, "888"/*g*/, 6 * data.tick, mixer + 1, 2.0 /*g*/); 
   5 * data.tick => w.wait;
   spork ~   MEGADIG (124, " }c}c   *8*2  D_3_b_", "f"/*ech_curve*/, "3//88"/*g*/, 2.1 * data.tick, mixer + 4, 3.0 /*g*/); 
    3 * data.tick => w.wait;
   spork ~   MEGADIG (124, " }c}c   *6*2  b_b_b_b_b_b_b_b_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
    1 * data.tick => w.wait;
   spork ~   MEGADIG (124, " }c}c   *6*2  D_D_D_D_D_D_D_D_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
    1 * data.tick => w.wait;
   spork ~   MEGADIG (124, " }c}c   *6*2  3_3_3_3_3_3_3_3_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
    2 * data.tick => w.wait;
   spork ~   MEGADIG (124, "  *4}c}c}c}c}c  Db3{cDb3{cDb3{cDb3{cDb3{cDb3{cDb3{cDb3{c", "f"/*ech_curve*/, "5////8"/*g*/, 4 * data.tick, mixer + 4, 3.0 /*g*/); 
     spork ~   MEGADIG (258, "__ }c  *8 b__b__b_3__b__b_b_ :8", "8"/*ech_curve*/, "8"/*g*/, 6 * data.tick, mixer + 3, 2.0 /*g*/); 
    8 * data.tick => w.wait;

} 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

fun void  LOOPLAB  (){ 
  while(1) {
   spork ~   MEGADIG (124, " }c}c   *6*2  8_8_8_8_8_8_8_8__", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
    spork ~   SUPSAW (" __ p/HH//1", .8, "8/11/8" ,mixer + 3,1.2);
    6 * data.tick => w.wait;

     spork ~ MEGAMOD (129  /*137*/ ,  "*4 }c}c 8 1//8_33a1___"," 1//ff/BB/1 "  /* modf */, "*2 aag" /*modg*/, "8" /* g curve */, 5 * data.tick, mixer + 1, 1.3)  ;
    6 * data.tick => w.wait;
    spork ~   MEGADIG (124, "  *4 }c  123_}c123_}c123_}c123_}c123_}c123_}c123_}c123_}c", "f"/*ech_curve*/, "8//////1"/*g*/, 6 * data.tick, mixer + 4, 3.0 /*g*/); 
    6 * data.tick => w.wait;
     spork ~   MEGADIG (4, "__ }c  *8 1_1_1___ 1_1_1___ 5_F_f___ ", "DDD"/*ech_curve*/, "8"/*g*/, 6 * data.tick, mixer + 3, 1.0 /*g*/); 
     8 * data.tick => w.wait;
    spork ~   MEGADIG (124, " }c}c   *8  8_5_ 101_ 1_1_1__", "f"/*ech_curve*/, "8"/*g*/, 3 * data.tick, mixer + 4, 2.0 /*g*/); 
     4 * data.tick => w.wait;
 //     spork ~   MEGADIG (258, "__ }c  *8 DCBA 01234 5678 9abb:4 ", "m"/*ech_curve*/, "888"/*g*/, 6 * data.tick, mixer + 1, 2.0 /*g*/); 
 //   5 * data.tick => w.wait;
 //   spork ~   MEGADIG (124, " }c}c   *8*2  D_3_b_", "f"/*ech_curve*/, "3//88"/*g*/, 2.1 * data.tick, mixer + 4, 3.0 /*g*/); 
 //    3 * data.tick => w.wait;
 //   spork ~   MEGADIG (124, " }c}c   *6*2  b_b_b_b_b_b_b_b_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
 //    1 * data.tick => w.wait;
 //   spork ~   MEGADIG (124, " }c}c   *6*2  D_D_D_D_D_D_D_D_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
 //    1 * data.tick => w.wait;
 //   spork ~   MEGADIG (124, " }c}c   *6*2  3_3_3_3_3_3_3_3_", "f"/*ech_curve*/, "8"/*g*/, 1 * data.tick, mixer + 4, 2.0 /*g*/); 
 //    2 * data.tick => w.wait;
 //   spork ~   MEGADIG (124, "  *4}c}c}c}c}c  Db3{cDb3{cDb3{cDb3{cDb3{cDb3{cDb3{cDb3{c", "f"/*ech_curve*/, "5////8"/*g*/, 4 * data.tick, mixer + 4, 3.0 /*g*/); 
 //     spork ~   MEGADIG (258, "__ }c  *8 b__b__b_3__b__b_b_ :8", "8"/*ech_curve*/, "8"/*g*/, 6 * data.tick, mixer + 3, 2.0 /*g*/); 
 //    8 * data.tick => w.wait;
    32 * data.tick => w.wait;

    //-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
LOOPLAB(); 

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

   spork ~  PART_DISPLAY  (); 
   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, 0 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
    8 * data.tick => w.wait;
   spork ~   LOOP_TEK1 (); 
   64 * data.tick => w.wait;
   48 * data.tick => w.wait;
   spork ~  SLIDENOISE(200 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .1 /* width */, 3, .8 /* gain */); 
   16 * data.tick => w.wait;
   // PONT CHANT
   32 * data.tick => w.wait;
   spork ~   HIPHOP_LOOP (); 

// TEK 
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // PONT CHANT
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, 136 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // HIP HOP
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // MONTEE
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (2 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // TEK SITAR BASS
//  spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (3 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // TEK DIDGE
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (4 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // MISTERIOUS SITAR
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (5 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // MISTERIOUS DIDGE (Continuous)
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (6 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // TEK DIDGE
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (7 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // VOICE cut
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (8 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // VOICE
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (10 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   // END
//   spork ~   SINGLEWAV("../_SAMPLES/Chassin/Dong escape.wav", 0::ms /* d */, (11 * 32 +136) * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 


512 * data.tick => w.wait;


  // 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);
}  



