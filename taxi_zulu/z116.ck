1 => int mixer;

20::ms => dur local_delay;

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
  .2 * data.master_gain => t.gain;
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

//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");
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
} 
EFFECT1();



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
    spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick => w.wait;
  }
  if ( remove_last_beats  ){
    string seq;
    for (0 => int i; i <  8 - remove_last_beats ; i++) {
      seq + "__h_ " => seq;
    }
    spork ~  TRANCEHH ("*4 +3 {2 " + seq); 
    (8 - remove_last_beats)  * data.tick => w.wait;
  }
} 
fun void  TRANCESNRHHx8  (int n, int remove_last_beats){ 
  if ( remove_last_beats  ){
      n - 1 => n;
  }
  for (0 => int i; i <  n     ; i++) {
   spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
    8 * data.tick => w.wait;
  }
  if ( remove_last_beats  ){
    "*4 +3 {2 __h_   }5+3t_h_" => string seq;
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

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
//spork ~   TRANCEHHx8 (8, 0);
//spork ~   TRANCESNRHHx8 (8*8, 0);
 
//BEAT1_64(1);
   spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
//   spork ~ BASS0HF("*4 !3!3__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !3!3__ !1!1__    ");
//   spork ~ BASS0(" *4   __!3!3 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!2!2 __!1!1   ");
//   spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
   8 * data.tick => w.wait;
}  
