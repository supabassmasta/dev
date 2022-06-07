21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 8 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 8 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK3(string seq) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 9::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3_HPF(string seq, string hpfseq ) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 9::ms /* Release */ );      duckm $ ST @=>  last; 


STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

fun void BASS11 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.0 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(18 * 10 /* Base */, 26 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.1, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.2 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS11_HPF (string seq, string hpfseq) {

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.0 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(18 * 10 /* Base */, 26 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.1, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.2 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 



STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU7 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
t.lyd();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
g * data.master_gain * 0.8 => t.gain;
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
stmix.send(last, mixer + 2 );

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
stmix.send(last, mixer  );

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


////////////////////////////////////////////////////////////////////////////////////////////

fun void PLOC (string seq, int n, float lpf_f,  float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
//  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 50::ms, .00002, 400::ms);
t.set_adsrs_curves(0.6, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STREVAUX strevaux;
  strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

////////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", 2.0); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   if(seq.find('S') != -1 ) 1.2 => s.wav_o["S"].wav0.rate;
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

fun void CYMBAL(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.CYMBALS(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
//  s.wav["b"] => s.wav["h"];
  s.wav["x"] => s.wav["h"];
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
//  s.gain("S", 2.0); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   if(seq.find('S') != -1 ) 1.2 => s.wav_o["S"].wav0.rate;
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

/////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer +1);
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


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .3);  ech $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  

//.65 => stmix.gain;


STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=> last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .6);  ech2 $ ST @=>  last; 


STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=> last; 

STECHO ech3;
ech3.connect(last $ ST , data.tick * 3 / 4 , .9);  ech3 $ ST @=>  last; 

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.1 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STAUTOPAN autopan2;
autopan2.connect(last $ ST, .8 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.42 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 





152 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

fun void  LOOP_LAB  (){ 
   
while(1) {
 
//    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 14 *100, .75); 

//   spork ~   MODU6 (288, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
//    spork ~   MODU6 (288, " ____ __ *8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
//    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("____,____,____,____,____,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 

//  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k_  "  ); 
//  spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 



   ///////////////////////**********************************************$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("___,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 
   spork ~   MODU6 (288, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
   spork ~   MODU6 (288, " ____ __ *8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   

   spork ~   MODU6 (290, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
   spork ~   MODU6 (291, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   


    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("___,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 
   spork ~   MODU6 (292, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 13 *100, .42); 
   spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   


//   __6_ __B_ ____ ____
//   
//   1_3_ 5___ 8___ __B_
//   5___ B_8_ ____ B_B_
//   1_3_ 5___ 8___ 0_A_
//   __6_ __B_ __1_ ____


//  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
//  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
//  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
//  spork ~  CYMBAL (" -3 h___ ____"); 
//  8 * data.tick =>  w.wait;   

}

} 
//LOOP_LAB();

//if (0 ) {

/********************************************************/
//if (    0     ){
//}
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/


//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 


//    spork ~   MODU6 (281, "*8 }c" + RAND.seq("1_1_,__1_,8_1_,__8_,1_5_,851_,", 16), " L", "f", 105 *100, .52); 
//    spork ~   MODU6 (284, "*8 }c" + RAND.seq("1_1_,__1_,8_1_,__8_,1_5_,851_,", 16), "*4 LMMILI", "}c  f", 105 *100, .71); 
//    spork ~   MODU6 (284, "*8 }c" + RAND.seq("1_1_,__1_,8_1_,__8_,1_5_,851_,", 16), "*4 LMMILI", "}c  f", 105 *100, .71); 
//    spork ~   MODU6 (286, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 16), "*4 LMMILI", "}c  f", 105 *100, .71); 
//    spork ~   MODU6 (286, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 16), "*4 L/MM/IL/I", "}c  f", 21 *100, .71); 
//    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 16), "*4 L/MM/IL/I", "}c  f", 21 *100, .56); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ ____  ", ":4 M/ff/M" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M/ff/M"); 
  8 * data.tick =>  w.wait;   



 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(252 /* fstart */, 4000 /* fstop */, 8* data.tick /* dur */, .8 /* width */, .14 /* gain */); 
 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

    spork ~  CYMBAL (" -3 h___ ____"); 
    
    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (290, "____ *8 " + RAND.seq("f////1,__1_,8//1__,_8_f/F,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 48 *100, .19); 

 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (289, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 21 *100, .40); 

 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (288, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 

 spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  8 * data.tick =>  w.wait;   

  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ ____  ", ":4 M/ff/M" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M/ff/M"); 
  spork ~  SLIDENOISE(252 /* fstart */, 4000 /* fstop */, 8* data.tick /* dur */, .8 /* width */, .14 /* gain */); 
   8 * data.tick =>  w.wait;   

  spork ~  CYMBAL (" -3 h___ ____"); 

for (0 => int i; i < 4      ; i++) {
     
    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (290, "____ *8 " + RAND.seq("f////1,__1_,8//1__,_8_f/F,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 48 *100, .20); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (289, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (288, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    8 * data.tick =>  w.wait; 

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (289, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    8 * data.tick =>  w.wait;   

}

  //////////////////////////////////////////////////////////////////////////////////:::



    spork ~   MODU7 (265 , "   }c__1___8______1//F____1" , "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .16); 

   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 M//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M//f"); 
  8 * data.tick =>  w.wait;   

 spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//f"); 
  8 * data.tick =>  w.wait;   

 spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//f"); 
  8 * data.tick =>  w.wait;   

   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//M" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//M"); 
  8 * data.tick =>  w.wait;   
  //////////////////////////////////////////////////////////////////////////////////:::


  //////////////////////////////////////////////////////////////////////////////////:::

for (0 => int i; i <   8    ; i++) {

 
    spork ~   MODU6 (288, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
    spork ~   MODU6 (288, " ____ *8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("____,____,____,____,____,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 

//  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k_  "  ); 
//  spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
//  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
//  spork ~  CYMBAL (" -3 h___ ____"); 
  8 * data.tick =>  w.wait;   

} 
  //////////////////////////////////////////////////////////////////////////////////:::


  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ ____  ", ":4 M/ff/M" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M/ff/M"); 
  8 * data.tick =>  w.wait;   

  spork ~  CYMBAL (" -3 h___ ____"); 

   spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (290, "____ *8 " + RAND.seq("f////1,__1_,8//1__,_8_f/F,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 48 *100, .24); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (289, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (288, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
    8 * data.tick =>  w.wait; 

    spork ~   MODU6 (287, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 L/MM/IL/I", "}c  f", 21 *100, .40); 
    spork ~   MODU6 (289, "____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,851_,", 8), "*4 {c{c L/MM/FF/88/MM/L", "}c  f", 21 *100, .40); 

    spork ~   PLOC ("  {c *2 _1_1_1_1_1_1_1*2"+ RAND.seq("__1!1,_1_1,!1!1!1_", 1), 21, 29 * 100, 0.25 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
    spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
    spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
    spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
    8 * data.tick =>  w.wait;   



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    spork ~   MODU7 (265 , "   }c1//F___f___8______F____1" , "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .16); 

   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 M//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M//f"); 
  8 * data.tick =>  w.wait;   

 spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//f"); 
  8 * data.tick =>  w.wait;   

 spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//f"); 
  8 * data.tick =>  w.wait;   

   spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  ", ":4 f//M" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 f//M"); 
  8 * data.tick =>  w.wait;   
  //////////////////////////////////////////////////////////////////////////////////:::


0 => data.next;
while (!data.next) {
    <<<"********">>>;
    <<<"END LOOP">>>;
    <<<"********">>>;

    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("___,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 
   spork ~   MODU6 (288, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
   spork ~   MODU6 (288, " ____ __ *8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   

   spork ~   MODU6 (290, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .43); 
   spork ~   MODU6 (291, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   


    spork ~   MODU7 (Std.rand2(265,295) , "  *2 }c" + RAND.seq("___,____,____,____,____,____,1_1_,__8_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "{c{c{c{c *5 L/MM/IL/I", "}c  f", 25 *100, .20); 
   spork ~   MODU6 (292, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 13 *100, .42); 
   spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k  " + RAND.seq("___,_k_,_kk_,__k_,k_k_", 1) ); 
  spork ~  BASS11 ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  "); 
  spork ~  TRANCEHH ("*4  __h_  S_h_ __h_ S_h_ __h_ S_h_ __h_ S_h_ "); 
  spork ~  TRANCEHH ("*4 -1  iiii iiii iiii iiii iiii iiii iiii iiii "); 
  8 * data.tick =>  w.wait;   


 }
  spork ~  CYMBAL (" -3 h___ ____"); 
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ ____  ", ":4 M//f" ); 
  spork ~  BASS11_HPF ("*4 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8 _!1!1!1 _!1!8!5 _!1!1!1 _!1!5!8_  ", ":4 M//f"); 
  8 * data.tick =>  w.wait;   


