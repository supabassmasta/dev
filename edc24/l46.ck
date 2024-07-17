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

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 8/* ir index */, 1 /* chans */, 43::ms /* pre delay*/, .015 /* rev gain */  , 1.0 /* dry gain */  );       stconvrev $ ST @=>  last;  



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


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

ADSRMOD adsrmod; // Direct ADSR freq input modulation
adsrmod.adsr_set(0.01 /* relative attack dur */, 0.03 /* relative decay dur */ , 0.6 /* sustain */, - 0.3 /* relative release pos */, .3 /* relative release dur */);
adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STCONVREV stconvrev;
//stconvrev.connect(last $ ST , 172/* ir index */, 1 /* chans */, 5::ms /* pre delay*/, 0.1/* rev gain */  , 1.0 /* dry gain */  );       stconvrev $ ST @=>  last;  
stconvrev.connect(last $ ST , 149/* ir index */, 1 /* chans */, 3::ms + 22::samp /* pre delay*/,  0.1/* rev gain */  , 1.2 /* dry gain */  );       stconvrev $ ST @=>  last;  


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


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
  s.gain("S", .8); // for single wav 
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

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 4 * 100 /* freq base */, 12 * 100 /* freq var */, data.tick * 33 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STAUTOPAN autopan1;
autopan1.connect(last $ ST, .8 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan1 $ ST @=>  last; 


//STREVAUX strevaux1;
//strevaux1.connect(last $ ST, .15 /* mix */); strevaux1 $ ST @=>  last;  
STCONVREV stconvrev;
stconvrev.connect(last $ ST , 63/* ir index */, 1 /* chans */, 1::ms /* pre delay*/, .07 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  







150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
56 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

fun void  LOOP_LAB  (){ 
while(1) {
    spork ~   MODU6 (274, "*8  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_  f_m_f_f_f_ f_m_ ", " M", "f", 144 *100, .11); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4   __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!8!1 __!5!1 __!3!1   "); 
  8 * data.tick =>  w.wait;   
     
}


} 
LOOP_LAB();

// INTRO
if ( 1  ){
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
     
}



/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"

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
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
   spork ~   AMB1 ( 0 /* idx */, ":4:4:4 1|1|1_" , 1.0 /* g */ );  
  
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

}
