13 => int mixer;

KIK kik;
kik.config(0.3 /* init Sin Phase */, 28 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (236.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 14 * 10::ms);

kik.addGainPoint (0.5, 8::ms);
kik.addGainPoint (0.4, 30::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 16::ms); 

2::ms => kik.stop_dur;

fun void TRANCEBREAK(string seq) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.33 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 6. /* In Gain */, .10 /* Tresh */, .3 /* Slope */, 3::ms /* Attack */, 10::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}


fun void TRANCEBREAK0(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
//  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
// SEQ s3; SET_WAV.TRANCE(s3);
//
s.wav["k"] => s.wav["K"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .57 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  .69 => s.wav_o["K"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  // SUBWAV //// 
//  SEQ s2; SET_WAV.TRANCE_KICK(s2); s.add_subwav("K", s2.wav["K"]); 
//  s.gain_subwav("K", 0, .12);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 5. /* In Gain */, .10 /* Tresh */, .3 /* Slope */, 1::ms /* Attack */, 130::ms /* Release */ );      duckm $ ST @=>  last; 

//  STGAIN stgain;
//  stgain.connect(last $ ST , 0. /* static gain */  );       stgain $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
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
  s.gain("S", .12); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   1.1 => s.wav_o["S"].wav0.rate;
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


class syntBASS extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .5 => s.phase;
          } 0 => own_adsr;
}


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


//spork ~  TRANCEBREAK ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
fun void BASS (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.75 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 31 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 28*  .01/* Relative Decay */, 0.58 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
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

fun void BASS0 (string seq) {
  TONE t;
  t.reg(syntBASS s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//  "*4{c {c  _!1!1!1" => t.seq;
  "{c{c " + seq => t.seq;
  2.9 * data.master_gain => t.gain;
  t.no_sync();// s.element_sync(); //s.no_sync()
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(1::samp, data.tick *1/20, .5, data.tick *1/16);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(93 /* Base */, 40 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.001 /* Relative Attack */, .19/* Relative Decay */, 0.7 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  //STCOMPRESSOR stcomp;
  //7. => float in_gain;
  //stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
  //2.1 => stcomp.gain;

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 149.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
.2 => stbpfx0.gain;
//.3 => stbpfx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 55.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STADSR stadsr;
stadsr.set(27::samp /* Attack */, 12::ms /* Decay */, 0.7 /* Sustain */, -0.28,  15::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

//STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
//stbrfx0.connect(last $ ST ,  stbrfx0_fact, 238.0 /* freq */ , 1.7 /* Q */ , 2 /* order */, 1 /* channels */ );       stbrfx0 $ ST @=>  last;  

STBELL stbell0; 
stbell0.connect(last $ ST , 238 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, -0.5 /* Gain */ );       stbell0 $ ST @=>  last;   

//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

//  STDUCK duck;
//  duck.connect(last $ ST);      duck $ ST @=>  last; 


  //  STMIX stmix;
  //  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
fun void BASS3 (string seq) {
  TONE t;
  t.reg(syntBASS s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//  "*4{c {c  _!1!1!1" => t.seq;
  "{c{c " + seq => t.seq;
  0.15 * data.master_gain => t.gain;
  t.no_sync();// s.element_sync(); //s.no_sync()
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(1::samp, data.tick *1/20, .5, data.tick *1/16);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(73 /* Base */, 43 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.001 /* Relative Attack */, .22/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  //STCOMPRESSOR stcomp;
  //7. => float in_gain;
  //stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
  //2.1 => stcomp.gain;

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 11* 10.0 /* freq */ , 2.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
-.2 => stbpfx0.gain;
//.3 => stbpfx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 110.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

//  STDUCK duck;
//  duck.connect(last $ ST);      duck $ ST @=>  last; 


  //  STMIX stmix;
  //  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void BASS2 (string seq) {
  TONE t;
  t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .52 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 280.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void HIGH (string seq) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .14 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

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
50::ms => arp.t.glide;
"*4 1538123412315  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////
fun void SUPERHIGH (string seq) {
  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2 /* synt nb */ );
  // s0.set_chunk(0); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .28 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  // MOD ////////////////////////////////

//   SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
//   1::second / (13 * data.tick) => s.freq;
//   //   0 => s.phase;
//   Std.rand2f(0, 1) => s.phase;
//   0.2 => mod.freq;
// 
//   1.2 => o.offset;
//   5.7 => o.gain;
// 
///   ARP arp;
///   arp.t.dor();
///  // 50::ms => arp.t.glide;
///   "*8  1/8 1/3 8/1 1/8  " => arp.t.seq;
///   arp.t.go();   
///  
///  // CONNECT SYNT HERE
///  3 => s0.inlet.op;
///  arp.t.raw() => s0.inlet; 


  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration + now => time target;
    while(now < target) {
      s0.set_chunk(Std.rand2(0, 63)); 
        .5 * data.tick => now;
    }
}


//////////////////////////////////////////////////////////////////////////////////
fun void LEAD (string seq) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(1 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .45 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 3 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////



fun void  FROG  (float fstart, float fstop, float lpfstart, float lpfstop, dur d, float g){ 
    ST st; st $ ST @=> ST @ last;

    Step step => Envelope e0 => SqrOsc s => st.mono_in;
    1. => step.next;
    .15 => s.gain;

    fstart => e0.value;
    fstop => e0.target;
    d => e0.duration ;// => now;

    STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
    stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 

    g => stfreelpfx0.gain;

    Step step2 => Envelope e1 =>  stfreelpfx0.freq; // CONNECT THIS 
    lpfstart => e1.value;
    lpfstop => e1.target;
    d => e1.duration ;// => now;

    1. => step2.next;

    
    STHPF hpf;
    hpf.connect(last $ ST , 5 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

    STMIX stmix;
    stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    d => now;

} 

//////////////////////////////////////////////////////////////////////////////////
fun void PADS (string seq) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  s2.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .35 * data.master_gain => t.gain;
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

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCEHPF() {

    SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
    SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
    // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
    "K" => s.seq;
    .7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
    s.no_sync();// s.element_sync(); //s.no_sync()
  ; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  .7 => s.wav_o["K"].wav0.rate;
    // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
    //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
    s.go();     s $ ST @=> ST @ last; 

  //  STMIX stmix;
  //  stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 

  //  1::samp => now; // let seq() be sporked to compute length
  //  s.s.duration => now;

  STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.5 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 


  Step stp0 =>  Envelope e0 => stfreehpfx0.freq; // CONNECT THIS 
  1.0 => stp0.next;
  // HPF freq start value
  30.0 => e0.value; 

  // HPF freq target value
  11 * 100=> e0.target;
  
  // Rising duration
  16.0 * data.tick => e0.duration  => now;

  // HPF freq end value
  20 => e0.target;
  // Falling duration
  16.0 * data.tick => e0.duration  => now;


}

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV_ECH (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

STECHO ech;
ech.connect(last $ ST , data.tick * 8 / 4 , .6);  ech $ ST @=>  last; 

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() + 32* data.tick => now;
} 

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
////////////////////////////////////////////////////////////////////////////////////////////
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




////////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(10 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 


   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => st.gain;

   s0.on();

   d => now;

   s0.off();
   attackRelease => now;
    
} 


//////////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

143 => data.bpm;   (60.0/data.bpm)::second => data.tick;
57 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

fun void f1 (){ 
  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 
  WAIT w;
  1::samp => w.fixed_end_dur;
  //2 * data.tick =>  w.wait; 
  while(1) {
    spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 2* data.tick /* dur */, .25 /* gain */);
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
    spork ~   FROG(9 /* fstart */, 16 /* fstop */, 37 * 100 /* lpfstart */, 6 * 100 /* lpfstop */, 2* data.tick /* dur */, .25 /* gain */);
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
    spork ~  LEAD        ("*4 ____ ____ ____ 8__B 3232 1___ 88___"); 
    8 * data.tick =>  w.wait;      

  }
} 
//spork ~ f1 ();

fun void f2 (){ 
  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 
  WAIT w;
  1::samp => w.fixed_end_dur;
  //2 * data.tick =>  w.wait; 
  while(1) {
    spork ~   PADS (":6 1|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 5|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 1|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 0|2_"); 
    8 * data.tick =>  w.wait;      
  }
} 
//spork ~ f2 ();




fun void  LAB_LOOP  (){ 
  while(1) {
//  spork ~   PADS (":6 1|3_"); 
  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
//  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K_K_ KKKK *2KKKK *2KKKK KKKK:4 K__"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1___"); 
//  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__   _1__"); 
  8 * data.tick =>  w.wait;      
//  spork ~  TRANCEBREAK ("*4 ____ K___ K___ K___ K___ K_K_KKK_K_K__ "); 
//  8 * data.tick =>  w.wait;      



  }
} 
//LAB_LOOP();


///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"DTC_main.wav" => string name_main;
"DTC_aux.wav" => string name_aux;
8 * data.tick => dur main_extra_time;
8 * data.tick => dur end_loop_extra_time;
1.0 => float aux_out_gain;
1 => int end_loop_rec_once;

if ( !compute_mode && MISC.file_exist(name_main) && MISC.file_exist(name_aux)  ){

    

    LONG_WAV l;
    name_main => l.read;
    1.0 * data.master_gain => l.buf.gain;
    0 => l.update_ref_time;
    l.AttackRelease(0::ms, 10::ms);
    l.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

    LONG_WAV l2;
    name_aux => l2.read;
    aux_out_gain * data.master_gain => l2.buf.gain;
    0 => l2.update_ref_time;
    l2.AttackRelease(0::ms, 10::ms);
    l2.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

    STREVAUX strevaux;
    strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    // WAIT Main to finish
    l.buf.length() - main_extra_time  =>  w.wait;
    
    // END LOOP 
    ST stout;
  	SndBuf2 buf_end_loop_0; name_main+"_end_loop" => buf_end_loop_0.read; buf_end_loop_0.samples() => buf_end_loop_0.pos; buf_end_loop_0.chan(0) => stout.outl; buf_end_loop_0.chan(1) => stout.outr;
  	SndBuf2 buf_end_loop_1; name_main+"_end_loop" => buf_end_loop_1.read; buf_end_loop_1.samples() => buf_end_loop_1.pos; buf_end_loop_1.chan(0) => stout.outl; buf_end_loop_1.chan(1) => stout.outr;


  	SndBuf2 buf_end_loop_aux_0; name_aux+"_end_loop" => buf_end_loop_aux_0.read; buf_end_loop_aux_0.samples() => buf_end_loop_aux_0.pos; aux_out_gain => buf_end_loop_aux_0.gain;
  	SndBuf2 buf_end_loop_aux_1; name_aux+"_end_loop" => buf_end_loop_aux_1.read; buf_end_loop_aux_1.samples() => buf_end_loop_aux_1.pos; aux_out_gain => buf_end_loop_aux_1.gain;


    ST stauxout;
    buf_end_loop_aux_0.chan(0) => stauxout.outl;
    buf_end_loop_aux_0.chan(1) => stauxout.outr;

    buf_end_loop_aux_1.chan(0) => stauxout.outl;
    buf_end_loop_aux_1.chan(1) => stauxout.outr;

    strevaux.connect(stauxout $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    0 => int toggle;

    0 => data.next;

    while (!data.next) {

      <<<"**********">>>;
      <<<" END LOOP ">>>;
      <<<"**********">>>;

      if ( !toggle ) {
        1 => toggle;
        0 => buf_end_loop_0.pos;
        0 => buf_end_loop_aux_0.pos;
      } else {
        0 => toggle;
        0 => buf_end_loop_1.pos;
        0 => buf_end_loop_aux_1.pos;
          
      }
      
      // WAIT end loop to finish
      buf_end_loop_0.length() - end_loop_extra_time =>  w.wait;
    }

    // END
  	SndBuf2 buf_end_0; name_main+"_end" => buf_end_0.read; buf_end_0.samples() => buf_end_0.pos; buf_end_0.chan(0) => stout.outl; buf_end_0.chan(1) => stout.outr;

  	SndBuf2 buf_end_aux_0; name_aux+"_end" => buf_end_aux_0.read; buf_end_aux_0.samples() => buf_end_aux_0.pos; aux_out_gain => buf_end_aux_0.gain;
 
    buf_end_aux_0.chan(0) => stauxout.outl;
    buf_end_aux_0.chan(1) => stauxout.outr;
    
    0 => buf_end_0.pos;
    0 => buf_end_aux_0.pos;
    buf_end_0.length() =>  w.wait;
   
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

    

    
// INTRO

spork ~  SLIDESERUM1(2000 /* fstart */, 100 /* fstop */, 8* data.tick /* dur */,  .11 /* gain */); 
spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
8.2 * data.tick =>  w.wait;      

spork ~   SINGLEWAV("../_SAMPLES/DeepTCruise/magic.wav", .3); 
3.8 * data.tick =>  w.wait;      

// }
//while(1) { /********************************************************/

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~   PADS (":6 5|3_"); 
  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 3* data.tick /* dur */, .25 /* gain */);
  8 * data.tick =>  w.wait;      
//} if (0) {


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~   PADS (":6 0|2_"); 
  8 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////

 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
 spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
 spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
 spork ~   PADS (":6 1|3_"); 
 spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___");  8 * data.tick =>  w.wait;      
 

 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
 spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
 spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
 spork ~   PADS (":6 5|3_"); 
 spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 3* data.tick /* dur */, .25 /* gain */);
 8 * data.tick =>  w.wait;      


 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
 spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
 spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
 spork ~   PADS (":6 1|3_"); 
 spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
 8 * data.tick =>  w.wait;      


 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
 spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __"); 
 spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__    "); 
 spork ~   PADS (":6 0|2_"); 
 spork ~   FROG(9 /* fstart */, 16 /* fstop */, 37 * 100 /* lpfstart */, 6 * 100 /* lpfstop */, 2* data.tick /* dur */, .3 /* gain */);
  8 * data.tick =>  w.wait;   


//////////////////////////////////////////////////////////////////////////////

     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
   
     8 * data.tick =>  w.wait;      
     
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 5|3_"); 
     spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
     8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
      8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K ___"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS__ "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__    "); 
   //  spork ~   PADS (":6 0|2_"); 
     spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
     spork ~  HIGH        ("*3 ____ ____ ____ 8__B 3232 1___ 88___"); 
      8 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  spork ~   SINGLEWAV("../_SAMPLES/DeepTCruise/DTCcomp2_reduced.wav", .21); 
  spork ~   TRANCEHPF (); 
  spork ~   PADS (":6 1|3_"); 
  spork ~  HIGH        ("*3 ____ _8/1__ ___3 ____ 329_ ____ _1_4_"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 5|3_"); 
  spork ~  HIGH        ("*3 ____ ____ ____ R___ 3_32 ____ _____"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 1|3_"); 
  spork ~  HIGH        ("*3 ____ _1/4 ____ ____ _________ 88___"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 0|2_"); 
  spork ~  HIGH        ("*3 ____ _12_ __3_ 4__B 3242 1___ 08___"); 
  8 * data.tick =>  w.wait;     
  


///////////////////////////////////////////////////////////////////////////////

    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
    spork ~   PADS (":6 1|3_"); 
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
  
    8 * data.tick =>  w.wait;      
    
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
    spork ~   PADS (":6 5|3_"); 
    spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
    8 * data.tick =>  w.wait;      
  
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
    spork ~   PADS (":6 1|3_"); 
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
     8 * data.tick =>  w.wait;      
  
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__    "); 
    spork ~   PADS (":6 0|2_"); 
    spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
    spork ~  HIGH        ("*3 ____ ____ ____ 8__B 3232 1___ 88___"); 
     8 * data.tick =>  w.wait;   


  ///////////////////////////////////////////////////////////////////////////////::




    spork ~   SUPERHIGH (" *4 +5 4_3_4___4_3_3__24231 -5}c 423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423142314 {c +5 2313142423142 }c -5 3131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423_42__42__3_}c -5 4_4__14__131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K KK_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

    8 * data.tick =>  w.wait;   

    spork ~   SUPERHIGH ("}c *4 {c +5 4231 4231 4231 }c -5 4231 4231 4231}c -5 4231 4231  "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_   "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1_ "); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__    "); 

     8 * data.tick =>  w.wait;   




    spork ~   SUPERHIGH ("}c *4 4_3_4___4_3_3__2 {c +5 4231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 42314231423131424{c +5231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

    8 * data.tick =>  w.wait;   

 
    spork ~   SUPERHIGH ("}c *4 423_42__42__3_4_4{c +5__14__131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K KKKK"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS__ "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

    8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 4231 4231 4231 4231 {c +54231 4231 4231 4231  "); 
    spork ~  SLIDESERUM1(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */,  .11 /* gain */); 
    spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
    spork ~  TRANCEBREAK ("*4 ____ ____ ____ ____ K___ K_K_ K__K K_KK"); 

     8 * data.tick =>  w.wait;   



 /********************************************************/
  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
  spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
  spork ~   PADS (":6 5|3_"); 
  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 3* data.tick /* dur */, .25 /* gain */);
  8 * data.tick =>  w.wait;      
//} if (0) {


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
   spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
  spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
  spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
  spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
  spork ~   PADS (":6 0|2_"); 
  8 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////

     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
   
     8 * data.tick =>  w.wait;      
     
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 5|3_"); 
     spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
     8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
      8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K "); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS___ "); 
     spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __"); 
     spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__    "); 
   //  spork ~   PADS (":6 0|2_"); 
     spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
     spork ~  HIGH        ("*3 ____ ____ ____ 8__B 3232 1___ 88___"); 
      8 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    spork ~   SUPERHIGH ("}c *4 4231 4231 4231 4231 {c +54231 4231 4231 4231  "); 
    spork ~  SLIDESERUM1(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */,  .11 /* gain */); 
    spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
    spork ~  TRANCEBREAK ("*4 ____ ____ ____ ____ K___ K_K_ K__K K_KK"); 

     8 * data.tick =>  w.wait;   

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


0 => data.next;
while (!data.next) {

  <<<"********">>>;
  <<<"END LOOP">>>;
  <<<"********">>>;

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

    // As we are in rec mode, directly go out end loop
    1 => data.next;
  }
//////////////////////////////////////////////////


    spork ~   SUPERHIGH ("}c *4 4_3_4___4_3_3__2 {c +5 4231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 42314231423131424{c +5231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

 
    8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423_42__42__3_4_4{c +5__14__131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K KKKK"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

    8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 4231 4231 4231 4231 {c +54231 4231 4231 4231  "); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K_K_ KKKK *2 KKKK KKKK :2 "); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 __1!1 _8!1!1_"); 
    spork ~  BASS3       ("*4 _1__  _1__  _1__  _1__  _1__  _1__  _1__  "); 

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


// END
// REC  MAIN END LOOP /////////////////////////////////////////     
  STREC strecend;
  STREC strecendaux;
  if (rec_mode) {
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strecend.connect(last $ ST); strecend $ ST @=>  last;  
    0 => strecend.gain;
    strecend.rec_start(name_main +"_end", 0::ms, 1);
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

    strecendaux.connect(last $ ST); strecendaux $ ST @=>  last;  

    strecendaux.rec_start(name_aux + "_end", 0::ms, 1);
  }
//////////////////////////////////////////////////

// END
    spork ~   SINGLEWAV_ECH("../_SAMPLES/DeepTCruise/ahah.wav", .3); 
    spork ~  TRANCEBREAK ("*4 K___ "); 
     32 * data.tick =>  w.wait;   

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

 

