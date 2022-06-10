21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (117.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (0.8, 10::ms);
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

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3_HPF(string seq, string hpfseq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (117.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (0.8, 10::ms);
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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.52 =>p.phase; } 1 => own_adsr;
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
  s0.config(2331 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  0.8 * data.master_gain => t.gain;
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
  stsynclpfx0.freq(12 * 10 /* Base */, 74 * 10 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


  STADSR stadsr;
  stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.32 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2331 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.8 * data.master_gain => t.gain;
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
stsynclpfx0.freq(12 * 10 /* Base */, 74 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.32 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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

///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
  SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
//   s.wav["T"]=> s.wav["u"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  1.1 * data.master_gain => s.gain; //
  s.gain("S", 3.0); // for single wav 
  s.gain("T", 3.0); // for single wav 
  if(seq.find('S') != -1 )  1.5 => s.wav_o["S"].wav0.rate; // s.out("k") /* return ST */
  //s.sync(4*data.tick);// s.element_sync(); //
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();   //  s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
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
    stmix.send(last, mixer);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);
////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
fun void TEK_VARIOUS(string seq, int tomix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  
    SET_WAV.TEK_VARIOUS(s);
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

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE_GAIN (string seq, int n, float lpf_f,  dur gldur, float v, string seq_gain) {

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


  STFREEGAIN stfreegain;
  stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
  AUTO.gain(seq_gain) => stfreegain.g; // connect this

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE3 (string seq, int n, float lpf_f,  dur gldur, float v) {

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
//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  STMIX stmix;
  stmix.send(last, mixer + 3);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE (string seq, int n, float lpf_f,  dur gldur, float v, dur d) {
  <<<"SEQ SYNTGLIDE: ", seq>>>;

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
  stmix.send(last, mixer + 2);

  d => now;

}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE2 (string seq, int n, float lpf_f,  dur gldur, float v, dur d) {

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
  stmix.send(last, mixer + 1);

  d => now;

}



////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////

fun void ACID (string seq, int n,  dur gldur, float v, dur d) {
  <<<"SEQ SYNTGLIDE: ", seq>>>;

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

  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(66 /* Base */, 80 * 100 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, 0.4 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STMIX stmix;
 stmix.send(last, mixer + 1);

  d => now;

}



////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

// MOD

    SinOsc sin0 =>  OFFSET ofs0 => blackhole;
    1. => ofs0.offset;
    130. * 100=> ofs0.gain;

    .1 => sin0.freq;
    1.0 => sin0.gain;



fun void ACID2 (string seq, int n,  dur gldur, float v, dur d) {
  <<<"SEQ SYNTGLIDE: ", seq>>>;

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

  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(66 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
  stsynclpfx0.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, 0.4 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //   
  ofs0 => stsynclpfx0.nio.padsr; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 8 / 1 /* period */, Std.rand2f(0., 1.)/* phase 0..1 */ );       autopan $ ST @=>  last; 

 STMIX stmix;
 stmix.send(last, mixer + 1);

  d => now;

}

fun void ACID3 (string seq, int n,  dur gldur, float v) {
  <<<"SEQ SYNTGLIDE: ", seq>>>;

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

// MOD
  TriOsc tri0 =>  s0.inlet;
  2 * 10.0 => tri0.freq;
  11 * 10 => tri0.gain;
  0.5 => tri0.width;


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(66 /* Base */, 78 * 100 /* Variable */, 2.4 /* Q */);
  stsynclpfx0.adsr_set(.1 /* Relative Attack */, .4/* Relative Decay */, 0.4 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //   
//  ofs0 => stsynclpfx0.nio.padsr; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 7 * 100 /* freq base */, 68 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
3. => stautoresx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 0);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;

}



////////////////////////////////////////////////////////////////////////////////////////////


fun void  MODU2 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
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
stmix.send(last, mixer );
//stmix.receive(11); stmix $ ST @=> ST @ last; 

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////


fun void  MODU3 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
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
stmix.send(last, mixer  + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////



fun void  MODU4 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
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

//STMIX stmix;
//stmix.send(last, mixer  + 0);

STREVAUX strevaux;
strevaux.connect(last $ ST, .11 /* mix */); strevaux $ ST @=>  last;  
//STMIX stmix;
//stmix.send(last, mixer  + 1);

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU5 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
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

//STMIX stmix;
//stmix.send(last, mixer  + 0);

//STREVAUX strevaux;
//strevaux.connect(last $ ST, .11 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer  + 2);

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
fun void PADS (string seq) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.1 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
  s1.config(.1 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 5 /* FILE */, 100::ms /* UPDATE */); 
  s2.config(.1 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 5 /* FILE */, 100::ms /* UPDATE */); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .58 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .05 /* mix */, 12 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

//  STDUCK duck;
//  duck.connect(last $ ST);      duck $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  9::ms /* dur base */, 7::ms /* dur range */, .3 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  8::ms /* dur base */, 7::ms /* dur range */, .2 /* freq */); 

STMIX stmix;
stmix.send(last, mixer );
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



/////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer + 1);
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
fun void ACOUSTICTOM(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ ACOUSTICTOM("*4 AA_B B_CC _DD_ SKKS ");

/////////////////////////////////////////////////////////////////////////////////////////
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
    stmix.send(last, mixer + 1);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  

STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .85);  ech $ ST @=>  last; 


STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 


STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 5 * 100 /* freq base */, 19 * 100 /* freq var */, data.tick * 15 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan("1////855//18/18/55") => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .3);  ech2 $ ST @=>  last; 

STREVAUX strevaux2;
strevaux2.connect(last $ ST, .2 /* mix */); strevaux2 $ ST @=>  last;  

STMIX stmix4;
stmix4.receive(mixer + 3); stmix4 $ ST @=>  last; 

STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.3 /* depth */, 0.7 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.6 /* Q */, 8 * 100 /* freq base */, 26 * 100 /* freq var */, data.tick * 15 / 2 /* modulation period */, 2 /* order */, 2 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STREVAUX strevaux3;
strevaux3.connect(last $ ST, .2 /* mix */); strevaux3 $ ST @=>  last;  


// TEST
//Std.atoi("15")  => int i;
//<<<"i", i>>>;




150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
54 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

fun void  LOOP_LAB  (){ 
    
    while(1) {
    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
 
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
//    spork ~ ACID3 ("*8   f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_  f_f_ _1__ 1_8_     "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 10 * 0.01 /* gain */);
//    spork ~ ACID3 ("*8   8_8_8_8_ __ f_1_ _1__1_1_1_    "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 10 * 0.01 /* gain */);

//    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
//    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
//   spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
//   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  
    }
} 
//spork ~   LOOP_LAB (); 
// LOOP_LAB (); 

// INTRO
if ( 0  ){
    
   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___k___ k___ k___ k___ k___ k___ k___ k___   ", ":8 f//F"); 
   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f//F"); 

16 * data.tick =>  w.wait;   
}

/********************************************************/
//if (    0     ){

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

// --------------------------------------------------------------------------------------------------
//                                    THEME
// --------------------------------------------------------------------------------------------------

  spork ~   MODU3 (2, "____ *4 m/F " , "*4f/5", "F", 4 *1000, .10); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    f*2 _35_ :28__11_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
   spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
   spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
   spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   


// --------------------------------------------------------------------------------------------------
   spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 71 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .14 /* gain */, "1///////8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
  spork ~   MODU3 (18, "{c ____ *4 f///FFF " , "5//r", "i", 4 *1000, .12); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    1*2 _35_ :28__ff_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
 
  spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 6 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 14::ms /* glide dur */, .15 /* gain */, "8///////1" /* seq_gain */ );
   spork ~ SYNTGLIDE_GAIN("*8 }c   1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 8 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .13 /* gain */, "1///////8" /* seq_gain */ );

   spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ ____ ___ _____  "); 
   spork ~  KICK3_HPF ("*4 ____ ____ ____ ____ ____ k_k_ k_k_k_k_   ", " ____ _F///f"); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __    "); 
//   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f/F"); 

  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
  8 * data.tick =>  w.wait;   

// --------------------------------------------------------------------------------------------------
//                                     END THEME
// --------------------------------------------------------------------------------------------------

//}if ( 0  ){

for (0 => int i; i < 4 ; i++) {
 
//   spork ~ SYNTGLIDE("*4 " +  RAND.seq("321,A01,345,765,51,58,_,_,__,1,8",8) /* seq */, 3 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 34::ms /* glide dur */, .29 /* gain */, 7 * data.tick);
   spork ~ SYNTGLIDE("*4 {c " +  RAND.seq("321,A01,345,765,51,58,_,_,__,1,8",8) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .17 /* gain */, 7 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
   spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
   
spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 14* data.tick /* dur */, .1 /* width */, .03 /* gain */); 
   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___k___ k___ k___ k___ k___ k___ k___ k___   ", ":8 f//F"); 
   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f//F"); 
   spork ~ SYNTGLIDE("*4 {c " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*2) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .17 /* gain */, 16 * data.tick);
   spork ~ SYNTGLIDE("*4  " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*2) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .17 /* gain */, 16 * data.tick);

16 * data.tick =>  w.wait;   

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    spork ~ ACID ("*8 {c " +  RAND.seq("!1_!1_,!1_,_,!8,!f",5) /* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 9 * 0.01 /* gain */, 2 * data.tick);
    spork ~ SYNTGLIDE2("____ *8 }c  " +  RAND.seq("*2,_,__,_,_,_,8/1,F/8,f/1,1/8,f/F,8//1,F//f",32) /* seq */, 55 /* Serum00 synt */,  9 * 1000 /* lpf_f */, 34::ms /* glide dur */, .04 /* gain */, 7 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__kk__  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1_   "); 
    8 * data.tick =>  w.wait;  


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    spork ~ ACID ("*8 {c " +  RAND.seq("!1_!1_,!1_,_,!8,!f",5) /* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 9 * 0.01 /* gain */, 2 * data.tick);
    spork ~ SYNTGLIDE2("____ *8 }c  " +  RAND.seq("*2,_,__,_,_,_,8/1,F/8,f/1,1/8,f/F,8//1,F//f",32) /* seq */, 55 /* Serum00 synt */,  9 * 1000 /* lpf_f */, 34::ms /* glide dur */, .04 /* gain */, 7 * data.tick);

    spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_k___  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    8 * data.tick =>  w.wait;  


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    spork ~ ACID ("*8 {c " +  RAND.seq("!1_!1_,!1_,_,!8,!f",5) /* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 9 * 0.01 /* gain */, 2 * data.tick);
    spork ~ SYNTGLIDE2("____ *8 }c  " +  RAND.seq("*2,_,__,_,_,_,8/1,F/8,f/1,1/8,f/F,8//1,F//f",32) /* seq */, 55 /* Serum00 synt */,  9 * 1000 /* lpf_f */, 34::ms /* glide dur */, .04 /* gain */, 7 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__kk__  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  





// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    spork ~ ACID ("*8 {c " +  RAND.seq("!1_!1_,!1_,_,!8,!f",5) /* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 9 * 0.01 /* gain */, 2 * data.tick);
    spork ~ SYNTGLIDE2("____ *8 }c  " +  RAND.seq("*2,_,__,_,_,_,8/1,F/8,f/1,1/8,f/F,8//1,F//f",32) /* seq */, 55 /* Serum00 synt */,  9 * 1000 /* lpf_f */, 34::ms /* glide dur */, .04 /* gain */, 7 * data.tick);

    spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_kkk_  "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  


// --------------------------------------------------------------------------------------------------
//                                    THEME
// --------------------------------------------------------------------------------------------------

  spork ~   MODU3 (2, "____ *4 m/F " , "*4f/5", "F", 4 *1000, .10); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    f*2 _35_ :28__11_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
   spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
   spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
   spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   


// --------------------------------------------------------------------------------------------------
   spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 71 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .14 /* gain */, "1///////8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
  spork ~   MODU3 (18, "{c ____ *4 f///FFF " , "5//r", "i", 4 *1000, .12); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    1*2 _35_ :28__ff_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
 
  spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 6 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 14::ms /* glide dur */, .15 /* gain */, "8///////1" /* seq_gain */ );
   spork ~ SYNTGLIDE_GAIN("*8 }c   1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 8 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .13 /* gain */, "1///////8" /* seq_gain */ );

   spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ ____ ___ _____  "); 
   spork ~  KICK3_HPF ("*4 ____ ____ ____ ____ ____ k_k_ k_k_k_k_   ", " ____ _F///f"); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __    "); 
//   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f/F"); 

  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
  8 * data.tick =>  w.wait;   

// --------------------------------------------------------------------------------------------------
//                                     END THEME
// --------------------------------------------------------------------------------------------------


 

 // (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
 
//    spork ~   MODU4 (18, "  *8   1_1_1_1_ __1_1_1_ ____ 1_1_  ____ ____  1_1_1_1_ __1_1_1_  1_1_1_1_ __1_1_1_" , "TMF", "W", 27 *100, .27); 
    spork ~   MODU4 (18, " ____  *8  " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 4) , RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 27 *100, .27); 
//    spork ~   MODU4 (9, "  *8 {c " +  RAND.seq("  ___1_1__, _1___1__, ____ _1_1,  ____ ____,  ___1_1_1,  ___1_1_1,  _1_1_1_1,", 9) , RAND.char("TMF",5), "W", 27 *100, .27); 

    spork ~ ACID2 ("*8 {c  8_1_1_8_1_1_1_1_ "/* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 6 * 0.01 /* gain */, 2 * data.tick);

    spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
   spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  

 // (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
 
//    spork ~   MODU4 (18, "  *8   1_1_1_1_ __1_1_1_ ____ 1_1_  ____ ____  1_1_1_1_ __1_1_1_  1_1_1_1_ __1_1_1_" , "TMF", "W", 27 *100, .27); 
    spork ~   MODU4 (18, " ____  *8  " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 4) , RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 27 *100, .27); 
//    spork ~   MODU4 (9, "  *8 {c " +  RAND.seq("  ___1_1__, _1___1__, ____ _1_1,  ____ ____,  ___1_1_1,  ___1_1_1,  _1_1_1_1,", 9) , RAND.char("TMF",5), "W", 27 *100, .27); 

    spork ~ ACID2 ("*8 {c  8_1_1_8_1_1_1_1_ "/* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 6 * 0.01 /* gain */, 2 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj   "); 
   spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ ___ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    8 * data.tick =>  w.wait;  

 // (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
 
//    spork ~   MODU4 (18, "  *8   1_1_1_1_ __1_1_1_ ____ 1_1_  ____ ____  1_1_1_1_ __1_1_1_  1_1_1_1_ __1_1_1_" , "TMF", "W", 27 *100, .27); 
    spork ~   MODU4 (18, " ____  *8  " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 4) , RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 27 *100, .27); 
//    spork ~   MODU4 (9, "  *8 {c " +  RAND.seq("  ___1_1__, _1___1__, ____ _1_1,  ____ ____,  ___1_1_1,  ___1_1_1,  _1_1_1_1,", 9) , RAND.char("TMF",5), "W", 27 *100, .27); 

    spork ~ ACID2 ("*8 {c  8_1_1_8_1_1_1_1_ "/* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 6 * 0.01 /* gain */, 2 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
   spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  

 // (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
 
//    spork ~   MODU4 (18, "  *8   1_1_1_1_ __1_1_1_ ____ 1_1_  ____ ____  1_1_1_1_ __1_1_1_  1_1_1_1_ __1_1_1_" , "TMF", "W", 27 *100, .27); 
    spork ~   MODU4 (18, " ____  *8  " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 4) , RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 27 *100, .27); 
//    spork ~   MODU4 (9, "  *8 {c " +  RAND.seq("  ___1_1__, _1___1__, ____ _1_1,  ____ ____,  ___1_1_1,  ___1_1_1,  _1_1_1_1,", 9) , RAND.char("TMF",5), "W", 27 *100, .27); 

    spork ~ ACID2 ("*8 {c  8_1_1_8_1_1_1_1_ "/* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 6 * 0.01 /* gain */, 2 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj   "); 
   spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ ___ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    8 * data.tick =>  w.wait;  

////////////////////////////////////////////////////////////////////////////////////////////////////////////////:


spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 14* data.tick /* dur */, .1 /* width */, .03 /* gain */); 
   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___k___ k___ k___ k___ k___ k___ k___ k___   ", ":8 f//F"); 
   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f//F"); 
   spork ~ SYNTGLIDE("*4*2 {c " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);
   spork ~ SYNTGLIDE("*4*2  " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);

16 * data.tick =>  w.wait;   


for (0 => int i; i < 3 ; i++) {
//    spork ~   PADS (":6  F|D|F_"); 


    spork ~   MODU5 (30, " *4*3 {c{c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 
    spork ~   MODU5 (Std.rand2(31,36) , " ____ *4*3 {c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 

//    spork ~ ACID2 ("*8 {c  8_1_1_8_1_1_1_1_ "/* seq */, 6 /* Serum00 synt */,  34::ms /* glide dur */, 6 * 0.01 /* gain */, 2 * data.tick);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
    8 * data.tick =>  w.wait;  
}

 

spork ~  SLIDENOISE(8000 /* fstart */, 200 /* fstop */, 8* data.tick /* dur */, .1 /* width */, .04 /* gain */); 

spork ~   MODU5 (30, " *4*3 {c{c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 
    spork ~   MODU5 (Std.rand2(31,36) , " ____ *4*3 {c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 

    8 * data.tick =>  w.wait;  

///////////////////////////////////////////////////////////////////////////////////////

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    8 * data.tick =>  w.wait;  

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    8 * data.tick =>  w.wait;  

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick =>  w.wait;  

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick =>  w.wait;  

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick =>  w.wait;  

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick =>  w.wait;  

    for (0 => int i; i < 4      ; i++) {

      spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
      spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
      spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k___  "); 
      spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
      spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
      spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
      8 * data.tick =>  w.wait;  
    }



//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/


///////////////////////// END LOOP ///////////////////////////////////::
0 => data.next;

while (!data.next) {

  <<<"**********">>>;
  <<<" END LOOP ">>>;
  <<<"**********">>>;


  for (0 => int i; i < 8      ; i++) {

    spork ~ SYNTGLIDE3("*4     8351 8351 8351 8351 8351 8351 8351 8351 8351   " /* seq */, 39 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 17::ms /* glide dur */, .15 /* gain */ );
    spork ~ ACID3 ("*8   8_1_1_8_ 1_1_1_1_  8_1_1_8_ 1_1_8_ 1_1_f_ 8_1_f_ 1_1_1_1_  1_1_1_1_ 1_1_1_1_   "/* seq */, 2663 /* Serum00 synt */,  34::ms /* glide dur */, 8 * 0.01 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k___  "); 
    spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  S|T_h_ __h_ S|T_h_ __h_ S|T_h_ __h_ S|T_h_ "); 
    spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    8 * data.tick =>  w.wait;  
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___k___  ", ":4 F/ff/F"); 
   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":4  F/ff/F"); 

spork ~  SLIDENOISE(8000 /* fstart */, 200 /* fstop */, 8* data.tick /* dur */, .1 /* width */, .04 /* gain */); 

spork ~   MODU5 (30, " *4*3 {c{c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 
    spork ~   MODU5 (Std.rand2(31,36) , " ____ *4*3 {c{c " +  RAND.seq(" 1_1_1_1_, __1_1_1_, ____ 1_1_,   1_1_1_1_, __1_1_1_,  1_1_1_1_, __1_1_1_", 6) , "}c" + RAND.seq("*2TMF:2,*4MFT:4,*2FTFM:2,*4FMTM:4",5), "W", 38 *100, .34); 

    8 * data.tick =>  w.wait;  

// --------------------------------------------------------------------------------------------------
//                                    THEME
// --------------------------------------------------------------------------------------------------

  spork ~   MODU3 (2, "____ *4 m/F " , "*4f/5", "F", 4 *1000, .10); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    f*2 _35_ :28__11_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
   spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  S|T_h_ __h_ S|T_h_ __h_ S|T_h_ __h_ S|T_h_ "); 
   spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   


// --------------------------------------------------------------------------------------------------
   spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 71 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .14 /* gain */, "1///////8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  S|T_h_ __h_ S|T_h_ __h_ S|T_h_ __h_ S|T_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
  spork ~   MODU3 (18, "{c ____ *4 f///FFF " , "5//r", "i", 4 *1000, .12); 
  spork ~ SYNTGLIDE_GAIN("*4 }c    1*2 _35_ :28__ff_   " /* seq */, 56 /* Serum00 synt */,  4 * 1000 /* lpf_f */, 14::ms /* glide dur */, .16 /* gain */, "8" /* seq_gain */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj jjjj jjjj  "); 
    spork ~  TRANCEHH ("*4  __h_  S|T_h_ __h_ S|T_h_ __h_ S|T_h_ __h_ S|T_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
8 * data.tick =>  w.wait;   
// --------------------------------------------------------------------------------------------------
 
  spork ~ SYNTGLIDE_GAIN("*8    1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 6 /* Serum00 synt */,  2 * 1000 /* lpf_f */, 14::ms /* glide dur */, .15 /* gain */, "8///////1" /* seq_gain */ );
   spork ~ SYNTGLIDE_GAIN("*8 }c   1_1_1_1_1_1_1_1_  1_1_1_1_1_1_1_1_   1_1_1_1_1_1_1_1_   " /* seq */, 8 /* Serum00 synt */,  3 * 1000 /* lpf_f */, 14::ms /* glide dur */, .13 /* gain */, "1///////8" /* seq_gain */ );

   spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ ____ ___ _____  "); 
   spork ~  KICK3_HPF ("*4 ____ ____ ____ ____ ____ k_k_ k_k_k_k_   ", " ____ _F///f"); 
   spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __    "); 
//   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f/F"); 

  spork ~  TRANCEHH ("*4 -4 jjjj jjjj jjjj jjjj jjjj jjjj   "); 
  spork ~  TRANCEHH ("*4  __h_  S|T_h_ __h_ S|T_h_ __h_ S|T_h_ __h_ S|T_h_ "); 
  spork ~ TEK_VARIOUS("*4 __a_ ____ __b_ ____ __c_ ____ ___N__", 0 /* tomix */, .15 /* gain */);
  8 * data.tick =>  w.wait;   

// --------------------------------------------------------------------------------------------------
//                                     END THEME
// --------------------------------------------------------------------------------------------------
spork ~  SLIDENOISE(3000 /* fstart */, 200 /* fstop */, 14* data.tick /* dur */, .1 /* width */, .04 /* gain */); 
   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___k___ k___ k___ k___ k___ k___ k___ k___   ", ":8 f//F"); 
   spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    ", ":8 f//F"); 
   spork ~ SYNTGLIDE("*4*2 {c " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);
   spork ~ SYNTGLIDE("*4*2  " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);

   16 * data.tick =>  w.wait;   


}

spork ~ SYNTGLIDE("*4*2 {c " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);
spork ~ SYNTGLIDE("*4*2  " +  RAND.seq("321,A01,345,765,51,58,,,,1,8",8*4) /* seq */, 6 /* Serum00 synt */,  5 * 1000 /* lpf_f */, 34::ms /* glide dur */, .23 /* gain */, 16 * data.tick);

   16 * data.tick =>  w.wait;   

