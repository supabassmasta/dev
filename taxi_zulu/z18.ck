1 => int mixer;

0::ms => dur local_delay;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.2 /* init Sin Phase */, 21 * 100 /* init freq env */, 0.9 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 11 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.mix(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .40 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 9::ms /* Release */ );      duckm $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");

fun void KICK_HPF(string seq, string hpfseq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.mix(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .40 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 9::ms /* Release */ );      duckm $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//  spork ~KICK_HPF("*4k___ k___ k___ k___k___ k___ k___ k___ " , ":4 M/ff/v");

fun void  KICK_LPF(string seq, string hpfseq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.mix();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
//  t.set_scale(data.scale.my_string);//t.set_scale(data.scale.my_string); t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .40 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 9::ms /* Release */ );      duckm $ ST @=>  last; 
STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//  spork ~KICK_LPF("*4k___ k___ k___ k___k___ k___ k___ k___ " , ":4 M/ff/v");

///////////////////////////////////////////////////////////////////////////////////////////////
float wt_table[0];
"wt_bassl20.wav" => string wt_name;
1::second => dur wt_dur;

fun void  rec_wt  (){ 
  REC rec;
  rec.rec_no_sync(wt_dur, wt_name); 
} 

fun void  prepare_WT  (){ 
    <<<"!!! prepare_WT() !!!">>>;

  spork ~   rec_wt (); 


    Step stp0 =>  Envelope e0 =>  SinOsc sin0 => dac; 
    1.0 => sin0.gain;

    1.0 => stp0.next;
    1.8 => e0.value;
    2.2 => e0.target;
    wt_dur * 6 / 8 => e0.duration  => now;
    11 => e0.target;
    wt_dur * 2  / 8 => e0.duration  => now;


} 
if ( ! MISC.file_exist(wt_name)){
  prepare_WT();
}


class SERUM_WT0 extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;
  1. => p.gain;

  1 => w.sync;
  1 => w.interpolate;
  SndBuf s => blackhole;
  wt_name => s.read;
  float wt_table[0];
// Warning: inverted Wavetable 
  for (s.samples() * 2 - 1 => int i; i >= 0 ; i--) {
   
     wt_table << s.valueAt(i);
  }
    w.setTable (wt_table);

  fun void on()  { 1 * 0.01 =>p.phase;  }  fun void off() { }  fun void new_note(int idx)  { 1 * 0.01 =>p.phase; } 1 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
SERUM_WT0 s_wt0;
fun void BASS0 (string seq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


  t.mix();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

  STADSR stadsr;
  stadsr.set(.0::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 30 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.0015 /* Relative Attack */, 27*  .01/* Relative Decay */, 0.29 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,39 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS0_HPF (string seq, string hpfseq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.mix();

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

  STADSR stadsr;
  stadsr.set(.0::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 30 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.0015 /* Relative Attack */, 27*  .01/* Relative Decay */, 0.29 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,39 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
//  spork ~ BASS0_HPF(" *4 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ", ":4 M/ff/v"    );

fun void  BASS0_LPF (string seq, string hpfseq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

t.mix();
//  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

  STADSR stadsr;
  stadsr.set(.0::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 30 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.0015 /* Relative Attack */, 27*  .01/* Relative Decay */, 0.29 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,39 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
//  spork ~ BASS0_LPF(" *4 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ", ":4 M/ff/v"    );

///////////////////////////////////////////////////////////////////////////////////////////
fun void BASS0_ATTACK(string seq, float r, float g) {
  local_delay => now;

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
// SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
  "../_SAMPLES/wavetable/perso/psybassAttack0.wav" => s.wav["a"];
  seq => s.seq;
  g * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('a') != -1 ){
//    s.gain("S", .08); // for single wav 
    r => s.wav_o["a"].wav0.rate;
  }
   // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////////

SERUM_WT0 s_wt1;

fun void BASS0HF (string seq) {
  

//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

t.mix();
//  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  0.22 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              //t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STADSR stadsr;
  stadsr.set(.6::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.35/* Sustain dur of Relative release pos (float) */,  30::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;



  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(25 * 10 /* Base */, 30 * 10 /* Variable */, 1.0 /* Q */);
  stsynclpfx0.adsr_set(.0015 /* Relative Attack */, 27*  .01/* Relative Decay */, 0.29 /* Sustain */, .2 /* Relative Sustain dur */, 0.7 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,39 * 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STFREEFILTERX stfreebrfx0; HPF_XFACTORY stfreebrfx0_fact;
stfreebrfx0.connect(last $ ST , stfreebrfx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreebrfx0 $ ST @=>  last; 
s_wt1.inlet => stfreebrfx0.freq; // CONNECT THIS 

STFREEFILTERX stfreebrfx1; BRF_XFACTORY stfreebrfx1_fact;
stfreebrfx1.connect(last $ ST , stfreebrfx1_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreebrfx1 $ ST @=>  last; 
s_wt1.inlet => stfreebrfx1.freq; // CONNECT THIS 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
//spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");


fun void TRANCEHH(string seq) {
  local_delay => now;

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  1.9 * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('S') != -1 ){
    s.gain("S", .08); // for single wav 
    0.8 => s.wav_o["S"].wav0.rate;
  }
  if(seq.find('s') != -1 ){
    s.gain("s", .8); // for single wav 
    0.65 => s.wav_o["s"].wav0.rate;
  }
  if(seq.find('h') != -1 ){
    s.gain("h", 2.4); // for single wav 
    0.85 => s.wav_o["h"].wav0.rate;
  }
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
class synt0 extends SYNT{
  inlet => SinOsc s =>  outlet; 
  .5 => s.gain;
  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void SYNT0 (string seq) {
  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.mix();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .3 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  //  STMIX stmix;
  //  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, int tomix, float g){ 
  local_delay => now;
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }
    
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


//     spork ~ SLIDENOISE(200/*fstart*/,2000/*fstop*/,8*data.tick/*dur*/,.8/*width*/,0,.14); 
// spork ~ RING("1111 1111 1////F F////1", ":4 H/G"/*fmod*/, ":41/8"/*gmod*/,65/*k*/,1*data.tick, 4,.2);
fun void  RING( string seq, string fmod, string gmod, int k, dur d, int mix, float g){ 
  local_delay => now;
  TONE t;
  t.scale.size(0);
  t.scale << 1 << 3 << 1 << 2 << 3 << 2;
  t.reg(SERUM00 s0); s0.config(k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
                                     // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;

  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(3::samp , 10::ms, 1., 3::samp);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  // Ring mod
  3 => s0.inlet.op;
  
  // MOD
  AUTO.freq(fmod) =>  SqrOsc s => Gain gsin=> Gain out;
  3 => gsin.op;
  AUTO.gain(gmod) => gsin; // Simple gain with mod

  out => s0.inlet;

  STMIX stmix;
  stmix.send(last, mixer + mix);

  d => now; 
} 

//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");

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
////////////////////////////////////////////////////////////////////////////////////////////
// BPM


//148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
//55 => data.ref_note;

SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//8 *data.tick => w.fixed_end_dur;
8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 12/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .06 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  
  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive(mixer + 2); stmix $ ST @=> ST @ last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

  STMIX stmix2;
  stmix2.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT2();


fun void  BEAT1_32  (){ 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
// spork ~ SLIDENOISE(200/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,1.8/*width*/,2,.11); 

// spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
// spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
// spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
// spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
// 8 * data.tick => w.wait;
 
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !3!3__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!2!2 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;

   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !2!2__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!3!3 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa  aaaa ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ____");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____ __8//8   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa ____ __a_   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
}
   //// 

fun void  BEAT1_64  (int n){ 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
// spork ~ SLIDENOISE(200/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,1.8/*width*/,2,.11); 

// spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
// spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
// spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
// spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
// 8 * data.tick => w.wait;
 
 for (0 => int i; i < n      ; i++) {
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !3!3__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!2!2 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;

   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !2!2__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!3!3 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa  aaaa ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ____");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____ __8//8   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa ____ __a_   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;

   //// 

   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !3!3__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!2!2 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;

   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !2!2__ !1!1__    ");
   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!3!3 __!1!1   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ____");
   spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____ ____    ");
   spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____ __8//8   ");
   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa ____ __a_   ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
   }
} 
//BEAT1_64(1);
fun void  TRANCEHHx8  (int n, int remove_last_beats){ 
  if ( remove_last_beats  ){
      n - 1 => n;
  }
  for (0 => int i; i <  n     ; i++) {
    spork ~  TRANCEHH ("*4 +2 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick => w.wait;
  }
  if ( remove_last_beats  ){
    string seq;
    for (0 => int i; i <  8 - remove_last_beats ; i++) {
      seq + "__h_ " => seq;
    }
    spork ~  TRANCEHH ("*4 +2 {2 " + seq); 
    (8 - remove_last_beats)  * data.tick => w.wait;
  }
} 
fun void  TRANCESNRHHx8  (int n, int remove_last_beats){ 
  if ( remove_last_beats  ){
      n - 1 => n;
  }
  for (0 => int i; i <  n     ; i++) {
   spork ~  TRANCEHH ("*4 +2 {2 __h_   }5+5t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
    8 * data.tick => w.wait;
  }
  if ( remove_last_beats  ){
    "*4 +2 {2 __h_   }5+3t_h_" => string seq;
    for (0 => int i; i <  6 - remove_last_beats ; i++) {
      if ( i % 2 == 0  ){
      seq + "__h_ " => seq;
      }
      else {
      seq + "t_h_ " => seq;
           
      }
    }
    spork ~  TRANCEHH ( seq); 
    (8 - remove_last_beats)  * data.tick => w.wait;
  }
} 

// spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 


fun void  ZULU  (dur offset, dur d, int tomix, float g){ 
   LONG_WAV l;
//   "../_SAMPLES/Chassin/Taxi Zulu.wav" => l.read;
   "../_SAMPLES/Chassin/Taxi Zulu 2.wav" => l.read;
   g * data.master_gain => l.buf.gain;
   0 => l.update_ref_time;
   l.AttackRelease(0::ms, 0::ms);
   l.start(0 * data.tick /* sync */ , offset  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
  
    if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
    }

    d => now;

}

fun void  TRACK  (dur offset, dur d, int tomix, float g){ 
   LONG_WAV l;
//   "../_SAMPLES/Chassin/Taxi Zulu.wav" => l.read;
   "taxi_zulu.wav" => l.read;
   g * data.master_gain => l.buf.gain;
   0 => l.update_ref_time;
   l.AttackRelease(0::ms, 0::ms);
   l.start(0 * data.tick /* sync */ , offset  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
  
    if ( tomix  ){
       STMIX stmix;
       stmix.send(last, mixer + tomix);
    }

    d => now;

}


fun void  BEAT_INTRO_8  (int n){ 
   for (0 => int i; i <  n     ; i++) {
     spork ~KICK("*4 k___ ____ k___ ____k___ ____ k___ k___");
     8 *data.tick => w.wait;
}
    
} 
fun void  BEAT_INTRO_9  (int n){ 
   for (0 => int i; i <  n     ; i++) {
     spork ~KICK("*4 k___ ____ k___ ____k___ ____ k___ k___");
     8 *data.tick => w.wait;
}
     spork ~KICK("*4 k___ ");
     1 *data.tick => w.wait;
    
} 

fun void  BEAT_SOLO_8  (int n){ 
   for (0 => int i; i <  n     ; i++) {
     spork ~KICK("*4 k___ k___ k___ k___ k___ k___ k___ k___");
     8 *data.tick => w.wait;
}
    
} 
    




fun void  BEAT_COUNTER  (){ 
  0 => int i;
    while(1) {
      <<<"-------------------">>>;
      <<<"-        " + i + " *8*data.tick -">>>;
      <<<"-------------------">>>;
      1 +=> i;
      8 * data.tick => now;
    }
} 

spork ~   BEAT_COUNTER (); 

fun void  LOOPLAB  (){ 
  while(1) {
//spork ~ ZULU(0*8*data.tick, 128*8*data.tick,0,2.0);

// 1st BK
//spork ~ ZULU(16*8*data.tick, 4*8*data.tick,0,2.0);
//    4 * 8 * data.tick => w.wait;

// Girls voices
//spork ~ ZULU(20*8*data.tick, 4*8*data.tick,0,2.0);
//    4 * 8 * data.tick => w.wait;

//  BRK ???
spork ~ ZULU(30*8*data.tick, 16*8*data.tick,0,2.0);
spork ~ BEAT_INTRO_9(1);
    2 * 8 * data.tick => w.wait;
spork ~ BEAT_INTRO_8(2);
    2 * 8 * data.tick => w.wait;
spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;
spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;

// Hala 
//spork ~ ZULU(32*8*data.tick, 8*8*data.tick,0,2.0);
//    8 * 8 * data.tick => w.wait;

// Hi Tijé 
//spork ~ ZULU(40*8*data.tick, 4*8*data.tick,0,2.0);
//    4 * 8 * data.tick => w.wait;

// drop 
//spork ~ ZULU(48*8*data.tick, 4*8*data.tick,0,2.0);
//    4 * 8 * data.tick => w.wait;

// TRANCE
//spork ~ ZULU(52*8*data.tick, 32*8*data.tick,0,2.0);
//spork ~ BEAT1_64(3);
//    12 * 8 * data.tick => w.wait;
//spork ~   TRANCEHHx8 (16, 0);
//    12 * 8 * data.tick => w.wait;
//spork ~ BEAT1_32();
//  4 * 8 * data.tick => w.wait;
//spork ~ BEAT_SOLO_8(4);
//  4 * 8 * data.tick => w.wait;

// BK ZULU
//spork ~ ZULU(80*8*data.tick, 128*8*data.tick,0,2.0);
//spork ~ BEAT_SOLO_8(4);
//  4 * 8 * data.tick => w.wait;
//2 * 8 * data.tick => now;
//spork ~ BEAT_SOLO_8(1);
//2 * 8 * data.tick => now;
//spork ~ BEAT1_64(8);
////    8 * 8 * data.tick => w.wait;
//spork ~   TRANCEHHx8 (8, 2);
//    8 * 8 * data.tick => w.wait;
//spork ~   TRANCESNRHHx8 (8, 2);
//
//128 * 8 * data.tick => now;


//-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
//LOOPLAB(); 

//TRACK(0*8*data.tick/*offset*/, 260*8*data.tick/*d*/,0,1.3);
TRACK(48*8*data.tick/*offset*/, 260*8*data.tick/*d*/,0,1.3);

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(0) { /********************************************************/
 

spork ~ ZULU(0*8*data.tick, 128*8*data.tick,0,2.0);
4 * 8 * data.tick => now;
spork ~ BEAT_INTRO_8(12);
10 * 8 * data.tick => now;
  spork ~ RING(":2 1////F F////1", ":8 G//H"/*fmod*/, ":8 1//f"/*gmod*/,65/*k*/,14*data.tick, 2,.20);
  spork ~ SLIDENOISE(100/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;

spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
////  BRK ???
//spork ~ ZULU(22*8*data.tick, 128*8*data.tick,0,2.0);

spork ~ BEAT_INTRO_9(9);
10 * 8 * data.tick => w.wait;
spork ~ BEAT_INTRO_8(2);
1 * 8 * data.tick => w.wait;
  spork ~ RING("1111 1111 1////F F////1", ":8 H/G"/*fmod*/, ":8 1/8"/*gmod*/,64/*k*/,8*data.tick, 2,.3);
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */,2,.21); 
  8 * data.tick => w.wait;

spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;
spork ~ BEAT_SOLO_8(4);
5 * 8 * data.tick => now;
spork ~ BEAT_INTRO_9(3);
3 * 8 * data.tick => now;
  spork ~ SLIDENOISE(100/*fstart*/,1800/*fstop*/,30*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;
  spork ~ RING(":4 1////F F////1", ":8:2 G/HH/A"/*fmod*/, ":8 1//m"/*gmod*/,69/*k*/,14*data.tick, 2,.17);
  16 * data.tick => w.wait;

// Drop

spork ~ BEAT1_64(3);
12 * 8 * data.tick => w.wait;
spork ~   TRANCEHHx8 (16, 0);
12 * 8 * data.tick => w.wait;
spork ~ BEAT1_32();
2 * 8 * data.tick => w.wait;
  spork ~ RING(":2 1////F F////1", ":8 G//H"/*fmod*/, ":8 1//f"/*gmod*/,65/*k*/,14*data.tick, 2,.25);
  spork ~ SLIDENOISE(100/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

// BK ZULU

// TOREMOVE
//spork ~ ZULU(80*8*data.tick, 128*8*data.tick,0,2.0);


spork ~ BEAT_SOLO_8(4);
  4 * 8 * data.tick => w.wait;
2 * 8 * data.tick => now;
spork ~ BEAT_SOLO_8(1);
1 * 8 * data.tick => now;
  spork ~ RING("1111 1111 1////F F////1", ":8 H/G"/*fmod*/, ":8 1/8"/*gmod*/,64/*k*/,8*data.tick, 2,.2);
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */,2,.14); 
  8 * data.tick => w.wait;
spork ~ BEAT1_64(3);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCEHHx8 (8, 2);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCESNRHHx8 (8, 2);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCESNRHHx8 (4, 2);
spork ~ BEAT1_32();
8 * 8 * data.tick => now;
}  

// SKIP END LOOP 
1 => data.next;

/// PLAY OR REC /////////////////
RECTRACK rectrack; "taxi_zulu.wav"=>rectrack.name_main; 0=>rectrack.compute_mode; 1=>rectrack.rec_mode;8*data.tick=>rectrack.main_extra_time;8*data.tick=>rectrack.end_loop_extra_time;
// w.the_end.sync_dur=>rectrack.play_end_sync;  // use the same end sync as in the track
if (rectrack.play_or_rec() ) {
  //////////////////////////////////

  //////////////////////////////////////////////////
  // MAIN 
  //////////////////////////////////////////////////

 

spork ~ ZULU(0*8*data.tick, 128*8*data.tick,0,2.0);
4 * 8 * data.tick => now;
spork ~ BEAT_INTRO_8(12);
10 * 8 * data.tick => now;
  spork ~ RING(":2 1////F F////1", ":8 G//H"/*fmod*/, ":8 1//f"/*gmod*/,65/*k*/,14*data.tick, 2,.20);
  spork ~ SLIDENOISE(100/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;

spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
////  BRK ???
//spork ~ ZULU(22*8*data.tick, 128*8*data.tick,0,2.0);

spork ~ BEAT_INTRO_9(9);
10 * 8 * data.tick => w.wait;
spork ~ BEAT_INTRO_8(2);
1 * 8 * data.tick => w.wait;
  spork ~ RING("1111 1111 1////F F////1", ":8 H/G"/*fmod*/, ":8 1/8"/*gmod*/,64/*k*/,8*data.tick, 2,.3);
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */,2,.21); 
  8 * data.tick => w.wait;

spork ~ BEAT_SOLO_8(4);
6 * 8 * data.tick => now;
spork ~ BEAT_SOLO_8(4);
5 * 8 * data.tick => now;
spork ~ BEAT_INTRO_9(3);
3 * 8 * data.tick => now;
  spork ~ SLIDENOISE(100/*fstart*/,1800/*fstop*/,30*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;
  spork ~ RING(":4 1////F F////1", ":8:2 G/HH/A"/*fmod*/, ":8 1//m"/*gmod*/,69/*k*/,14*data.tick, 2,.17);
  16 * data.tick => w.wait;

// Drop

spork ~ BEAT1_64(3);
12 * 8 * data.tick => w.wait;
spork ~   TRANCEHHx8 (16, 0);
12 * 8 * data.tick => w.wait;
spork ~ BEAT1_32();
2 * 8 * data.tick => w.wait;
  spork ~ RING(":2 1////F F////1", ":8 G//H"/*fmod*/, ":8 1//f"/*gmod*/,65/*k*/,14*data.tick, 2,.25);
  spork ~ SLIDENOISE(100/*fstart*/,1500/*fstop*/,14*data.tick/*dur*/,2.8/*width*/,2,.14); 
  16 * data.tick => w.wait;

//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

// BK ZULU

// TOREMOVE
//spork ~ ZULU(80*8*data.tick, 128*8*data.tick,0,2.0);


spork ~ BEAT_SOLO_8(4);
  4 * 8 * data.tick => w.wait;
2 * 8 * data.tick => now;
spork ~ BEAT_SOLO_8(1);
1 * 8 * data.tick => now;
  spork ~ RING("1111 1111 1////F F////1", ":8 H/G"/*fmod*/, ":8 1/8"/*gmod*/,64/*k*/,8*data.tick, 2,.2);
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */,2,.14); 
  8 * data.tick => w.wait;
spork ~ BEAT1_64(3);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCEHHx8 (8, 2);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCESNRHHx8 (8, 2);
    8 * 8 * data.tick => w.wait;
spork ~   TRANCESNRHHx8 (4, 2);
spork ~ BEAT1_32();
8 * 8 * data.tick => now;
  //// STOP REC ///////////////////////////////
  rectrack.rec_stop();
  //////////////////////////////////////////////////

}  
