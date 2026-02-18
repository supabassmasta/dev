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
kik.addGainPoint (1.0, 3 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");
fun void KICK_HPF(string seq, string hpfseq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
fun void KICK_LPF(string seq, string hpfseq) {
  local_delay => now;

  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}///////////////////////////////////////////////////////////////////////////////////////////////
"wt_bass0.wav" => string wt_name;
fun void  prepare_WT  (){ 
    <<<"!!! prepare_WT() !!!">>>;

    1::second => dur wt_dur;

    Step stp0 =>  Envelope e0 =>  SinOsc sin0 => dac; 
    1.0 => sin0.gain;

    1.0 => stp0.next;
    110.0 => e0.value;
    6.7 => e0.target;
    wt_dur * 2 / 8 => e0.duration ;// => now;
    6.7 => e0.value;
    1.5 => e0.target;
    wt_dur * 6  / 8 => e0.duration ;// => now;

  REC rec;
  rec.rec_no_sync(wt_dur, wt_name); 

  1::samp => now;


} 

if ( ! MISC.file_exist(wt_name)){
  prepare_WT();
}

class SERUM_WT0 extends SYNT{

  inlet => Gain factor => Phasor p => OFFSET ofs1 =>Gain g0 =>SinOsc curve => Wavetable w =>  outlet;  
  .00 => ofs1.offset;
  1. => ofs1.gain;
  
  SinOsc sin1 => OFFSET ofs0 =>   g0; 
  1. => ofs0.offset;
  0.03 => ofs0.gain;

  0.8 => sin1.freq;
  1. => sin1.gain;

  1.0 => g0.gain; 
  .16 => p.gain; 
  1 => curve.sync; // phase sync

  .5 => w.gain;
  .5 => factor.gain;

  1 => w.sync;
  1 => w.interpolate;

  SndBuf s => blackhole;
  wt_name => s.read;
  float wt_table[0];
  for (0 => int i; i < s.samples() ; i++) {
     wt_table << s.valueAt(i);
  }

  w.setTable (wt_table);

  fun void on()  {0 * 0.00 =>p.phase; 0 => sin1.phase; }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
SERUM_WT0 s_wt0;
fun void BASS0 (string seq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  1.75 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              t.set_adsrs(2::ms, 10::ms, 1., 2::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 



  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 
//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS0_HPF (string seq, string hpfseq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  1.75 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              t.set_adsrs(2::ms, 10::ms, 1., 2::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 



  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 
//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS0_LPF (string seq, string hpfseq) {
//  local_delay - 15::ms => now;
  local_delay  => now;
  TONE t;
  t.reg(s_wt0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  1.75 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              t.set_adsrs(2::ms, 10::ms, 1., 2::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
  stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
  AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 
//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////////


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
///////////////////////////////////////////////////////////////////////////////////////////////////////
fun void  MOD0  (string seq, int mix, float g){ 
  local_delay => now;
  TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(1 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_
//8_8_ 8_8_ 8_8_ 8_8_ ____ ____ ____ ____ 
//5_3_ 2_1_ 5_3_ 2_1_ 5_3_ 2_1_ 5_3_ ____
seq => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); //
//16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  


SinOsc sin0 =>  s0.inlet;
30.0 => sin0.freq;
300.0 => sin0.gain;

  

STMIX stmix;
stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
 
} 

///////////////////////////////////////////////////////////////////::

fun void PLOC (string seq, int n, float lpf_f, int mix,  float v) {
  local_delay => now;

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

  STMIX stmix;
  stmix.send(last, mixer + mix);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}
///////////////////////////////////////////////////////////////////////
fun void TRIBAL(string seq, int nb, int mix, float g) {

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

  if ( mix  ){
    STMIX stmix;
    stmix.send(last, mixer + mix);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* mix */, .5 /* gain */);
////////////////////////////////////////////////////////////////////////////////////////////

fun void  CELLO0  (string seq, int mix, float g){ 
  local_delay - 15::ms => now;
  TONE t;
  t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

  t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
          // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
              // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
              //t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
              //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 27 * 100 /* Variable */, 2. /* Q */);
stsynclpfx0.adsr_set(.3 /* Relative Attack */, .1/* Relative Decay */, 0.6 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STMIX stmix;
stmix.send(last, mixer + mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void  SINGLEWAV  (string file, int tomix, float g){ 
  local_delay => now;
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
fun void  SUPSAWSLIDE  ( string seq, float ph, int tomix, float g){ 
  local_delay => now;

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



fun string syntwavs_files (int i) {
string str[0];    
/* 0 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN0";
/* 1 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN1";
/* 2 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN2";
/* 3 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN0";
/* 4 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN1";
/* 5 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH0";
/* 6 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH1";
/* 7 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Cello_";
/* 8 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_CombinedChoir_";
/* 9 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_GC3Brass_";
/* 10 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_M300B_";
/* 11 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIBrass_";
/* 12 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIFlute_";
/* 13 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIViolins_";
/* 14 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_StringSection_";
/* 15 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Woodwind2_";
/* 16 */    str<<"../_SAMPLES/SYNTWAVS/Agitato";
/* 17 */    str<<"../_SAMPLES/SYNTWAVS/Breathchoir";
/* 18 */    str<<"../_SAMPLES/SYNTWAVS/FlangOrg";
/* 19 */    str<<"../_SAMPLES/SYNTWAVS/Stalactite";
/* 20 */    str<<"../_SAMPLES/SYNTWAVS/AnalogStr";
/* 21 */    str<<"../_SAMPLES/SYNTWAVS/BriteString";
/* 22 */    str<<"../_SAMPLES/SYNTWAVS/FreezePad";
/* 23 */    str<<"../_SAMPLES/SYNTWAVS/Neptune";
/* 24 */    str<<"../_SAMPLES/SYNTWAVS/AnaOrch";
/* 25 */    str<<"../_SAMPLES/SYNTWAVS/ClearBell";
/* 26 */    str<<"../_SAMPLES/SYNTWAVS/GlassChoir";
/* 27 */    str<<"../_SAMPLES/SYNTWAVS/No.9String";
/* 28 */    str<<"../_SAMPLES/SYNTWAVS/Telesa";
/* 29 */    str<<"../_SAMPLES/SYNTWAVS/AnLayer";
/* 30 */    str<<"../_SAMPLES/SYNTWAVS/CloudNine";
/* 31 */    str<<"../_SAMPLES/SYNTWAVS/GlassMan";
/* 32 */    str<<"../_SAMPLES/SYNTWAVS/Phasensemble";
/* 33 */    str<<"../_SAMPLES/SYNTWAVS/VelocityEns";
/* 34 */    str<<"../_SAMPLES/SYNTWAVS/Apollo";
/* 35 */    str<<"../_SAMPLES/SYNTWAVS/ComeOnHigh";
/* 36 */    str<<"../_SAMPLES/SYNTWAVS/HollowPad";
/* 37 */    str<<"../_SAMPLES/SYNTWAVS/PulseString";
/* 38 */    str<<"../_SAMPLES/SYNTWAVS/BigStrings+";
/* 39 */    str<<"../_SAMPLES/SYNTWAVS/Dreamsphere";
/* 40 */    str<<"../_SAMPLES/SYNTWAVS/Kemuri";
/* 41 */    str<<"../_SAMPLES/SYNTWAVS/SkyOrgan";
/* 42 */    str<<"../_SAMPLES/SYNTWAVS/BigWave";
/* 43 */    str<<"../_SAMPLES/SYNTWAVS/DynaPWM";
/* 44 */    str<<"../_SAMPLES/SYNTWAVS/SmokePad";
/* 45 */    str<<"../_SAMPLES/SYNTWAVS/BottledOut";
/* 46 */    str<<"../_SAMPLES/SYNTWAVS/EnsembleMix";
/* 47 */    str<<"../_SAMPLES/SYNTWAVS/Mars";
/* 48 */    str<<"../_SAMPLES/SYNTWAVS/SoftString";
/* 49 */    str<<"../_SAMPLES/SYNTWAVS/StereoString";
/* 50 */    str<<"../_SAMPLES/SYNTWAVS/MellowStrings";

    if ( i >= str.size() ){
      <<<"ERROR SYNTWAV : FILE number TOO HIGH">>>;
      0=> i; 
    }

    <<<"LOADING ", str [i] >>>;

    return str[i]; 
}

fun void  SPECTR (int note, int nfile, float loopStart, float loopEnd, float pitchShift, int robotize, int whisperize,float spectralBlur,float spectralGate,dur att, dur rel, dur d, int tomix, float v){ 

  ST stmonoin; stmonoin $ ST @=> ST @ last;

  STADSR stadsr;
  stadsr.set(att /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */,0.0/* Sustain dur of Relative release pos (float) */,  rel /* release */);
  stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 

  SpectralSynth ss => stmonoin.mono_in ;
  ss.open(syntwavs_files(nfile) + note + ".wav");
  while( ss.loaded() == 0 )
  {   ss.loadSamples(44100);    // ~1s of audio per batch
      1::samp => now;
  }
  //4096 => ss.fftSize;
  //8 => ss.overlap;
  // load the audio buffer
  ss.pitchShift( pitchShift );
  ss.robotize( robotize );
  ss.whisperize( whisperize );
  ss.spectralBlur( spectralBlur );
  ss.spectralGate( spectralGate );
  ss.loopStart(loopStart);
  ss.loopEnd(loopEnd);

  ss.prepare();
  <<< "  numFrames:", ss.numFrames() >>>;
  while( ss.analyzed() == 0 )       // analyze in batches
  {   ss.analyzeFrames(25);
//      1::samp => now;
//    me.yield();
    10::ms =>now;
  }
  // process in batches of 50 frames, yielding between each
  while( ss.ready() == 0 )
  {
    ss.processFrames( 25 );
//    1::samp => now;
//    me.yield();
    10::ms =>now;
  }
  <<< "  ready:", ss.ready() >>>;

  ss.loop( 1 );
  ss.crossfade(16 * 2048 );
  .7 * v * data.master_gain => ss.gain;

  ss.play();
  stadsr.keyOn(); 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  d => now;
  stadsr.keyOff(); 
  rel => now;
  ss.stop();
} 

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


//////////////////////////////////////////////////////////////////////////////////////////// BPM
//BPM
143 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//1::ms => w.fixed_end_dur;
8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 


//  STCONVREV stconvrev;
//  stconvrev.connect(last $ ST , 29/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .001 * 6 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
STCONVREV stconvrev;
stconvrev.connect(last $ ST , 119/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .05 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last; 
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

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

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

  1000::ms => dur convrevin_dur;
  SndBuf s;
 "../_SAMPLES/ConvolutionImpulseResponse/696509__pe_mace__cello3_eqed_dc.wav" => s.read; 
  s => Gain ir;
  

  STCONVREVIN stconvrevin;
  stconvrevin.connect(last $ ST , ir/*UGen Input Reponse*/ , convrevin_dur /*rev_dur*/, .3 /* rev gain */  , 0.0 /* dry gain */  );       stconvrevin $ ST @=>  last;    

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 13* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  STMIX stmix2;
  stmix2.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT4();

fun void  LOOPPROG  (){ 
    spork ~   MOD0 ("*8 }c {3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_{3f_ ", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 aaa", 0 /* bank */, 3 /* mix */, .5 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*2 }c FFF/11/F", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __g_", 0 /* bank */, 2 /* mix */, 1.6 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c 5_5_", 1, .7); 
    8 * data.tick => w.wait;

    spork ~ TRIBAL("*4 F_", 0 /* bank */, 2 /* mix */, 1.2 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*2 }c f/F____ f8_", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __Z_ __}8Z", 1 /* bank */, 1 /* mix */, .4 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*8 }c 8_8_8_8_", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __f_", 1 /* bank */, 2 /* mix */, 1.0 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*2 }c F/f __ ", 2, .7); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c !f!f_f __FF_", 1, .7); 
    8 * data.tick => w.wait;
    //-------------------------------------------
} 
//spork ~ LOOPPROG();

fun void  LOOPPROG2  (){ 
    //-------------------------------------------

    spork ~   MOD0 ("*4 }c 8_5_", 1, .7); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*8 }c [4f_[4f_[4f_[4f_[4f___[4f_[4f_[4f__ _[4f_[4f_[4f_ ", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __g_", 0 /* bank */, 2 /* mix */, 1.6 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*2 }c F/f __ ", 2, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 a__a", 0 /* bank */, 3 /* mix */, .5 /* gain */);
    8 * data.tick => w.wait;

    spork ~ TRIBAL("*4 F_", 0 /* bank */, 2 /* mix */, 1.2 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c !f!f_f __FF_", 1, .7); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*4 }c 6_6_ 88__", 1, .7); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*8 }c 8_8_8_8_", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __ff", 1 /* bank */, 2 /* mix */, 1.0 /* gain */);
    8 * data.tick => w.wait;
    //-------------------------------------------
    spork ~   MOD0 ("*4 }c 8!5_", 2, .7); 
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*8 }c [4f_[2f_[1f_[4f_[2f___[4f_[2f_[1f__ _[4f_[4f_[4f_ ", 1, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 __g_", 0 /* bank */, 2 /* mix */, 1.6 /* gain */);
    8 * data.tick => w.wait;
    spork ~   MOD0 ("*2 }c f/F __ ", 2, .7); 
    8 * data.tick => w.wait;
    spork ~ TRIBAL("*4 a__a a", 0 /* bank */, 3 /* mix */, .5 /* gain */);
    8 * data.tick => w.wait;

    spork ~ TRIBAL("*4 F_", 0 /* bank */, 2 /* mix */, 1.2 /* gain */);
    8 * data.tick => w.wait;
} 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 
fun void  LOOPSAW  (){ 
    24 * data.tick => w.wait;
    spork ~   CELLO0 (":4 B///B_", 4, 1.6); 
    32 * data.tick => w.wait;
    spork ~   CELLO0 (":4 3//3_", 4, 1.6); 
    32 * data.tick => w.wait;
    spork ~   CELLO0 (":4 1///1_", 4, 1.6); 
    24 * data.tick => w.wait;
    spork ~   CELLO0 (":4 A____", 4,  1.6); 
    spork ~   CELLO0 (":4 _0___", 4,  1.6); 
    spork ~   CELLO0 (":4 __1//1_", 4,1.6); 
    16 * data.tick => w.wait;
    //-------------------------------------------
} 
//spork ~ LOOPSAW();

fun void  LOOPPLOC  (){ 
  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __8_  ", 17, 29 * 100, 3,  1.0 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __5_ __8!1 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f   ", 17, 29 * 100, 1,  1.0 ); 
    8 * data.tick => w.wait;

  spork ~   PLOC ("  {c ____ *4 __F!F!F  ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_ 1_1_8 ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *6  }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;

  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_ __5!8 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 2,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4  }2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F", 17, 29 * 100, 3,  1.0 ); 

  spork ~   PLOC ("  {c ____ *4 __F_  ", 17, 29 * 100, 2,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 _!1!1_ __5!8 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __5_ __8!1 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 {1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f{1!f ", 17, 29 * 100, 3,  1.0 ); 
    8 * data.tick => w.wait;
    //-------------------------------------------
} 

fun void  LOOPPLOC2  (){ 
//  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __8_  ", 17, 29 * 100, 3,  1.0 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __5_ __8!1 ", 17, 29 * 100, 2,  1.2 ); 
    8 * data.tick => w.wait;
//  spork ~   PLOC ("  {c ____ *4 {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f   ", 17, 29 * 100, 1,  1.0 ); 
    8 * data.tick => w.wait;

  spork ~   PLOC ("  {c ____ *4 __F!F!F  ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_ 1_1_8 ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;
//  spork ~   PLOC ("  {c ____ *6  }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D }1!F!E!D ", 17, 29 * 100, 3,  1.2 ); 
    8 * data.tick => w.wait;

  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_ __5!8 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __1_  ", 17, 29 * 100, 2,  1.2 ); 
    8 * data.tick => w.wait;
//  spork ~   PLOC ("  {c ____ *4  }2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F}2!F", 17, 29 * 100, 3,  1.0 ); 

  spork ~   PLOC ("  {c ____ *4 __F_  ", 17, 29 * 100, 2,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 _!1!1_ __5!8 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 __5_ __8!1 ", 17, 29 * 100, 1,  1.2 ); 
    8 * data.tick => w.wait;
  spork ~   PLOC ("  {c ____ *4 {1!f{1!f{1!f{1!f{1!f{1!f{1!f}1!f}1!f}1!f}1!f}1!f}1!f}1!f}1!f}1!f ", 17, 29 * 100, 3,  1.0 ); 
    8 * data.tick => w.wait;
    //-------------------------------------------
} 
//spork ~ LOOPPLOC2();
fun void  LOOPGARG  (){ 


   1* 4 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c f/1", .8/*autoRes phase*/,2,3.7);
  2* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c 851", .7/*autoRes phase*/,2,3.7);
  1* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c FfF__FfF", .7/*autoRes phase*/,2,3.7);
  2* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c ]11]11[11       ", .7/*autoRes phase*/,1,3.7);
spork ~ SUPSAWSLIDE("*1 {c {c ___  ]11]11[11 ", .7/*autoRes phase*/,2,3.7);
  2* 8 * data.tick =>  w.wait; 
  1* 4 * data.tick =>  w.wait; 
  
   /////////////////////
   1* 4 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c ff", .8/*autoRes phase*/,2,3.7);
  2* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c 131", .6/*autoRes phase*/,2,3.7);
  1* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c fFf_FfF", .7/*autoRes phase*/,2,3.7);
  2* 8 * data.tick =>  w.wait; 
spork ~ SUPSAWSLIDE("*1 {c {c ]11]11]11]11 ]11]11  ]11]11    ", .7/*autoRes phase*/,1,3.7);
  2* 8 * data.tick =>  w.wait; 
  1* 4 * data.tick =>  w.wait; 
} 

fun void  LOOPSPECTR  (){ 
       22 * data.tick => w.wait;
spork ~ SPECTR (24/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  4* 8 * data.tick =>  w.wait; 
spork ~ SPECTR (32/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  4* 8 * data.tick =>  w.wait; 
spork ~ SPECTR (29/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  3* 8 * data.tick =>  w.wait; 

spork ~ SPECTR (25/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
spork ~ SPECTR (27/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
spork ~ SPECTR (29/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
  1* 4 * data.tick =>  w.wait; 


} 


fun void  LOOPLAB  (){ 
  while(1) {
    22 * data.tick => w.wait;
spork ~ SPECTR (24/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  4* 8 * data.tick =>  w.wait; 
spork ~ SPECTR (32/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  4* 8 * data.tick =>  w.wait; 
spork ~ SPECTR (29/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 12 * data.tick, 1, 0.2); 
  3* 8 * data.tick =>  w.wait; 

spork ~ SPECTR (25/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
spork ~ SPECTR (27/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
spork ~ SPECTR (29/*note*/,39/*file*/,0.3/*loopStart*/,0.9/*loopEnd*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1 * 2 * data.tick/*att*/, 4 * data.tick/*rel*/, 4 * data.tick, 1, 0.2); 
  1* 4 * data.tick =>  w.wait; 
  1* 4 * data.tick =>  w.wait; 




//  1* 4 * data.tick =>  w.wait; 

//    1* 4 * data.tick =>  w.wait; 
// spork ~ SUPSAWSLIDE("*1 {c {c f/1", .8/*autoRes phase*/,2,3.7);
//   2* 8 * data.tick =>  w.wait; 
// spork ~ SUPSAWSLIDE("*1 {c {c 851", .7/*autoRes phase*/,2,3.7);
//   1* 8 * data.tick =>  w.wait; 
// spork ~ SUPSAWSLIDE("*1 {c {c FfF__FfF", .7/*autoRes phase*/,2,3.7);
//   2* 8 * data.tick =>  w.wait; 
// spork ~ SUPSAWSLIDE("*1 {c {c ]11]11[11       ", .7/*autoRes phase*/,1,3.7);
// spork ~ SUPSAWSLIDE("*1 {c {c ___  ]11]11[11 ", .7/*autoRes phase*/,2,3.7);

//  spork ~KICK_HPF("*4k___ k___ k___ k___k___ k___ k___ k___ " , ":4 M/ff/v");
//  spork ~ BASS0_HPF(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ", ":4 M/ff/v");


    //-------------------------------------------
  }
} 
//spork ~   LOOPSAW (); 

//spork ~ LOOPGARG  ();
//spork ~ LOOPPROG2();
//spork ~ LOOPPLOC2();
//spork ~   SINGLEWAV("l18.wav_end_loop_TEST", 0, 1.0); 
//spork ~ LOOPLAB();
//LOOPLAB(); 


// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(0) { /********************************************************/
//  spork ~ BASS0(" *4  __11 1111 1111 11__ 1111 1111 1111 11__     ");
//  spork ~ BASS0(" *4  __11 1111 1111 11__ ____ 1111 1111 11__      ");
//    spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h_ __h_ __h_ "); 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ _k_k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __81     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ ____ ____ ____ ____ ____ ____ ____ ");
  spork ~ BASS0(" *4  1111  1111 1111 1111 __1_ 1_11 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ }3+4t_h_ __h_ }2+5t_h_ {1+6t_h_ {3+6t_h_   "); 
  8 * data.tick =>  w.wait; 
}

/// PLAY OR REC /////////////////
RECTRACK rectrack; "l18.wav"=>rectrack.name_main; 0=>rectrack.compute_mode; 1=>rectrack.rec_mode;8*data.tick=>rectrack.main_extra_time;8*data.tick=>rectrack.end_loop_extra_time;
if (rectrack.play_or_rec() ) {
  //////////////////////////////////

  //////////////////////////////////////////////////
  // MAIN 
  //////////////////////////////////////////////////
  if ( 1  ){
  spork ~KICK_LPF("*4 k___ k___ k___ k___k___ k___ k___ k___    k___ k___ k___ k___k___ k___ k___ k___ k___ k___ k___ k___k___ k___ k___ k___    k___ k___ k___ k___k___ k___ ", ":8:4M/1");
  spork ~ BASS0_LPF(" *4 1111  __11 1111 1111 __11 1111 _111 __11   1111  __11 1111 1111 __11 1111 _111 __11    1111  __11 1111 1111 __11 1111 _111 __11   1111  __11 1111 1111 __11 1111   ", ":8:4M/1");

  8 * data.tick =>  w.wait; 
  spork ~ TRIBAL("____ *4 abab", 0 /* bank */, 3 /* mix */, .7 /* gain */);
  spork ~   PLOC ("  {c *4 {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f
                                {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f {1*7:8!f  ", 17, 29 * 100, 1,  1.0 ); 
  8 * data.tick =>  w.wait; 
  spork ~   CELLO0 (":4 F////f_", 2, 0.2); 
  spork ~   CELLO0 (":4 B////f_", 3, 0.2); 
  spork ~   CELLO0 (":4 1////f_", 2, 0.2); 
   14 * data.tick => w.wait;
  spork ~KICK(" *4 ___k k_k_ ");
  spork ~  TRANCEHH ("*4 +3   }5+3  ____ ___t "); 

   2 * data.tick => w.wait;
  }


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
// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  8 * data.tick =>  w.wait; 
  spork ~ SUPSAWSLIDE("*1 {c {c f/1", .8/*autoRes phase*/,2,3.7);
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  8 * data.tick =>  w.wait; 
  spork ~ SUPSAWSLIDE("*1 {c {c _____FfF", .7/*autoRes phase*/,2,3.7);
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ ____ ____");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 ____ ____      ");
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h ___h_ __h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h ___h_ __h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~ RING(":4{c  m////f f////M", ":8:2 H/GG/A"/*fmod*/, ":8:2 m/1"/*gmod*/,6/*k*/,16*data.tick, 1,.3);
  spork ~ SLIDENOISE(800/*fstart*/,5100/*fstop*/,16*data.tick/*dur*/,24.8/*width*/,2,.09); 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h ___h_ __h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ ____ ____ ____ ____ ____ ____ ____ ");
  spork ~ BASS0(" *4  1111  1111 1111 1111 __1_ 1_11 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   __h_ __h_ __h_ __h_ __h ___h_ __h_ "); 
  8 * data.tick =>  w.wait; 

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  spork ~ LOOPPROG();
  spork ~ LOOPPLOC();
  spork ~ LOOPSAW();

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ _k_k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __81     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ ____ ____ ____ ____ ____ ____ ____ ");
  spork ~ BASS0(" *4  1111  1111 1111 1111 __1_ 1_11 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ }3+4t_h_ __h_ }2+5t_h_ {1+6t_h_ {3+6t_h_   "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ _k_k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __81     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK_HPF("*4k___ k___ k___ k___k___ k___ k___ k___ " , ":4 M/ff/v");
  spork ~ BASS0_HPF(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ", ":4 M/ff/v");
  8 * data.tick =>  w.wait; 

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  spork ~ LOOPGARG  ();
  spork ~ LOOPPROG2();
  spork ~ LOOPPLOC2();

  spork ~ LOOPSAW();
  spork ~ LOOPSPECTR();

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ _k_k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __81     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ ____ ____ ____ ____ ____ ____ ____ ");
  spork ~ BASS0(" *4  1111  1111 1111 1111 __1_ 1_11 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ }3+4t_h_ __h_ }2+5t_h_ {1+6t_h_ {3+6t_h_   "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ _k_k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __81     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k__k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ ___k");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 
  spork ~KICK("*4 k___ k___ k___ k___k___ k___ k___ k_k_");
  spork ~ BASS0(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ");
  spork ~  TRANCEHH ("*4 +3 {2 __h_   }5+3t_h_ __h_ t_h_ __h_ t_h ___h_ t_h_ "); 
  8 * data.tick =>  w.wait; 

  spork ~KICK_HPF("*4k___ k___ k___ k___k___ k___ k___ k___ " , ":4 M/ff/v");
  spork ~ BASS0_HPF(" *4  1111  __11 1111 1111 __11 1111 _111 __11     ", ":4 M/ff/v");
  8 * data.tick =>  w.wait; 

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


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

