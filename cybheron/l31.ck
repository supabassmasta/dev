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
  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
  t.set_scale(data.scale.my_string);//t.set_scale(data.scale.my_string); t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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
fun void BASS0HF_HPF (string seq, string hpfseq) {
  //  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

  STFREEFILTERX stfreehpfx2; HPF_XFACTORY stfreehpfx2_fact;
  stfreehpfx2.connect(last $ ST , stfreehpfx2_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx2 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx2.freq; // CONNECT THIS 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
//spork ~ BASS0HF_HPF(" *4  !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ", ":4 M/ff/v"    );

fun void BASS0HF_LPF (string seq, string hpfseq) {

//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

  STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
// spork ~ BASS0HF_LPF(" *4  !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ", ":4 M/ff/v"    );

///////////////////////////////////////////////////////////////////////////////////////////

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

fun void TRIBAL_CUSTOM(string seq, int tomix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  
  SET_WAV.TRIBAL(s);
  s.wav["M"] => s.wav["a"];  // act @=> s.action["a"]; 
  s.wav["M"] => s.wav["b"];  // act @=> s.action["a"]; 

  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  1.2=> s.wav_o["a"].wav0.rate;
  1.4=> s.wav_o["b"].wav0.rate;
  s.go();     s $ ST @=> ST @ last; 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
   
fun void ACOUSTICTOM(string seq, int tomix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
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
    stmix.send(last, mixer + tomix);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ",0,.7);


////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU (int nb, string seq, string modf, string modg, float cut, int tomix, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//  spork ~   MODU (22, "*4 {c  1__1 _1_1 __1_ 1_1__1","1"/*modf*/,"f"/*modg*/,2*1000/*cut*/,0,.26); 

fun void MOD1(string seq, int n, float modf, float modg, float modp, int tomix, float g){ 
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 
  t.set_scale(data.scale.my_string);   
  t.no_sync();

  seq => t.seq;
  g * data.master_gain => t.gain;

  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  SinOsc sin0 =>  s0.inlet;
  modf => sin0.freq;
  modg => sin0.gain;
  modp => sin0.phase;


  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }
  1::samp => now; // let seq() be sporked to compute length
    t.s.duration  => now;
} 

// spork ~ MOD1("*8{c  1_1_1_1_1_1_1_1_ 8_8_8_8_8_8_8_8_",11/*n*/,3.1/*modf*/,21*11/*modg*/,.3/*modp*/,0,.2) ; 

fun void SYNTGLIDE (string seq, int n, float lpf_f, dur gldur, int tomix, float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.set_scale(data.scale.my_string);
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }
  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}


//  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */,0,.25);


fun void SYNTGLIDE (string seq, int n, float lpf_f, dur gldur, dur d, int tomix, float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.set_scale(data.scale.my_string);
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }
  d => now;

}


//  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */,16*data.tick,0,.25);


fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, int tomix, float g){ 
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


fun void PLOC (string seq, int n, float lpf_f, int tomix, float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
//  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.set_scale(data.scale.my_string);
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}


//  spork ~ PLOC("{c ____ *2 1", 17/*n*/,29*100/*cut*/,0,0.4); 


fun void  SUPSAWSLIDE  ( string seq, float ph, int tomix, float g){ 

  TONE t;
  t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();//
  t.set_scale(data.scale.my_string); // t.phr();// t.loc();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  //____ f/P__
  " {c{c" + seq  => t.seq;
  g => t.gain;
  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
  t.go();   t $ ST @=> ST @ last; 
  
  STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
  ph => stautoresx0.sin0.phase;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 2 * 100 /* freq base */, 15 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 3 /* order */, 2 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
  
  2.5 => stautoresx0.gain;
  
  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }
  
  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 

//spork ~ SUPSAWSLIDE("*4 }c}c}c 1235 {21235 {21235 {21235 {21235 {21235 {21235 {21235 {2 ", .3/*autoRes phase*/,0,0.7);

fun void PADS2 (string seq,int n, int tomix, float g) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.2 /* G */, 200::ms /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  t.reg(SYNTWAV s1);  //200::ms * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s1.config(.2 /* G */, 200::ms /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
  // s0.pos s0.rate s0.lastbuf 
  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .8 * g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now;
  t.s.duration => now;
}


// spork ~ PADS2("}c :8:2 1|3_",12/*n*/,0,.3); 

fun void  RANDSERUM2  (string seq, int n, int start_chunk, int stop_chunk, int tomix, float g ){ 

  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config( n /* synt nb */ );
  // s0.set_chunk(0); 

  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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


  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration + now => time end;
  while(end > now) {
    s0.set_chunk(Std.rand2(start_chunk, stop_chunk));
    data.tick / 4 => now;
  }
   
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 


//  spork ~RANDSERUM2("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ ",29/*n*/,0/*start_chunk*/,63/*stop_chunk*/,0,.3); 


fun void  SINGLEWAV  (string file, int tomix, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  g => s.gain;

  file => s.read;

  s.length() => now;
}


//  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/CPecriventDuCode.wav", 0, .3); 

fun void  SERUM00SEQ (string seq, int n, string seq_cut , string seq_g , dur d, int tomix, float g){ 
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 
  t.set_scale(data.scale.my_string);
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  d => now; // let seq() be sporked to compute length
}


//  spork ~ SERUM00SEQ (" *4 53_1",30/*n*/,"}c:81//f"/*seqcut*/,":86//8"/*seq_g*/,16*data.tick/*d*/,1,.5);


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

fun void  ONEP0  (string s, int tomix,  float g){ 
  TONE t;
  t.reg(syntOneP s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
  //t.lyd(); // t.ion(); // t.mix();// 
  t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  g * data.master_gain => t.gain;
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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 


//  spork ~   ONEP0 (" *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 32),0, 4.1); 


class syntcomb extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { .4 => s.phase;} 0 => own_adsr;
} 
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 
fun void  COMB  (string seq, dur comb_dur, float comb_res, int tomix,  float g){ 
   
   TONE t;
   t.reg(syntcomb s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   t.set_scale(data.scale.my_string);// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   .9 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();//
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(3::ms, 3::ms, .0002, 4::ms);
   t.set_adsrs_curves(0.8, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , comb_dur , comb_res);  ech $ ST @=>  last; 

//STFLANGER ech;
//ech.connect(last $ ST); ech $ ST @=>  last; 
//ech.add_line(0 /* 0 : left, 1: right 2: both */, comb_res /* delay line gain */,  comb_dur /* dur base */, 1::ms /* dur range */, 1 /* freq */); 

//"FEDCBA0 1234567 89abcde fghijkl mnop"=> string filternotes;
//" MLKJIHGFEDCBA0123456789a "=> string notes;
"MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnop "=> string notes;
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnop"=> string notes;

 
//"6"=> string notes;
RAND.char(notes, 16)=> string filternotes;
//"M" + filternotes => filternotes;
//"}c}c M/NN/OO/PP/aa/BB/CC/ff/M" => filternotes;


10::ms => dur gl;


  STFREEFILTERX stfreeresx0; RES_XFACTORY stfreeresx0_fact;
  stfreeresx0.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx0 $ ST @=>  last; 
  AUTO.freqglide("*4 " + filternotes, gl) => stfreeresx0.freq; // CONNECT THIS 8
  
  STFREEFILTERX stfreeresx1;
  stfreeresx1.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx1 $ ST @=>  last; 
  AUTO.freqglide("*4}c" + filternotes, gl) => stfreeresx1.freq; // CONNECT THIS 8
  
  STFREEFILTERX stfreeresx2;
  stfreeresx2.connect(ech $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreeresx2 $ ST @=>  last; 
  AUTO.freqglide("*4}c}c" + filternotes, gl)  => stfreeresx2.freq; // CONNECT THIS 8
  
  STGAIN stgain;
  stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
  stgain.connect(stfreeresx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
  stgain.connect(stfreeresx1 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 153 * 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STLIMITER stlimiter;
1. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

g => stlimiter.gain;


//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 


  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  1::samp => now;
  t.s.duration => now;

} 

//1::second / Std.mtof(data.ref_note) => dur comb_dur; //<<<"comb_dur",comb_dur/1::ms>>>;
//spork ~   COMB ("*8 {c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//spork ~   COMB ("*8 }c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 
//spork ~   COMB ("*8   " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//spork ~   COMB ("*8  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 


fun void  ERAMP (int mixin, dur d, string gseq, string lpfseq,int lpforder, int tomix, float g){ 
  STMIX stmix;
  stmix.receive(mixer + mixin); stmix $ ST @=> ST @ last; 

  STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
  stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1 /* Q */, lpforder /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
  AUTO.freq(lpfseq) => stfreelpfx0.freq; // CONNECT THIS 

  STFREEGAIN stfreegain;
  stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
  AUTO.gain(gseq) => stfreegain.g; // connect this 

  g => stfreegain.gain;

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  d => now;
} 

//spork ~ ERAMP (4/*mixin*/,32*data.tick,":8:25//8"/*gseq*/,":81///88/m"/*lpfseq*/,2/*lpforder*/,1,1.0);


fun void  ERAMPOD (int mixin, dur d, string gseq, string odseq,float drive,int tomix, float g){ 
  STMIX stmix;
  stmix.receive(mixer + mixin); stmix $ ST @=> ST @ last; 

  STFREEGAIN stfreegain2;
  stfreegain2.connect(last $ ST);       stfreegain2 $ ST @=>  last; 
  AUTO.gain(odseq) => stfreegain2.g; // connect this 

  STOVERDRIVE stod;
  stod.connect(last $ ST, drive /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

  STFREEGAIN stfreegain;
  stfreegain.connect(stmix);       stfreegain $ ST @=>  last; 
  AUTO.gain(gseq) => stfreegain.g; // connect this 

  STGAIN stgain;
  stgain.connect(last $ ST , g /* static gain */  );       stgain $ ST @=>  last; 
  stgain.connect(stod , g /* static gain */  );       stgain $ ST @=>  last; 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  d => now;
} 


//spork ~ ERAMPOD (4/*mixin*/,32*data.tick,":8:21//1"/*gseq*/,":81////4"/*odseq*/,4.8/*drive*/,0,0.3);

fun void  ENSEMBLE(string part, dur d, int mix, float g){ 
spork ~ PADS2("}c" + part,17/*n*/,mix,.3*g); 
spork ~ PADS2(  part ,17/*n*/,mix,.4*g); 
spork ~ PADS2(  part ,14/*n*/,mix,.15*g); 
spork ~ PADS2(  part ,15/*n*/,mix,.15*g); 
  
  d => now;
} 

//spork ~ ENSEMBLE(":8 8|a 5|7",16*data.tick,4,1.);
//spork ~ ENSEMBLE(":8:2 1|5_",16*data.tick,4,1.);

////////////////////////////////////////////////////////////////////////////////////////////
// BPM
150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;
"aeo" => data.scale.my_string;
<<<"SCALE: ", data.scale.my_string>>>;

SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//0::ms => w.fixed_end_dur;
8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 


//  STCONVREV stconvrev;
//  stconvrev.connect(last $ ST , 29/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .001 * 3 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


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
fun void EFFECT3   (){ 
  STMIX stmix;
  stmix.receive(mixer + 3); stmix $ ST @=> ST @ last; 

STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 1.0 /* Q */, 3 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 5 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  
4 => stautobpfx0.gain;
  STMIX stmix2;
  stmix2.send(last, mixer + 2);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT3();

fun void EFFECT4   (){ 
  STMIX stmix;
  stmix.receive(mixer + 4); stmix $ ST @=> ST @ last; 

//  STCONVREV stconvrev;
//  stconvrev.connect(last $ ST , 17/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .16 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  
  STCONVREV stconvrev;
  stconvrev.connect(last $ ST , 17/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .42 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

  while(1) {
         100::ms => now;
  }
   
} 

spork ~  EFFECT4();


fun void  ENS1  (){ 


  /// PLAY OR REC /////////////////
  RECSEQ recseq; "ENS1.wav"=>recseq.name_main; 0=>recseq.compute_mode; 1=>recseq.rec_mode;8*data.tick=>recseq.main_extra_time;
  if (recseq.play_or_rec() ) {
    //////////////////////////////////

    //////////////////////////////////////////////////
    // MAIN 
    //////////////////////////////////////////////////

    //  !!!!!!  Put main code here  !!!!!
    // Call this with file and fun name to record all seq on fresh cloned project
    // if (! MISC.file_exist( "seqname0.wav")) SEQNAME0();
    //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
    //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
     
    spork ~   ENSEMBLE (":8 2|4_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 E|6_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 9_",18*data.tick,4,1. );
    16*data.tick => w.wait;

    spork ~   ENSEMBLE (":8 5|7_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 B|4_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 2_",18*data.tick,4,1. );
    16*data.tick => w.wait;

    spork ~   ENSEMBLE (":8 2|3_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 8|4_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8 7_",18*data.tick,4,1. );
    16*data.tick => w.wait;

    spork ~   ENSEMBLE (":8:2 1|3_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8:2 9|5_",18*data.tick,4,1. );
    spork ~   ENSEMBLE (":8:2 7_",18*data.tick,4,1. );
    16*data.tick => w.wait;

    //// STOP REC ///////////////////////////////
    recseq.rec_stop();
    //////////////////////////////////////////////////
  } 

} 
if (! MISC.file_exist( "ENS1.wav")) {
  // wait Stereo conv rev to load
  2::second => now;
  ENS1();
}
fun void SONATA   (){ 
     
  spork ~   MODU (31, "*8  "+ RAND.seq("1_,1_,__,8_", 17) , "f", "6", 12 *1000, 3, .38); 
  spork ~ SYNTGLIDE("*4 }c "+ RAND.seq("]1,]1,[1,[1", 8) + RAND.seq("]1 1,]1 1,[1 1,[1 1, _", 15) /* seq */, 7 /* Serum00 synt */,9*100/* lpf_f */, 5::ms /* glide dur */,2*data.tick,2,.66);
  8 * data.tick => w.wait;
  spork ~   MODU (25, "*8  "+ RAND.seq("1_,1_,__", 17) , "f", "4", 8 *1000, 3, .38); 
  spork ~ SYNTGLIDE("*4 }c "+ RAND.seq("]1,]1,[1,[1", 8) + RAND.seq("]1 1,]1 1,[1 1,[1 1, _", 16) /* seq */, 1111 /* Serum00 synt */,24*100/* lpf_f */, 5::ms /* glide dur */,2*data.tick,2,.66);
  8 * data.tick => w.wait;

  spork ~   MODU (31, "*8  "+ RAND.seq("1_,1_,__,8_", 17) , "f", "6", 12 *1000, 3, .66); 
  spork ~ SYNTGLIDE("*4 }c "+ RAND.seq("]1,]1,[1,[1", 8) + RAND.seq("]1 1,]1 1,[1 1,[1 1, _", 15) /* seq */, 7 /* Serum00 synt */,9*100/* lpf_f */, 5::ms /* glide dur */,2*data.tick,2,.76);
  8 * data.tick => w.wait;
  spork ~   MODU (25, "*8  "+ RAND.seq("1_,1_,__", 17) , "f", "4", 8 *1000, 3, .66); 
  spork ~ SYNTGLIDE("*4 }c "+ RAND.seq("]1,]1,[1,[1", 8) + RAND.seq("]1 1,]1 1,[1 1,[1 1, _", 16) /* seq */, 1111 /* Serum00 synt */,24*100/* lpf_f */, 5::ms /* glide dur */,2*data.tick,2,.76);
  8 * data.tick => w.wait;
 } 


fun void  TRANCEHHx8  (int n){ 
  for (0 => int i; i <  n     ; i++) {
    spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
    8 * data.tick => w.wait;
  }
} 
fun void  TRANCESNRHHx8  (int n){ 
  for (0 => int i; i <  n     ; i++) {
   spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
    8 * data.tick => w.wait;
  }
} 

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
//BEAT16x32();



fun void  LOOPLAB  (){ 
  while(1) {
//spork ~ PADS2("}c :8:2 1|3_",12/*n*/,0,.7); 
//spork ~ MOD1("*8{c  1_1_1_1_1_1_1_1_ 8_8_8_8_8_8_8_8_",11/*n*/,3.1/*modf*/,21*11/*modg*/,.3/*modp*/,2,.4) ; 
//    8 * data.tick => w.wait;
//  spork ~ SUPSAWSLIDE  ("*4 }c}c}c 1235 {21235 {21235 {21235 {21235 {21235 {21235 {21235 {2 ", .3 /* filter mod phase */,0,0.7);
//    8 * data.tick => w.wait;
//spork ~ PLOC("{c ____ *2 1", 17, 29 * 100,1,1.4);
// spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */,2,.14); 
//spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */,2,.25);

// spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
//    8 * data.tick => w.wait;
//  spork ~   SINGLEWAV("../_SAMPLES/bitcoin/CPecriventDuCode.wav", 0, .3); 
//  spork ~RANDSERUM2("*8}c}c  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_ }c 1_1_1_1_1_1_1_1_ 1_1_1_1_1_1_1_1_ ",29/*n*/,0/*start_chunk*/,63/*stop_chunk*/,0,.3); 
// spork ~ SERUM00SEQ (" *4 53_1",30/*n*/,"}c:81//f"/*seqcut*/,":86//8"/*seq_g*/,16*data.tick/*d*/,1,.5);
//spork ~   MODU (22, "*4 {c  1__1 _1_1 __1_ 1_1__1" , "1", "f", 2 *1000, 2, .38); 

//spork ~ SYNTGLIDE("*4 5231" /* seq */, 4 /* Serum00 synt */,9*100/* lpf_f */, 5::ms /* glide dur */,32*data.tick,4,1.19);
//spork ~ ERAMP (4/*mixin*/,32*data.tick,":8:25//8"/*gseq*/,":81///88/m"/*lpfseq*/,1/*lpforder*/,1,1.0);
//spork ~ ERAMPOD (4/*mixin*/,32*data.tick,":8:21//1"/*gseq*/,":81////4"/*odseq*/,4.8/*drive*/,0,0.3);

//spork ~   ENSEMBLE (":8 8|a 5|7",16*data.tick,4,1.);

  
  spork ~ BEAT1_64(1); 
  32 * data.tick => w.wait;
  spork ~   TRANCEHHx8 (4); 
  32 * data.tick => w.wait;


  spork ~ BEAT1_64(1); 
  spork ~   TRANCEHHx8 (8); 
  spork ~ SONATA();
  32 * data.tick => w.wait;
  spork ~ SONATA();
  32 * data.tick => w.wait;

  spork ~ BEAT1_64(1); 
  spork ~   TRANCEHHx8 (8); 
  spork ~   ENS1 (); 
  spork ~ SONATA();
  32 * data.tick => w.wait;
  spork ~ SONATA();
  32 * data.tick => w.wait;

  spork ~ BEAT1_64(1); 
  spork ~   TRANCESNRHHx8 (8); 
  spork ~   ENS1 (); 
  spork ~ SONATA();
  32 * data.tick => w.wait;
  spork ~ SONATA();
  32 * data.tick => w.wait;

//  16 * data.tick => w.wait;
1::second / Std.mtof(data.ref_note) => dur comb_dur;
//<<<"comb_dur",comb_dur/1::ms>>>;
//spork ~   COMB ("*8 {c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8 }c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8   " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8 {c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8 }c  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 
//    4 * data.tick => w.wait;

//    32 * data.tick => w.wait;

//spork ~   COMB ("*8   " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,2*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.0); 
//    4 * data.tick => w.wait;
//spork ~   COMB ("*8  " + RAND.seq("1_1_, B___, 8_,  3_1_, 5___, 2_, ",10) ,4*comb_dur/*comb_dur*/,.91/*comb_res*/,1,1.2); 
//    4 * data.tick => w.wait;
// spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
// spork ~ BASS0(" *4   __!1_ ___1 __1_ ___1 __1_ ___1 __1_ ___1    ");
// spork ~ BASS0(" *4 {c  __5_ ___5 __5_ ___5 __5_ ___5 __5_ ___5    ");
//    spork ~  TRANCEHH ("*4 +1 {3  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  "); 
// spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
// spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
// spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 


if ( 0  ){
    
  spork ~KICK_LPF("*4k___ k___ k___ k___k___ k___ k___ ____ " , ":4 M/ff/v");
  spork ~ BASS0_LPF(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 ____ ", ":4 M/ff/v"    );
  spork ~ BASS0HF_LPF(" *4  !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ ____ ", ":4 M/ff/v"    );
  7 * data.tick => w.wait;
  spork ~  TRANCEHH ("*4    }5+3ht_+3{2h  ");
  1 * data.tick => w.wait;

 spork ~ SERUM00SEQ ("*2 _1__",31/*n*/,"}c:81//l"/*seqcut*/,":86//9"/*seq_g*/,16*data.tick/*d*/,1,.8);
  spork ~   ONEP0 (" *4*2 }c}c}c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 32),0, 4.1); 
spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
 spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
 spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
 spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 

//    spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 
// spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
//    spork ~  TRANCEHH ("*4 -4   jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  jjjj  "); 

    8 * data.tick => w.wait;

 spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
 spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
 spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
 spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 
    8 * data.tick => w.wait;
    4 * data.tick => w.wait;
  spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ",0,.7);
    4 * data.tick => w.wait;
  //-------------------------------------------
}
  }
} 
//spork ~ LOOPLAB();
LOOPLAB(); 


// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(0) { /********************************************************/



  8 * data.tick =>  w.wait; 
  // 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);
}  

/// PLAY OR REC /////////////////
RECTRACK rectrack; "l28.wav"=>rectrack.name_main; 0=>rectrack.compute_mode; 1=>rectrack.rec_mode;8*data.tick=>rectrack.main_extra_time;8*data.tick=>rectrack.end_loop_extra_time;
 w.the_end.sync_dur=>rectrack.play_end_sync;
if (rectrack.play_or_rec() ) {
  //////////////////////////////////

  //////////////////////////////////////////////////
  // MAIN 
  //////////////////////////////////////////////////

  //  !!!!!!  Put main code here  !!!!!


  //// STOP REC ///////////////////////////////
  rectrack.rec_stop();
  //////////////////////////////////////////////////

  ///////////////////////// END LOOP ///////////////////////////////////::
  0 => data.next;
  while (!data.next) {
    <<<"**********">>>;
    <<<" END LOOP ">>>;
    <<<"**********">>>;
    // REC END LOOP //////////////////////////////////
    rectrack.rec_end_loop();
    //////////////////////////////////////////////////
    spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k___");
    spork ~ BASS0HF("*4 !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__ !1!1__    ");
    spork ~ BASS0(" *4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1   ");
    spork ~  BASS0_ATTACK ("*4     aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa  ", 0.7 /* rate */, .16 /* g */); 


    8 * data.tick =>  w.wait; 

    //// STOP REC ///////////////////////////////
    rectrack.stop_rec_end_loop();
    /////////////////////////////////////////////
  }

  ///////////////////
  //      END      //
  ///////////////////
  // REC  END  //////
  rectrack.rec_end();
  ///////////////////

  //  !!!!!! put end here  !!!!!!

  //// STOP REC ///////////
  rectrack.stop_rec_end(); 
  /////////////////////////
}  
