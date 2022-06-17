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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.36 =>p.phase; } 1 => own_adsr;
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


fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", 1.7); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   if(seq.find('S') != -1 ) 0.8 => s.wav_o["S"].wav0.rate;
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

////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU5 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.lyd();
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
stmix.send(last, mixer  + 0);

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU6 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
t.lyd();
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
stmix.send(last, mixer  + 1);

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SERUM01SEQ (int nb, string seq, string seq_cut , string seq_g , dur d, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.lyd();
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1.3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
AUTO.freq(seq_cut) => stfreelpfx0.freq; // CONNECT THIS 

STFREEGAIN stfreegain;
stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
AUTO.gain(seq_g) => stfreegain.g; // connect this 

STMIX stmix;
stmix.send(last, mixer  + 0);

d => now; // let seq() be sporked to compute length
}

// spork ~   SERUM01SEQ (80, "*8 "  + RAND.char("1115588324",Std.rand2(3,7)) , ":8:2 M/m" , ":8:2 8/8" , 16 * data.tick,  .6 );
/////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SERUM01X (int nb, string seq, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.lyd();
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


//AUTO.freq(modf) =>  SinOsc sin0 => MULT m => s0.inlet;
//AUTO.freq(modg) =>  m;


STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, cut /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STMIX stmix;
//stmix.send(last, mixer  + 0);

//STREVAUX strevaux;
//strevaux.connect(last $ ST, .11 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer  + 0);

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
/////////////////////////////////////////////////////////////////////////////////////////

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


// spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 

////////////////////////////////////////////////////////////////

fun int file_exist (string filename){ 
  FileIO fio;
  fio.open( filename, FileIO.READ );
  if( !fio.good() )
    return 0;
  else {
    fio.close();
    return 1;
  }
} 

fun void  AMB1  (int idx, string seq, float playback_gain){ 
  "ambl44_"+ idx + ".wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    playback_gain * data.master_gain  => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
    s1.config(.25 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 19 /* FILE */, 100::ms /* UPDATE */); 
    s2.config(.25 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 20 /* FILE */, 100::ms /* UPDATE */); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    seq => t.seq;
    .4 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer);

    t.s.duration + 2::ms => now;


  }

} 
//  spork ~   AMB1 ( 0 /* idx */, ":4 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 

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
////////////////////////////////////////////////////////////////////////////////////////////


class syntRand extends SYNT{
    inlet => SinOsc s =>  outlet; 
    .5 => s.gain;

     fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void  Rand  (string begin, int nb){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
      ["1", "1", "f", "F", "8", "5", "c", "3", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(syntRand s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .15 * data.master_gain => t.gain;
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

fun void  SERUM2  (string seq ){ 



  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(0 /* synt nb */ );
  // s0.set_chunk(0); 

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .32 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


 STMIX stmix;
 stmix.send(last, mixer  + 1 );
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



////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
56 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  


STMIX stmix1;
stmix1.receive(mixer + 1); stmix1 $ ST @=>last; 
//
STAUTOPAN autopan1;
autopan1.connect(last $ ST, .2 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan1 $ ST @=>  last; 


STREVAUX strevaux1;
strevaux1.connect(last $ ST, .15 /* mix */); strevaux1 $ ST @=>  last;  


fun void  LOOP_LAB  (){ 
while(1) {
  spork ~   MODU5 (Std.rand2(121, 125), RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .40); 
//spork ~   SERUM01SEQ (796, "*4  834251" , ":8:2 M/p" , ":8:2 8/8" , 16 * data.tick,  .5 );
//  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
//  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
 2 * 8 * data.tick =>  w.wait;   
     
}


} 
//LOOP_LAB();


///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"l44_main.wav" => string name_main;
"l44_aux.wav" => string name_aux;
8 * data.tick => dur main_extra_time;
8 * data.tick => dur end_loop_extra_time;
1.0 => float aux_out_gain;
1 => int end_loop_rec_once;

if ( !compute_mode && MISC.file_exist(name_main) && MISC.file_exist(name_aux)  ){

//if ( 0  ){
    

    LONG_WAV l;
    name_main => l.read;
    1.0 * data.master_gain => l.buf.gain;
    0 => l.update_ref_time;
    l.AttackRelease(0::ms, 10::ms);
    l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

    LONG_WAV l2;
    name_aux => l2.read;
    aux_out_gain * data.master_gain => l2.buf.gain;
    0 => l2.update_ref_time;
    l2.AttackRelease(0::ms, 10::ms);
    l2.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

    STREVAUX strevaux;
    strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    // WAIT Main to finish
    l.buf.length() - main_extra_time =>  w.wait;
//}
    
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
if ( 0  ){

} /////////////// MAGIC ///////////////////////////


  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  8 * data.tick =>  w.wait;   

    spork ~   MODU5 (25, " f/T__ ", " f/T", "M", 114 *100, .34); 
  8 * data.tick =>  w.wait;   

    spork ~   MODU5 (125, "*2 M/ff//T__ ", " f/T", "M", 114 *100, .34); 
  8 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(252 /* fstart */, 3000 /* fstop */, 15* data.tick /* dur */, .8 /* width */, .11 /* gain */); 

    spork ~   SERUM01X (22, " f/T__ ", 114 *100, .34); 
  8 * data.tick =>  w.wait;   
   spork ~   SERUM01X (138, " *4 F18_    ", 23 *100, .40); 
  8 * data.tick =>  w.wait;   


  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
     




/********************************************************/

  spork ~   SERUM01X (122, "}c *4 8_1_1_1__F_  ", 114 *100, .34); 
  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 

  spork ~   SERUM01X (127, " *4 8_1_1_1__F_  ", 23 *100, .17); 
  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
  8 * data.tick =>  w.wait;   
  spork ~   SERUM01X (22, " f/T__ ", 114 *100, .34); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 

  spork ~   SERUM01X (122, "}c *4 8_1_1_1__F_  ", 114 *100, .34); 
  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
  8 * data.tick =>  w.wait;   


  spork ~   SERUM01SEQ (796, "*4  185f" , ":8:2 M/p" , ":8:2 8/7" , 16 * data.tick,  .4 );

  spork ~   SERUM01X (127, " *4 8_1_1_1__F_  ", 23 *100, .17); 
  
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   

 ///////////////////////////////////////////////////////////////////////////:
  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  ", ":8M/f"); 
  spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ", ":8M/f"); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(252 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .08 /* gain */); 
  4 * data.tick =>  w.wait;   
  
  ///////////////////////////////////////////////////////////////////////////:


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
   8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU5 (25, " f/T__ ", " f/T", "M", 114 *100, .34); 
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
   spork ~   SERUM01X (138, " *4 F18F18__    ", 23 *100, .40); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ __k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   



    spork ~   MODU5 (274, "*2 f_m_f_ff_  ", " M", "f", 114 *100, .16); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   SERUM01X (138, " *4 F18_  ", 23 *100, .40); 
   spork ~   SERUM01X (137, " *4 }c  81F_  ", 23 *100, .40); 
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU5 (275, "*4 f_m_f_ff_  ", " M", "f", 144 *100, .22); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ __k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   


  ///////////////////////////////////////////////////////////////////////////:

spork ~   SERUM01SEQ (796, "*4  834251" , ":8:2 M/p" , ":8:2 8/7" , 16 * data.tick,  .4 );

//spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___   ", ":8M/ff/M"); 
  spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    ", ":8M/ff/M"); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU5 (123, "*2 M/ff//T__ ", " f/T", "M", 130 *100, .34); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(152 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .12 /* gain */); 
  4 * data.tick =>  w.wait;   
  
  ///////////////////////////////////////////////////////////////////////////:

for (0 => int i; i <  4     ; i++) {
    // FRENETIK
    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .13); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}

    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .13); 
spork ~   SERUM01SEQ (796, "*4  834251" , ":8:2 M/p" , ":8:2 8/7" , 16 * data.tick,  .4 );
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___   ", ":8M/ff/M"); 
  spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    ", ":8M/ff/M"); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU5 (123, "*2 f////T__ ", " T/f", "a", 130 *100, .40); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(152 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .12 /* gain */); 
  4 * data.tick =>  w.wait;   

  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
for (0 => int i; i <  4     ; i++) {
    // FRENETIK
  spork ~   MODU5 (Std.rand2(121, 125), RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .40); 
    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .13); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}

  spork ~   AMB1 ( 1 /* idx */, ":4:4 8|1|8_" , 0.7 /* g */ );  
for (0 => int i; i <  4     ; i++) {
    // FRENETIK
  spork ~   MODU5 (Std.rand2(121, 125), RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .40); 
    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .13); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}

  ///////////////////////////////////////////////////////////////////////////:

spork ~   SERUM01SEQ (796, "*4  834251" , ":8:2 M/p" , ":8:2 8/7" , 16 * data.tick,  .4 );

//spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___   ", ":8M/ff/M"); 
  spork ~  BASS0_HPF ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1    __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_    ", ":8M/ff/M"); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU5 (123, "*2 M/ff//T__ ", " f/T", "M", 130 *100, .34); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(152 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .12 /* gain */); 
  4 * data.tick =>  w.wait;   
  
  ///////////////////////////////////////////////////////////////////////////:

  
  spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
for (0 => int i; i <  4     ; i++) {
    // FRENETIK
  spork ~   MODU5 (Std.rand2(121, 125),"}c" + RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .28); 
  spork ~   MODU5 (Std.rand2(146, 146), RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .40); 
//    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .13); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}


  spork ~   AMB1 ( 1 /* idx */, ":4:4 8|1|8_" , 0.7 /* g */ );  
for (0 => int i; i <  4     ; i++) {
    // FRENETIK
  spork ~   MODU5 (Std.rand2(121, 125),"}c" + RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .27); 
  spork ~   MODU5 (Std.rand2(50, 51), "{c" + RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " f/Tf/TT/f", "a", 84 *100, .25); 
  spork ~   MODU6 (75, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ }c " + RAND.seq("f_m_,f_f_,f_  f_,m_f_,f_f_ ,f_m_ ", 6), " M", "1", 53 *100, .10); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}


spork ~   SERUM01SEQ (796, "*4  834251" , ":8:4 M/f" , ":8:2 8/5" , 32 * data.tick,  .4 );

for (0 => int i; i <  4     ; i++) {
    // FRENETIK
  spork ~   MODU5 (Std.rand2(121, 125),"}c" + RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " T/f", "a", 154 *100, .27); 
  spork ~   MODU5 (Std.rand2(50, 51), "{c" + RAND.seq("_,__,___, , ",1) + RAND.seq("F/f,M/a,b/G,*2,:2",3) , " f/Tf/TT/f", "a", 84 *100, .25); 
  spork ~   MODU6 (75, "*8  "+ RAND.seq("f_m_,f_f_,f_  f_,m_f_,f_f_ ,f_m_ ", 8) + " }c " + RAND.seq("f_m_,f_f_,f_  f_,m_f_,f_f_ ,f_m_ ", 6), " *2 {c{c{c{9 " + RAND.seq("M/f,f/M,*2f/MM/f:2,*2", 8), "f", 53 *100, .10); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
}

  spork ~  KICK3 ("*4 k___   "); 

  8 * data.tick =>  w.wait;   

///////////////////////////////////////////////////////////////////////////////////////

  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   


  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/ALaireElectronique.wav", .3); 

for (0 => int i; i <  7     ; i++) {

  spork ~  Rand(" *4 }c" /* Seq begining */ , 16 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
}

  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/Modem56K.wav", .30); 

  spork ~  KICK3 ("*4 ____ ____ k_k_ k_K_ kkkk kkkk *2 kkkk kkkk kkkk kkkk :2 "); 

  8 * data.tick =>  w.wait;   
/////////////////////////////////////////////////////////////////////////////////////////////////

for (0 => int i; i <  8     ; i++) {
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
}


  spork ~   SERUM01SEQ (50, "*4  f85f031" , ":8:4 M/z" , ":8:4 8/7" , 30 * data.tick,  .2 );
//  32 * data.tick =>  w.wait;   

for (0 => int i; i <  3     ; i++) {
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
}


  spork ~  KICK3 ("*4 k___ ____ ____ ____ ____ ____ ____ k_k_   "); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(252 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .10 /* gain */); 
  4 * data.tick =>  w.wait;   

  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   


  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/CPlibertepasnegociable.wav", .3); 

for (0 => int i; i <  3     ; i++) {

  spork ~  Rand(" *4 }c" /* Seq begining */ , 16 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  8 * data.tick =>  w.wait;   
}   


  spork ~  Rand(" *4 }c" /* Seq begining */ , 16 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k_k_ k_K_ kkkk kkkk *2 kkkk kkkk kkkk kkkk :2 "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __   "); 
  8 * data.tick =>  w.wait;   

spork ~   SINGLEWAV("../_SAMPLES/bitcoin/PreserverSaViePrivee.wav", .3); 

for (0 => int i; i <  7     ; i++) {

  spork ~  Rand(" *4 }c" /* Seq begining */ , 16 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
}


  spork ~  Rand(" *4 }c" /* Seq begining */ , 16 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k_k_ k_K_ kkkk kkkk *2 kkkk kkkk kkkk kkkk :2 "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __   "); 
  8 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////////////////////////////////

for (0 => int i; i <  4     ; i++) {
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
}


  spork ~   SERUM01SEQ (50, "*4  f85f031" , ":8:4 M/z" , ":8:4 8/7" , 30 * data.tick,  .2 );
//  32 * data.tick =>  w.wait;   

for (0 => int i; i <  3     ; i++) {
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
  8 * data.tick =>  w.wait;   
}

  spork ~  KICK3 ("*4 k___ ____ ____ ____ ____ ____ ____ k_k_   "); 
  4 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(252 /* fstart */, 3000 /* fstop */, 3* data.tick /* dur */, .8 /* width */, .10 /* gain */); 
  4 * data.tick =>  w.wait;   

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
  

//for (0 => int i; i <  4     ; i++) {
  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/CPecriventDuCode.wav", .3); 
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~   SERUM2 ("*8}c  _1_1___1___1_5_1_1___1___1_5_3_1_ }c _1___1__1___1_1_ 1_3_5_1___5_3_1 " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~   SERUM2 ("*8}c  _1_1___1___1_5_1_1___1___1_5_3_1_ }c _1___1__1___1_1_ 1_3_5_1___5_3_1 " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~   SERUM2 ("*8}c  _1_1___1___1_5_1_1___1___1_5_3_1_ }c _1___1__1___1_1_ 1_3_5_1___5_3_1 " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
  
  spork ~   SERUM2 ("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ " ); 
  spork ~   SERUM2 ("*8}c  _1_1___1___1_5_1_1___1___1_5_3_1_ }c _1___1__1___1_1_ 1_3_5_1___5_3_1 " ); 
  spork ~  Rand(" *4 }c" /* Seq begining */ , 32 /* Nb rand elements */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  8 * data.tick =>  w.wait;   
//}

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
spork ~   SERUM01SEQ (796, "*4  834251" , ":8 f/AA/f" , ":8:2 8/5" , 32 * data.tick,  .4 );

  5 * 8 * data.tick =>  w.wait;   

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}


