10 => int mixer;
/////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCE(string seq) {

  SEQ s;  
  SET_WAV.TRANCE(s); 
  
  // SET_WAV.TRANCE_KICK(s); 
  // s.wav["k"]=> s.wav["k"];
 
  
  seq => s.seq;
  .8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 6.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.3 => stod.gain;

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//spork ~  TRANCE ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
/////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  
  SET_WAV.TRANCE(s); 
  
  // SET_WAV.TRANCE_KICK(s); 
  // s.wav["k"]=> s.wav["k"];
 
  
  seq => s.seq;
  .9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
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

////////////////////////////////////////////////////////////////////////////////////////////
fun void BASS (string seq) {
  TONE t;
  t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .6 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STLPFN lpfn;
  lpfn.connect(last $ ST , 7 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SIN("}c *8 4103124801234 :8 ____ ____");


////////////////////////////////////////////////////////////////////////////////////////////

class syntSin extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
fun void SIN (string seq) {
  TONE t;
  t.reg(syntSin s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .2 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SIN("}c *8 4103124801234 :8 ____ ____");


////////////////////////////////////////////////////////////////////////////////////////////
fun void PLOC (string seq) {
  TONE t;
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  1.2 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SIN("}c *8 4103124801234 :8 ____ ____");


////////////////////////////////////////////////////////////////////////////////////////////
class syntSqr extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void SQR (string seq) {
  TONE t;
  t.reg(syntSqr s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .2 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 61 * 100 /* Variable */, 5. /* Q */);
stsynclpf.adsr_set(.02 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .02 /* Relative Sustain dur */, 0.9 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last;   STMIX stmix;


  stmix.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SQR("}c *8 4103124801234 :8 ____ ____");



////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STMIX stmix;
   stmix.send(last, mixer + 2);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 
////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAVECHOFAT  (string file, float g, dur d){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STECHO ech;
   ech.connect(last $ ST , data.tick * 3 / 4 , .85);  ech $ ST @=>  last; 
   
   STAUTOPAN autopan;
   autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

   g => s.gain;

   file => s.read;

   d => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 
////////////////////////////////////////////////////////////////////////////////////////////
fun void  SLIDE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  TriOsc s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;

   SinOsc sin0 =>  s;
   10.0 => sin0.freq;
   300.0 => sin0.gain;
   Noise n => s;
   700 => n.gain;
   
   1.0 => stp0.next;
   
   g => s.gain;
   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
   attackRelease => now;
    
} 

//spork ~  SLIDE(200 /* fstart */, 1000 /* fstop */, 1* data.tick /* dur */, .5 /* width */, .03 /* gain */); 

//////////////////////////////////////////////////////////////////////////////////
fun void SUPERHIGH (string seq) {
  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(1 /* synt nb */ );
  // s0.set_chunk(0); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .21 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  // MOD ////////////////////////////////

  SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
  1::second / (13 * data.tick) => s.freq;
  //   0 => s.phase;
  Std.rand2f(0, 1) => s.phase;
  0.2 => mod.freq;

  1.2 => o.offset;
  5.7 => o.gain;

   ARP arp;
   arp.t.dor();
  // 50::ms => arp.t.glide;
   "*8  1/8 1/3 8/1 1/8  " => arp.t.seq;
   arp.t.go();   
  
  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer );
  STMIX stmix2;
  stmix2.send(last, mixer + 1 );
  //stmix.receive(11); stmix $ ST @=> ST @ last; 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration + now => time target;
  [ 40 , 12 ,18 ] @=> int ar[]; // 12 18
  while(now < target) {
      s0.set_chunk(ar[Std.rand2(0, ar.size() - 1)]); 
        .5 * data.tick => now;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
fun void SUPERHIGH2 (string seq) {
  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(3 /* synt nb */ );
  // s0.set_chunk(0); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .17 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  // MOD ////////////////////////////////

  SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
  1::second / (13 * data.tick) => s.freq;
  //   0 => s.phase;
  Std.rand2f(0, 1) => s.phase;
  0.2 => mod.freq;

  1.2 => o.offset;
  5.7 => o.gain;

   ARP arp;
   arp.t.dor();
  // 50::ms => arp.t.glide;
   "*8  1/8 1/3 8/1 1/8  " => arp.t.seq;
   arp.t.go();   
  
  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer );
  STMIX stmix2;
  stmix2.send(last, mixer + 1 );
  //stmix.receive(11); stmix $ ST @=> ST @ last; 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration + now => time target;
  [ 40 , 12 ,18 ] @=> int ar[]; // 12 18
  while(now < target) {
      s0.set_chunk(ar[Std.rand2(0, ar.size() - 1)]); 
        .5 * data.tick => now;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////


147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
//sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
0::ms => w.fixed_end_dur;
//8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

// OUT 2

STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

// OUT 3

STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 4 / 4 , .2);  ech2 $ ST @=>  last; 


// INTRO

if ( 1  ){
    
  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/contournerlaforet.wav", 1.3); 
  30 * data.tick =>  w.wait; 
spork ~  SLIDE(200 /* fstart */, 1000 /* fstop */, 3.5* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
  4 * data.tick =>  w.wait; 

}

// LOOP
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
 

/********************************************************/
  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ SQR("{c{c{c{c __F//f f/F___ __d/D_ ____ ");
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ SQR("{c{c{c f/F_F//f f/F___ __d/D_ ____ ");
 
  16 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------


  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/pissoiedelaboue.wav", 1.3); 
  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk __*4_____kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 ________ "); 

  12 * data.tick =>  w.wait; 
  spork ~  SLIDE(200 /* fstart */, 1500 /* fstop */, 4.0* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
 
  4 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/diablerie.wav", 1.4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 


//---------------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/baliverne.wav", 1.5); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------


  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/latinvisigotte.wav", 1.3); 
  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk ____ ____ ____ "); 
  spork ~ BASS ("*2 _1_1_1_1 ____  ____ ____ "); 
 
  4.4 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVECHOFAT("../_SAMPLES/visiteurs/diablote.wav", 1.3, 12* data.tick); 
  7.6 * data.tick =>  w.wait; 

  spork ~  SLIDE(1500 /* fstart */, 200 /* fstop */, 4.0* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------


  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/rendtoisatanique.wav", 1.4); 
  4 * data.tick =>  w.wait; 

// ------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 


//---------------------------------------------------------------------------



  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/visiteurs/languedudiablote.wav", 1.6); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
 spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kk*4k_k_kkkk:4 ____ ____"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  ____ ____ "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~ BASS ("*2_1_1_1_1 _1_1_1_1 _8/1______ ________ "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH2 ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kk*4k_k_kkkk:4 ____ ____"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  ____ ____ "); 
  spork ~   SUPERHIGH2 ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 

} 



