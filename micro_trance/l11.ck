21 => int mixer;
// Declare KIK outside funk 
KIK kik;
kik.config(0.1 /* init Sin Phase */, 20 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (1500.0, 2::ms);
kik.addFreqPoint (241.0, 2::ms);
kik.addFreqPoint (131.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 2::ms);
kik.addGainPoint (-0.5, 2::ms);
kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (0.7, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


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
//t.print();

STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 4::ms /* Attack */, 13::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  - 1::samp=> now;
}


///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRIBAL(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.ACOUSTIC(s3);
 s3.wav["H"] => s.wav["o"];  // act @=> s.action["a"]; 
 s3.wav["j"] => s.wav["j"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .7 * data.master_gain => s.gain; //
//
s.gain("j", .45); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   1.8 => s.wav_o["t"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 6. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

fun void TRANCESNR(string seq) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRIBAL(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.ACOUSTIC(s3);
 s3.wav["H"] => s.wav["o"];  // act @=> s.action["a"]; 
 s3.wav["j"] => s.wav["j"];  // act @=> s.action["a"]; 
 s3.wav["T"] => s.wav["s"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .7 * data.master_gain => s.gain; //
//
s.gain("s", .5); // for single wav 
   1.33 => s.wav_o["s"].wav0.rate;
s.gain("j", .45); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   1.8 => s.wav_o["t"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 6. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//spork ~  TRANCESNR ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 


//spork ~  TRANCEBREAK ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.243 =>p.phase; } 1 => own_adsr;
} 



fun void BASS (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2217 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"" + seq => t.seq;
0.75 * data.master_gain => t.gain;
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
stsynclpfx0.freq(11 * 10 /* Base */, 54 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 58*  .01/* Relative Decay */, 0.37 /* Sustain */, .19 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,192 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 
//STOVERDRIVE stod;
//stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
//1.0 =>stod.gain;


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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


class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

// From BASS12
fun void BASS2 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 31 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STDELAY2 stdelay2; // Stereo simple delay + passthrough
stdelay2.connect(last $ ST , 12::ms /* delay right */, 15::ms /* delay left */, 0.3 /* delay gain */ );       stdelay2 $ ST @=>  last;   


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}




fun void BASS7 (string seq) {
  TONE t;
  t.reg(PSYBASS7 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .92 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(4::ms, 19::ms, .8, 87::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 170.1 /* freq */ , 1.2 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS2 (string seq) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2322 /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  2.89 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(4::ms, 19::ms, .8, 214::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 3 * 100 /* Variable */, 2. /* Q */);
  stsynclpfx0.adsr_set(.01 /* Relative Attack */, .2/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 1 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 277.1 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void DIST (string seq) {
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.01 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 0.98 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 2. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.2 /* GAIN */, 3. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
//  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .18 * data.master_gain => t.gain;
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


//////////////////////////////////////////////////////////////////////////////////
fun void DISTMOD (string seq) {
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.01 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 0.98 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 2. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.2 /* GAIN */, 3. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
//  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .32 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  // MOD ////////////////////////////////

  STMIX stmix;
  stmix.send(last, mixer + 1);
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
  .40 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


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
  [ 40 , 12 ,18 ] @=> int ar[]; // 12 18
  while(now < target) {
      s0.set_chunk(ar[Std.rand2(0, ar.size() - 1)]); 
        .5 * data.tick => now;
    }
}


//////////////////////////////////////////////////////////////////////////////////

// MOD LEAD
TriOsc tri0 =>  MULT m => Gain modLead;
83.0 => tri0.freq;
126.0 => tri0.gain;
0.2 => tri0.width;

SinOsc sin0 => OFFSET ofs0 => m;
1. => ofs0.offset;
1. => ofs0.gain;
0.1 => sin0.freq;
1.0 => sin0.gain;


fun void LEAD (string seq, float g) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(1 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

// MOD 
  modLead => s0.inlet;


//ARP arp;
//arp.t.dor();
//50::ms => arp.t.glide;
//" 18F1818F811F81  " => arp.t.seq;
//arp.t.go();   

// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 3 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 3 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//  

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * Std.rand2(5, 9) / 1 /* period */, Std.rand2f(0,1) /* phase 0..1 */ );       autopan $ ST @=>  last; 

STMIX stmix;
  stmix.send(last, mixer);
//  stmix.receive(11); stmix $ ST @=> ST @ last; 

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
fun void PADS (string seq, int nb, float v) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, nb /* FILE */, 100::ms /* UPDATE */); 
  s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, nb /* FILE */, 100::ms /* UPDATE */); 
  s2.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, nb /* FILE */, 100::ms /* UPDATE */); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .05 /* mix */, 12 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 0.7 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////
fun void SYNT1 (string seq) {
  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(25 /* synt nb */ , 1.8 /* GAIN */, 2.0 /* in freq gain */,  1 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
//  s0.add(25 /* synt nb */ , 0.4 /* GAIN */, 0.5 /* in freq gain */,  200::ms /* attack */, 2 * data.tick /* decay */, 0.2 /* sustain */, 2* data.tick /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .04 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 12 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 53 * 100 /* Variable */, 2. /* Q */);
stsynclpfx0.adsr_set(.4 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STMIX stmix;
stmix.send(last, mixer + 0);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
fun void PLOC (string seq, float v) {
  TONE t;
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 12 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

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
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 2 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 


  Step stp0 =>  Envelope e0 => stfreehpfx0.freq; // CONNECT THIS 
  1.0 => stp0.next;
  // HPF freq start value
  4.0 => e0.value; 

  // HPF freq target value
  11 * 100=> e0.target;
  
  // Rising duration
  16.0 * data.tick => e0.duration  => now;

  // HPF freq end value
  4 => e0.target;
  // Falling duration
  16.0 * data.tick => e0.duration  => now;


}

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV_SPECIAL  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STMIX stmix;
   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV_SPECIAL("../_SAMPLES/", .4); 

////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STMIX stmix;
   stmix.send(last, mixer);
   
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

fun void  SINGLEWAVFLANG  (string file, float r, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  STFLANGER flang;
  flang.connect(last $ ST); flang $ ST @=>  last; 
  flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  109::ms /* dur base */, 49::ms /* dur range */, 1 /* freq */); 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   3.5 * data.tick => now;
   s.samples() => s.pos;
   4.5 * data.tick => now;
} 

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 



////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAVFLANG2  (string file, float r, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  STFLANGER flang;
  flang.connect(last $ ST); flang $ ST @=>  last; 
  flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  35::ms /* dur base */, 24::ms /* dur range */, 1 /* freq */); 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   3.5 * data.tick => now;
   s.samples() => s.pos;
   4.5 * data.tick => now;
} 

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 

////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAVFLANG3  (string file, float r, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  STFLANGER flang;
  flang.connect(last $ ST); flang $ ST @=>  last; 
  flang.add_line(2 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */,  35::ms /* dur base */, 24::ms /* dur range */, 1 /* freq */); 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;
   (s.samples() * 0.63 ) $ int  => s.pos;

   4.5 * data.tick => now;
   s.samples() => s.pos;
   4.5 * data.tick => now;
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
   s0.add(23 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(27 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 

  SinOsc sin0 => MULT m =>  s0;
  e0 => m;
  13.0 => sin0.freq;
  6.0 => sin0.gain;



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

////////////////////////////////////////////////////////////////////////////////////////////
fun void  RANDSERUMMOD  (int n, string begin, int nb, float g){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
    if ( p > .4) {
      ["1", "1", "3", "5", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }
    else if (  p > .2  ){
      ["2", "4", "6", "7" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }
    else {
      ["{c 5 }c", "{c 7 }c" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(SERUM0 s0); s0.config(n,0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


  // MOD 
//   SinOsc sin0 => OFFSET ofs0 => s0.inlet;
//   250. => ofs0.offset;
//   1. => ofs0.gain;
// 
//   1.4 => sin0.freq;
//   200.0 => sin0.gain;
// 
//   Std.rand2f(0, 1.) => sin0.phase;


 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration => now;
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

}  

//spork ~   RANDSERUMMOD ("}c *8 ", Std.rand2(8, 16));   4 * data.tick =>  w.wait; 

////////////////////////////////////////////////////////////////////////////////////////////


class syntRand extends SYNT{
    inlet => SinOsc s =>  outlet; 
    .5 => s.gain;

     fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void  RAND  (string begin, int nb){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
      ["1", "1", "f", "F", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(syntRand s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .25 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration => now;
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 
////////////////////////////////////////////////////////////////////////////////////////////
SinOsc mod1 =>  blackhole;
10.0 =>mod1.freq;
68.0 => mod1.gain;

fun void  SERUM2MOD  (string seq ){ 



  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(0 /* synt nb */ );
  // s0.set_chunk(0); 

  mod1 => s0.inlet;

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .48 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  ARP arp;
  arp.t.dor();
  50::ms => arp.t.glide;
  "f/FF//f " => arp.t.seq;
  arp.t.go();   

  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

STLIMITER stlimiter;
6. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last; 
.4 => stlimiter.gain; 

 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration + now => time end;
  while(end > now) {
    Std.rand2(10, 100) =>mod1.freq; Std.rand2(10, 100) => mod1.gain; 
    Std.rand2(0,63) => int n1;
    s0.set_chunk(n1);
    data.tick  => now;
  }
   
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 





////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////

fun void  RANDSERUM  (string begin, int nb){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
      ["1", "1", "f", "F", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(0 /* synt nb */ );
  // s0.set_chunk(0); 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .53 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 




 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration + now => time end;
  while(end > now) {
    s0.set_chunk(Std.rand2(0,63));
    data.tick / 4 => now;
  }
   
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 





////////////////////////////////////////////////////////////////////////////////////////////

TriOsc mod0 =>  blackhole;
10.0 =>mod0.freq;
68.0 => mod0.gain;


fun void  RANDMOD  (string begin, int nb){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
      ["1", "1", "f", "F", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(syntRand s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .4 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

mod0 => s0;

 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration => now;
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 
//spork ~  RAND("*4 }c" /* Seq begining */ , 12 /* Nb rand elements */ ); 
//////////////////////////////////////////////////////////////////////////////////////////////////

fun void  ACID  (string seq, int synt_nb, float g){ 
   TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(synt_nb /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 29 * 100 /* Variable */, 5. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.00001 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 



  STMIX stmix;
  stmix.send(last, mixer);
//  stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
  
} 

////////////////////////////////////////////////////////////////////////////////////////////

fun void NIAP (string seq, int synt_nb , dur decay_dur, float decay_curve, float v) {

  TONE t;
  t.reg(SERUM00 s0);   s0.config(synt_nb/* synt nb */ ); 
  t.reg(SERUM00 s1);   s1.config(synt_nb/* synt nb */ ); 
  t.reg(SERUM00 s2);   s2.config(synt_nb/* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
//  t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, decay_dur, .0002, 400::ms);
t.set_adsrs_curves(2.0, decay_curve, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


  STMIX stmix;
  stmix.send(last, mixer + 2);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}


// spork ~   NIAP (" _1|2|3__ ____", 0 /*synt_nb  */, 200::ms /* decay_dur */, 2.0 /* decay_curve */,  .2 /* gain */); 

////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE (string seq, dur gldur, int synt_nb , float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(synt_nb/* synt nb */ ); 
  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 7 * 100 /* freq base */, 11 * 100 /* freq var */, data.tick * 17 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 50::ms /* glide dur */, .19 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////////

fun void  FROG  (float fstart, float fstop, float lpfstart, float lpfstop, dur d, float g){ 
    ST st; st $ ST @=> ST @ last;

    Step step => Envelope e0 => SqrOsc s => st.mono_in;
    1. => step.next;
    .2 => s.gain;

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

////////////////////////////////////////////////////////////////////////////////////////
SYNC sy;
sy.sync(1 * data.tick);

148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 -12 => data.ref_note;


WAIT w;
1::samp => w.fixed_end_dur;


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
.65 => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

//STECHO ech3;
//ech3.connect(last $ ST , data.tick * 3 / 4 , .80);  ech3 $ ST @=>  last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 4 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  


STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .95);  ech2 $ ST @=>  last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 10 * 100 /* freq base */, 37 * 100 /* freq var */, data.tick * 23  /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STCOMPRESSOR stcomp;
7. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 800::ms /* releaseTime */);   stcomp $ ST @=>  last;   
.8 => stcomp.gain;

STAUTOPAN autopan2;
autopan2.connect(last $ ST, .4 /* span 0..1 */, data.tick * 7 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 





fun void  LAB_LOOP  (){ 
   
while(1) {
 

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ KKK_ "); 
//  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4   __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
//  spork ~   RANDSERUMMOD (25," }c}c *4 ", 32, .2);
  8 * data.tick =>  w.wait;   



}
}
//LAB_LOOP();


// INTRO
if ( 1 ) {
  spork ~   SINGLEWAV_SPECIAL("../_SAMPLES/HighMaintenance/LaTolerance.wav", 0.4); 
  spork ~   RANDSERUMMOD (23, "}c *8 ", 8 *10, .2);
  10 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV_SPECIAL("../_SAMPLES/HighMaintenance/EnprendreDeuxJours.wav", 0.4); 
  spork ~   RANDSERUMMOD (33,"}c *8 ", 8 *10, .2);

//} if (1) {


  spork ~  SLIDENOISE  (100, 12000, 11 * data.tick, 0, .2);
  spork ~  SLIDESERUM1  (100, 12000, 11 * data.tick,  .4);

  12 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ __K_ "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~ SERUM2MOD (" }c ___1 __11"); 
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (24,"____ }c}c *4 ", 16, .4);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ __K_ "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~ SERUM2MOD (" ___1 1__1"); 
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (26,"____ }c}c *4 ", 16, .4);
  8 * data.tick =>  w.wait;   


  spork ~  KICK ("*4 K___ K___ K_K_ K_K_ KKKK KKKK *2 KKKK KKKK *2 KKKK KKKK KKKK KKKK  "); 
  spork ~  SLIDENOISE  (100, 12000, 8 * data.tick, 0, .2);
  spork ~  SLIDESERUM1  (100, 12000, 8 * data.tick,  .4);
  8 * data.tick =>  w.wait;   


}

/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

  spork ~ SINGLEWAVFLANG  ("../_SAMPLES/HighMaintenance/LaTolerance.wav", 1., .11);

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8  1_1_ 1  "); 

  spork ~   RANDSERUMMOD (24,"____ }c}c *4 ", 16, .4);

  spork ~ SERUM2MOD (" }c ___1 __11"); 
  8 * data.tick =>  w.wait;   

//} if (0) {

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c 1_1_ 1  "); 
  spork ~   RANDSERUMMOD (23, "____ }c *8 ", 16, .2);
  spork ~ SERUM2MOD (" }c __8/1 __*41_1_1_1_"); 
  8 * data.tick =>  w.wait;   

  spork ~ SINGLEWAVFLANG2  ("../_SAMPLES/HighMaintenance/EnprendreDeuxJours.wav", 1.0, .11);

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4 }5 __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c 5_1_ 1  "); 
  spork ~   RANDSERUMMOD (24,"____ }c *8 ", 16, .3);
  spork ~ SERUM2MOD (" 8////1 *41_1_1_1_"); 
  8 * data.tick =>  w.wait;   

 spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4 }5 __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c1_1_ 1_ 1_1_ 1  "); 
  spork ~   RANDSERUMMOD (33,"____ }c *4 ", 16, .2);
  spork ~ SERUM2MOD (" 8//FF//1  }c*41___1_1_1_1_"); 
  8 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////////////////////////
  // La puissance
   spork ~ SINGLEWAVFLANG3  ("../_SAMPLES/HighMaintenance/EnprendreDeuxJours.wav", 1.0, .12);


  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8  1_1_ 1  "); 

  spork ~   RANDSERUMMOD (25,"____ }c *8*2 ", 32, .3);
  spork ~ SERUM2MOD ("  }c*4 1_1__1_1_1__8531"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c 1_1_ 1  "); 
  spork ~   RANDSERUMMOD (28,"____ }c *8 ", 32, .4);
  spork ~ SERUM2MOD ("  }c ___F/f __*4 853185318531"); 
  8 * data.tick =>  w.wait;   


  // La puissance
  spork ~ SINGLEWAVFLANG3  ("../_SAMPLES/HighMaintenance/EnprendreDeuxJours.wav", 1.3, .14);

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4 }5 __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c 5_1_ 1  "); 
  spork ~   RANDSERUMMOD (32,"____ }c *8 ", 32, .3);
  spork ~ SERUM2MOD (" 8//FF//1  }c*41___1_1_1_1_"); 
  8 * data.tick =>  w.wait;   

 // La puissance
  spork ~ SINGLEWAVFLANG3  ("../_SAMPLES/HighMaintenance/EnprendreDeuxJours.wav", 1.5, .15);


  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 __j_ __j_ __j_ __j_ __j_ __j_ __j_ __jj  "); 
  spork ~  BASS        ("*4 }5 __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~  DIST        ("*8 }c1_1_ 1_ 1_1_ 1  "); 
  spork ~   RANDSERUMMOD (25,"____ }c}c *8*2 ", 32, .3);
  spork ~ SERUM2MOD (" 8////1 *41_1_1_1_"); 
  8 * data.tick =>  w.wait;   

   spork ~  SLIDENOISE   (12000, 100, 8 * data.tick, 0, .2);
  spork ~  SLIDESERUM1  (12000, 100, 8 * data.tick,  .4);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 ____ K___ K_K_ K_K_ KKKK KKKK *2 KKKK KKKK *2 KKKK KKKK KKKK KKKK  "); 
  spork ~ SERUM2MOD (" 8////1 *41_1_1_1_"); 
  8 * data.tick =>  w.wait;   



   
  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (24," }c}c *4 ", 32, .4);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K_K_ __K_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (25," }c}c *4 ", 32, .2);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (26," }c}c *4 ", 32, .3);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ KKK_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (24," }c}c *4 ", 32, .4);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (25," }c}c *4 ", 32, .2);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K_K_ __K_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (26," }c}c *4 ", 32, .3);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (24," }c}c *4 ", 32, .4);
  8 * data.tick =>  w.wait;   

  spork ~  KICK ("*4 K___ K___ K___ K___ K___ K___ K___ KKK_ "); 
  spork ~  TRANCESNR ("*4 __j_ s_j_ __j_ s_j_ __j_ s_j_ __j_ s_jj  "); 
  spork ~  BASS        ("*4  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  __!1!1  "); 
  spork ~   RANDSERUMMOD (25," }c}c *4 ", 32, .2);
  8 * data.tick =>  w.wait;   



}


