21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 18 * 100 /* init freq env */, 0.5 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


fun void KICK3(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
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
  t.s.duration - 1::samp => now;
}
///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3_HPF(string seq, string hpfseq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
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
  t.s.duration - 1::samp => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////


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

///////////////////////////////////////////////////////////////////////////////////////////////


fun void BASS0 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
stsynclpfx0.freq(14 * 10 /* Base */, 28 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.3 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  15::ms /* release */);
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

///////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0_HPF (string seq, string hpfseq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
stsynclpfx0.freq(14 * 10 /* Base */, 28 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.3 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

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
    stmix.send(last, mixer + 2);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);
////////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", .05); // for single wav 
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

class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void SIN (string seq, float g) {

  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
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

STMIX stmix;
stmix.send(last, mixer);

  1::samp => now;
  t.s.duration => now;


}


////////////////////////////////////////////////////////////////////////////////////////
fun void PADS (string seq,int n, float g) {

  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.3 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s1.config(.3 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  // s0.pos s0.rate s0.lastbuf 
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

STMIX stmix;
stmix.send(last, mixer +1 );

  1::samp => now;
  t.s.duration => now;


}


////////////////////////////////////////////////////////////////////////////////////////


fun void MEGAMOD (int n, int nmod, string seq, string modf, string modg, string arpi, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.config(n /* synt nb */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   .25 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();// 
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(2::ms, 30::ms, .7, 40::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 


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



////////////////////////////////////////////////////////////////////////////////////////////
class syntOneP extends SYNT{
  inlet => Gain in;
  Gain out =>  outlet;   

  0 => int i;
  Gain opin[8];
  Gain opout[8];
  ADSR adsrop[8];
  TriOsc osc[8];

  // build and config operators
  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1. => opin[i].gain;
  adsrop[i].set(1::ms, 20::ms, 1. , 2::ms);
  1 => adsrop[i].gain;
  i++;

  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1./4. + 0.00 => opin[i].gain;
  adsrop[i].set(10::ms, 100::ms, 1. , 200::ms);
  100 * 7 => adsrop[i].gain;
  i++;

  //---------------------
  //      opin[i] =>;
  Step st => osc[i] => adsrop[i] => opout[i];
  2. => st.next;
  1./8. +0.0 => opin[i].gain;
  adsrop[i].set(100::ms, 186::ms, 1. , 1800::ms);
  15 * 100 => adsrop[i].gain;
  i++;

  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1./2. +0.000 => opin[i].gain;
  adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
  30 => adsrop[i].gain;
  i++;

  // connect operators
  // main osc
  in => opin[0]; opout[0]=> out; 

  // modulators
  in => opin[1];
  opout[1] => opin[0];

  in => opin[2];
  opout[2] => opin[0];

  in => opin[3];
  //      opout[3] => opin[0];


  .5 => out.gain;

  fun void on()  
  {
    for (0 => int i; i < 8      ; i++)
    {
      adsrop[i].keyOn();
      // 0=> osc[i].phase;
    }

  } 

  fun void off() 
  {
    for (0 => int i; i < 8      ; i++) 
    {
      adsrop[i].keyOff();
    }


  } 

  fun void new_note(int idx)  
  { 

    if(idx == 0) {

      0.2 => osc[2].phase;        
      <<<"PHASE UPDATE">>>;
    }

  }
  0 => own_adsr;
}  


fun void  ONEP0  (string s, float g){ 


  TONE t;
  t.reg(syntOneP s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
  //t.lyd(); // t.ion(); // t.mix();// 
  t.dor();// t.aeo(); // t.phr();// t.loc();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  1.7 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STLPF lpf;
  lpf.connect(last $ ST ,  6 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

  //==============================================================================================
  STECHO ech;
  ech.connect(last $ ST , data.tick * 8 / 8 , .3);  ech $ ST @=>  last; 

  STFILTERMOD fmod;
  fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 8* 100  /* f_var */, 1::second / (12 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 



  STCOMPRESSOR stcomp;
  4. => float in_gain;
  stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .3 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 0);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 

/////////////////////////////////////////////////////////////////////////////////////////

fun void SSYNT0 (string seq) {

  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(4 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,   data.tick * 1 /4 /* attack */, 1 * data.tick /* decay */, 0.6 /* sustain */, 3* data.tick /* release */ );
  s0.add(5 /* synt nb */ , 0.4 /* GAIN */, 1.0006 /* in freq gain */,   data.tick * 1 /4 /* attack */, 1 * data.tick /* decay */, 0.6 /* sustain */, 3* data.tick /* release */ );
  s0.add(3 /* synt nb */ , 0.3 /* GAIN */, 0.5 /* in freq gain */,   data.tick * 1 /4 /* attack */, 1 * data.tick /* decay */, 0.6 /* sustain */, 3* data.tick /* release */ );
  s0.add(3 /* synt nb */ , 0.3001 /* GAIN */, 0.5 /* in freq gain */,   data.tick * 1 /4 /* attack */, 1 * data.tick /* decay */, 0.6 /* sustain */, 3* data.tick /* release */ );


  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .08 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 10::ms, .6, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(100 /* Base */, 14 * 100 /* Variable */, 1.3 /* Q */);
  stsynclpfx0.adsr_set(.9 /* Relative Attack */, .6/* Relative Decay */, 0.4 /* Sustain */, .1 /* Relative Sustain dur */, 1.9 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


  STMIX stmix;
  stmix.send(last, mixer + 3);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ SSYNT0 ("1"); 
/////////////////////////////////////////////////////////////////////////////////////////

fun void SSYNT1 (string seq) {

  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .3 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 6 * 100::ms, .3, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer + 3);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ SSYNT0 ("1"); 


/////////////////////////////////////////////////////////////////////////////////////////

fun void ACID (string seq) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(3 /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .21 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 10::ms, .6, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 57 * 100 /* Variable */, 1.92 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.2 /* Q */, 5 * 100 /* freq base */, 65 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STREVAUX strevaux;
strevaux.connect(last $ ST, .05 /* mix */); strevaux $ ST @=>  last;  

1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ ACID ("1"); 

//////////////////////////////////////////////////////////////////////////////////////// 
fun void ACID2 (string seq) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(6 /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .16 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 10::ms, .6, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(3 * 100 /* Base */, 17 * 100 /* Variable */, 1.83 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.2 /* Q */, 5 * 100 /* freq base */, 65 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STREVAUX strevaux;
strevaux.connect(last $ ST, .05 /* mix */); strevaux $ ST @=>  last;  

1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ ACID ("1"); 

//////////////////////////////////////////////////////////////////////////////////////// 
fun void ACID3 (string seq) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2209 /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .16 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 10::ms, .6, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(250 /* Base */, 57 * 100 /* Variable */, 2.92 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STAUTOFILTERX stautolpfx0; RES_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.2 /* Q */, 5 * 100 /* freq base */, 54 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STREVAUX strevaux;
strevaux.connect(last $ ST, .05 /* mix */); strevaux $ ST @=>  last;  

1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ ACID ("1"); 

//////////////////////////////////////////////////////////////////////////////////////// 
fun void ACID3 (string seq, string fseq, string gseq) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2209 /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .19 * data.master_gain => t.gain;
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(6::ms, 10::ms, .6, 9 * 10::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(250 /* Base */, 57 * 100 /* Variable */, 2.92 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
stbrfx0.connect(last $ ST ,  stbrfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbrfx0 $ ST @=>  last;  

//STBELL stbell0; 
//stbell0.connect(last $ ST , 30 * 10 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, -.8 /* Gain */ );       stbell0 $ ST @=>  last;   

STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1.2 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
AUTO.freq(fseq) => stfreelpfx0.freq; // CONNECT THIS 

STFREEGAIN stfreegain;
stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
AUTO.gain(gseq) => stfreegain.g; // connect this 

//


STREVAUX strevaux;
strevaux.connect(last $ ST, .08 /* mix */); strevaux $ ST @=>  last;  

1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
// spork ~ ACID ("1"); 

//////////////////////////////////////////////////////////////////////////////////////// 

//////////////////////////////////////////////////////////////////////////////////////// 

//////////////////////////////////////////////////////////////////////////////////////// 

//////////////////////////////////////////////////////////////////////////////////////// 

////////////////////////////////////////////////////////////////////////////////////////


157 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;

stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;


STCOMPRESSOR stcomp;
5. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

.8 => stcomp.gain;

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

STMIX stmix1;
stmix1.receive(mixer + 1); stmix1 $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,4 *  10::ms /* dur base */, 3::ms /* dur range */, 7 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,4 *  10::ms /* dur base */, 3::ms /* dur range */, 6 /* freq */); 

STREVAUX strevaux1;
strevaux1.connect(last $ ST, .5 /* mix */); strevaux1 $ ST @=>  last;  

STMIX stmix2;
stmix2.receive(mixer + 2); stmix2 $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .88);  ech2 $ ST @=>  last;

STAUTOPAN autopan;
autopan.connect(last $ ST, .96 /* span 0..1 */, data.tick * 3 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux2;
strevaux2.connect(last $ ST, .4 /* mix */); strevaux2 $ ST @=>  last;  

STMIX stmix3;
stmix3.receive(mixer + 3); stmix3 $ ST @=>  last; 

STREVAUX strevaux3;
strevaux3.connect(last $ ST, .6 /* mix */); strevaux3 $ ST @=>  last;  

//////////////////////////////////////////////////////////////////////////////////////////////////

fun void  MAIN_LOOP(){ 

  <<<"MAIN LOOP">>>;

  //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
  //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
   
 int a[0];
 a << 137;
 a << 138;
 a << 141;
 a << 170;
 a << 208;
// spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "TFTF8" /*modg*/, "}c mn/tn/Tmt" /* lpf */, 16 * data.tick)  ;
 spork ~   PADS ("}c :8 :2 " + RAND.seq("1|3, F, 1|5, 3|2", 1) + "_" , 12, .3 ); 
 spork ~   SIN ("}c ____ ____ *8__" + RAND.char("87654321__",4) + "____:8 __ *8 " + RAND.char("87654321__",8) , .2 ); 
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*4 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   

   spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 2.6); 
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 " + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, " }c -8 " + RAND.seq("1__, *2,:2,*2,8/1,13,  2, 3/8, __, _,____,__,____", 16)," {c{c {c {cZTF8m" /* modf */, "}c ZZtZZ8Z1Z8ZTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   
 
 spork ~   PADS ("}c :8:2 " + RAND.seq("1|3, F, 1|5, 3|2", 1)+ "_" , 13, .2 ); 
   spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 4), 2.6); 
 spork ~   SIN ("}c}c ____ ____ *8__" + RAND.char("87654321__",4) + "____:8 __ *8 " + RAND.char("87654321__",8) , .2 ); 
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*4 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   

   spork ~   ONEP0 ("*4*2 }c }c" + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 12), 1.6); 
spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "* 4 }c -8 " + RAND.seq("1__, *2,:2,*2,8/1,13,  2, 3/8, __, _,____,__,____", 16)," {c{c {c {cZTF8m" /* modf */, "}c ZZtZZ8Z1Z8ZTT" /*modg*/, "}c g" /* lpf */, 16 * data.tick)  ;
 spork ~ MEGAMOD (a[Std.rand2(0, a.size() -1 )] /*137*/ , 23 /* nmod */, "*2 }c" + RAND.seq("1_1_, *2,:2,*2,8531,135, 4, 6, 2, 358, __, _", 16)," {c{c  ZTF8m" /* modf */, "ZZZtZZ88Z1Z8ZZZfTTTT" /*modg*/, "}c:4 g/11/FF/g" /* lpf */, 16 * data.tick)  ;
  16 * data.tick =>  w.wait;   
} 

//////////////////////////////////////////////////////////////////////////////////////////////////
fun void  THEME  (){ 
 spork ~ SSYNT0 ("   666_ __77 ____ 22__   8888  "); 
 spork ~ SSYNT1 ("}c 666_ __77 ____ 22__   8888  "); 
    32 * data.tick => w.wait;

 
 spork ~ SSYNT0 ("   666_ __77 ____ 22__   8888 __55 !33!22 !111_ "); 
 spork ~ SSYNT1 ("}c 666_ __77 ____ 22__   8888 __55 !33!22 !111_ "); 
    32 * data.tick => w.wait;
    //-------------------------------------------
} 
fun void  ACIDLOOP  (){ 
 for (0 => int i; i <   9    ; i++) {
   spork ~ ACID2 ("*4  " + RAND.seq("1_,*21_1_:2,+41_-4,!1!1,!3!1,1!5,!5_", 4)); 
   spork ~ ACID3 ("__*4  " + RAND.seq("1_,*21_1_:2,+41_-4,!1!1,!3!1,1!5,!5_", 4)); 
   4 * data.tick => w.wait;
   if(maybe) {
     spork ~ ACID2 ("*4  " + RAND.seq("1_,*21_1_:2,+41_-4,!1!1,!3!1,1!5,!5_", 1)); 
     spork ~ ACID3 ("_*4  " + RAND.seq("1_,*21_1_:2,+41_-4,!1!1,!3!1,1!5,!5_", 1)); 
     2 * data.tick => w.wait;
   } else {
     spork ~ ACID2 ("_*4  " + RAND.seq("*21!1!1_:2,+41_-4,!1!1,!3!1,1!5,!5_", 1)); 
     spork ~ ACID3 ("*4  " + RAND.seq("*21__1:2,+41_-4,!1!1,!3!1,1!5,!5_", 1)); 
     2 * data.tick => w.wait;
   }

   //-------------------------------------------
  }
} 
fun void  LOOPLAB  (){ 
  while(1) {
   //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
    //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
     if (0) {
     
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 m/o", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 o/s", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 s/t", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1!1!1!1!1_", ":8 t/z", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1      "); 
    8 * data.tick => w.wait;
    spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 2.6); 
    
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", "}c :8 t/z", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~   ONEP0 ("*4*2 }c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 2.6); 
     spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", "}c :8 z/m", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
 spork ~   SIN ("}c}c  *8__" + RAND.char("87654321__",4) + "____:8 __ *8 " + RAND.char("87654321__",8) , .4 ); 
  }
     while(1) {
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1!1 !1!1!1_", "}c :8 m/t", "9" ); 
//    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
//    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    }


    //-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
//LOOPLAB(); 


/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
 
  spork ~   MAIN_LOOP (); 


  spork ~ TRIBAL("*4    "+ RAND.seq("aaaa,bbb,cc__c,-5d}2d}4d}6d}8d}2",1) , 1 /* bank */, 1 /* tomix */, 0.27 /* gain */);
 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ ____ k_k_ kkkk  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////////////////////////////////////////////
  spork ~ TRIBAL("*4    "+ RAND.seq("ff_,*3:4ggg_,-7TT__",1) , 1 /* bank */, 1 /* tomix */, 0.33 /* gain */);

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

  // BREAK 0
  spork ~  KICK3 ("*4 k___ k___ k___ k___    "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1       "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_  "); 
  4 * data.tick =>  w.wait;   
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___  ", ":4M/f"); 
  spork ~  BASS0_HPF ("*4     __!1!1 __!1!1 __!1!1 __!1!1   ", ":4M/f"); 
  4 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////////////////////////////////////////
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
 


 spork ~   THEME (); 
//spork ~ ACID ("*4" + RAND.seq("1_,*21_1_:2,+41_-4,!1!1,!3!1,*2!1_5_:2,!5_", 3* 32 + 16 )); 
spork ~   ACIDLOOP   (); 


  spork ~ TRIBAL("*4    "+ RAND.seq("aaaa,bbb,cc__c,-5d}2d}4d}6d}8d}2",1) , 1 /* bank */, 1 /* tomix */, 0.27 /* gain */);

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   


//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ ____ k_k_ kkkk  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   

///////////////////////////////////////////////////////////////////////////////////////:
  spork ~ TRIBAL("*4    "+ RAND.seq("aaaa,bbb,cc__c,-5d}2d}4d}6d}8d}2",1) , 1 /* bank */, 1 /* tomix */, 0.27 /* gain */);
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_  __h_  S_h_ __h_ S_h_ "); 


  8 * data.tick =>  w.wait;   

//} if (0) {

  // BREAK 1
  spork ~  KICK3 ("*4 k___ k___ k___ k___  k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1 __!1!1 __!1!1  __    "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_  __h_  S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
 
spork ~ ACID ("*8 5_5_ 5_5_ 5_5_ 5_5_ 4_4_4_4_4_4_4_4_ 3_3_ 3_3_ 3_3_ 3_3_ 1_1_ 1_1_ 1_1_ 1_1_ " ); 

  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":8M/f"); 
  spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ", ":8M/f"); 

 8 * data.tick =>  w.wait;   
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

/////////////////////////////////////////////////////////////////////////////////////////////

    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 m/o", "9" ); 
//    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
//    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 o/s", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", ":8 s/t", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
    8 * data.tick => w.wait;
    spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1!1!1!1!1_", ":8 t/z", "9" ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1      "); 
    8 * data.tick => w.wait;
    for (0 => int i; i < 4      ; i++) {
        spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 2.6); 
        
        spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", "}c :8 t/z", "9" ); 
        spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
        spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
        8 * data.tick => w.wait;
        spork ~   ONEP0 ("*4*2 }c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 2.6); 
         spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1_ 1!1__", "}c :8 z/m", "9" ); 
        spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
        spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
        8 * data.tick => w.wait;
         spork ~   SIN ("}c}c  *8__" + RAND.char("87654321__",4) + "____:8 __ *8 " + RAND.char("87654321__",8) , .4 ); 
        spork ~ ACID3 ("*4 1__1 _1__ 1_1_ 1!1__ 1__1 _1__ 1_1!1 !1!1!1_", "}c :8 m/t", "9" ); 
        spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
        spork ~  BASS0 ("*4   __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1  __!1!1 __!1!1    "); 
        8 * data.tick => w.wait;
    }



}
