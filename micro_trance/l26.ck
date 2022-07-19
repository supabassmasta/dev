10 => int mixer;
/////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 17 * 100 /* init freq env */, 0.4 /* init gain env */);
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
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.36 * data.master_gain => t.gain;
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
stod.connect(last $ ST, 7.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.33 => stod.gain;

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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.204 =>p.phase; } 1 => own_adsr;
} 

fun void BASS15 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2217 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.55 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 49 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 57*  .01/* Relative Decay */, 0.25 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,95 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS15_HPF (string seq, string hpfseq) {


TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2217 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.55 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 50 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 60*  .01/* Relative Decay */, 0.25 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2330 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
stsynclpfx0.freq(11 * 10 /* Base */, 58 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.22 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//ADSRMOD adsrmod; // Direct ADSR freq input modulation
//adsrmod.adsr_set(0.01 /* relative attack dur */, 0.03 /* relative decay dur */ , 0.6 /* sustain */, - 0.3 /* relative release pos */, .3 /* relative release dur */);
//adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
//adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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

fun void BASS0_HPF(string seq, string hpfseq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2330 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
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
stsynclpfx0.freq(11 * 10 /* Base */, 58 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.22 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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


/////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////


class SERUM00X1 extends SYNT{

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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.11 =>p.phase; } 1 => own_adsr;
}
fun void BASS1 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2328 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.0 * data.master_gain => t.gain;
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
stsynclpfx0.freq(11 * 10 /* Base */, 60 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.22 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

ADSRMOD adsrmod; // Direct ADSR freq input modulation
adsrmod.adsr_set(0.01 /* relative attack dur */, 0.09 /* relative decay dur */ , 0.1 /* sustain */, - 0.3 /* relative release pos */, .3 /* relative release dur */);
adsrmod.padsr.setCurves(1., 0.8, 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STADSR stadsr;
stadsr.set(1::ms /* Attack */, 3::ms /* Decay */, 0.9 /* Sustain */, -0.25 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 4 * 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



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
   ech.connect(last $ ST , data.tick * 6 / 4 , .84);  ech $ ST @=>  last; 
   
   STAUTOPAN autopan;
   autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 7 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

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
  .16 * data.master_gain => t.gain;
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
  .14 * data.master_gain => t.gain;
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
////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

153 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

//STREVAUX strevaux;
//strevaux.connect(last $ ST, .1 /* mix */); strevaux $ ST @=>  last;  

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


fun void  LOOPLAB  (){ 
  while(1) {
//  spork ~  SINGLEWAVECHOFAT("../_SAMPLES/owl/owl6.wav", 0.6 , 32* data.tick); 
//// spork ~ TRANCE ("kkkk kkkk kkkk kkkk"); 
  spork ~ KICK3 ("kkkk kkkk kkkk kkkk"); 
//  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _8/1_1_1_1 _1_1_1_1 "); 
//  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
//  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~ TRANCEHH ("*2 _h_h_h_h _h_h_h_h  _h_h_h_h _h_h_h_h"); 
  spork ~  BASS1 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  16 * data.tick =>  w.wait; 
  }
} 

LOOPLAB();


///////////////////// PLAYBACK/REC /////////////////////////

1 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"Owl_main.wav" => string name_main;
"Owl_aux.wav" => string name_aux;
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

 if (0) {
 }   /// MAGIC



// INTRO

    
  spork ~  SLIDE(200 /* fstart */, 1000 /* fstop */, 3.5* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
  4 * data.tick =>  w.wait; 



/********************************************************/
  spork ~ KICK3 ("kkkk kkkk kkkk kkkk"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c{c{c __F//f f/F___ __d/D_ ____ ");
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3 ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c{c f/F_F//f f/F___ __d/D_ ____ ");
 
  16 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------


  spork ~ KICK3 ("kkkk kkkk kkkk kkkk"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c{c{c __f/FF/f f/F___ __d/D_ ____ ");
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3 ("kkkk kkkk kkkk __*4_____kkk:4"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __  "); 
  spork ~ SQR("{c{c{c f/FF/f f/D___ __d/D_ ____ ");
 


  12 * data.tick =>  w.wait; 
  spork ~  SLIDE(200 /* fstart */, 1500 /* fstop */, 4.0* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
 
  4 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------

  spork ~ KICK3 ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
 

  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ KICK3 ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
 

  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------

  spork ~ KICK3 ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
 

  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3 ("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
 

  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("      U___    ", 0 /* bank */, 1 /* tomix */, 0.41 /* gain */);
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
  spork ~ KICK3 ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
 

  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
 

  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 


//---------------------------------------------------------------------------

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
 

  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
 

  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("*4  X_ ____   ", 0 /* bank */, 1 /* tomix */, 0.50 /* gain */);
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------

0 => data.next;

while (!data.next) {

  <<<"**********">>>;
  <<<" DIDGE LOOP ">>>;
  <<<"**********">>>;

  spork ~ KICK3("kkkk kkkk kkkk kkkk"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
 
  16 * data.tick =>  w.wait; 
}
 

  spork ~ KICK3("kkkk kkkk kkkk k___ "); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1  __!1!1 __!1!1 __!1!1 __!1!1 __  "); 


 
  4.4 * data.tick =>  w.wait; 
  7.6 * data.tick =>  w.wait; 

  spork ~  SLIDE(1500 /* fstart */, 200 /* fstop */, 4.0* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
 
  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c *2  f_f_f/F_F_F/m ");
  spork ~ SUPERHIGH ("____ ____*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_  "); 

   16 * data.tick =>  w.wait; 
 
  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c *2  f/F___ F/ff/F__ __F//1 1/m___ *2 f_f_ _f_");
  spork ~ SUPERHIGH ("____ ____*8}c}c  8181 8181 8181 8181 8181 8181 8181 8181 8F18F18F18F18F18F1   "); 

   16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ SQR("{c{c *4  8_5_1_f/M_ 8_5_1_f/M_ !8!5!1!f/M!8!5!1!f/M!8!5!1!f/M!8!5!1!f/M ");
  spork ~ SUPERHIGH ("____ ____*8}c}c 5431 5431 5431 5431 5431 5431 5431 5431   "); 

   16 * data.tick =>  w.wait; 


 
  spork ~ KICK3("kkkk kkkk kkkk "); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh "); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 ___    "); 
  spork ~ SQR("{c{c *8    !8_5_1_f/M_ 8_5_1_f/M_ }c !8_5_1_f/M_ 8_5_1_f/M_  }c !8_5_1_f/M_ 8_5_1_f/M_ }c !8_5_1_f/M_ 8_5_1_f/M_ ");
  spork ~ SUPERHIGH ("____ ____*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_  "); 
   12 * data.tick =>  w.wait; 
  spork ~  SLIDE(500 /* fstart */, 2200 /* fstop */, 4.0* data.tick /* dur */, .5 /* width */, .05 /* gain */); 
   4 * data.tick =>  w.wait; 
 

// ------------------------------------------------------------------


  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 


  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("      U___    ", 0 /* bank */, 1 /* tomix */, 0.41 /* gain */);
  4 * data.tick =>  w.wait; 




// ------------------------------------------------------------------

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 


//---------------------------------------------------------------------------



  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("*4  X_ ____   ", 0 /* bank */, 1 /* tomix */, 0.50 /* gain */);
  4 * data.tick =>  w.wait; 


0 => data.next;

while (!data.next) {

  <<<"**********">>>;
  <<<" DIDGE LOOP ">>>;
  <<<"**********">>>;

  spork ~ KICK3("kkkk kkkk kkkk kkkk"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ TRIBAL("____ __*4    "+ RAND.seq("xx__,a_a_,HH__,I___,LLL_,{4LLL_,{4L}6LL_,{4M}4M__,}4M}4MM_",1) +":4 _ ____ __   "+ RAND.seq("xx__,a_a_,HH__,I___,LLL_,{4LLL_,{4L}6LL_,{4M}4M__,}4M}4MM_",1), 0 /* bank */, 1 /* tomix */, 0.44 /* gain */);
 
  16 * data.tick =>  w.wait; 
}


  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("      U___    ", 0 /* bank */, 1 /* tomix */, 0.41 /* gain */);
  4 * data.tick =>  w.wait; 
 
//---------------------------------------------------------------------------
 spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kk*4k_k_kkkk:4 ____ ____"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 
//---------------------------------------------------------------------------

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////

  
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

    // As we are in rec mode, directly go out end loop
    1 => data.next;
  }
//////////////////////////////////////////////////


  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __d/D_ ____ ");

   16 * data.tick =>  w.wait; 
 
  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR("{c{c{c{c __G/f_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl5.wav", .4); 
  4 * data.tick =>  w.wait; 

//---------------------------------------------------------------------------
  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~ PLOC("1___ ___B 1___ ____ ");
  spork ~ SIN(" }c __*4 8765 4321 :4 ____ ____ ____ ");
  spork ~ SQR("{c{c{c{c ____ ____ __D/dd/D ____ ");

  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kk*4kk_k_kkk:4 ____"); 
  spork ~ TRANCEHH ("*2_hsh_hsh _hsh_hsh _s_T ____ ____ __*2 ss_T :2"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~ PLOC("1___ ___3 1___ ____ ");
  spork ~ SIN(" }c __*4 8756 3421 :4 ____ ____ ____");
  spork ~ SQR(" {c{c{c{c __G/z_ ____ ____ ____ ");

  12 * data.tick =>  w.wait; 
  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  4 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH2 ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kk*4k_k_kkkk:4 ____ ____"); 
  spork ~  BASS0 ("*4  __!1!1 __!1!1 __!1!1 __!1!1   __!1!1 __!1!1 __!1!1 __!1!1 __8//1_   "); 
  spork ~   SUPERHIGH2 ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ {c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_"); 
 
  16 * data.tick =>  w.wait; 

  spork ~ KICK3("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRANCEHH ("*2 _hsh_hsh _hsh_hsh  _hsh_hsh _hsh_s_T"); 
  spork ~  BASS0 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    "); 
  spork ~   SUPERHIGH ("*8}c}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_*2 1_1_1_1_ :2 1_1_ {c 1_1_ __1_ 1_1_ __1_ *2 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ "); 
 
  16 * data.tick =>  w.wait; 



  
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



  spork ~  SINGLEWAVECHOFAT("../_SAMPLES/owl/owl6.wav", 0.6 , 32* data.tick); 
//  spork ~   SINGLEWAV("../_SAMPLES/owl/owl6.wav", .4); 
  spork ~ KICK3("k___"); 

 48 * data.tick =>  w.wait; 



  
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}


