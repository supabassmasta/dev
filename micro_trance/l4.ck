17 => int mixer;

fun void TRANCEBREAK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
// SEQ s3; SET_WAV.TRANCE(s3);
 s.wav["k"] => s.wav["K"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  .7 => s.wav_o["K"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STDUCKMASTER duckm;
  duckm.connect(last $ ST, 6. /* In Gain */, .10 /* Tresh */, .5 /* Slope */, 30::ms /* Attack */, 100::ms /* Release */ );      duckm $ ST @=>  last; 

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
// s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("s", 1.4); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   1.1 => s.wav_o["S"].wav0.rate;
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


//spork ~  TRANCEBREAK ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 

class syntBass extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SawOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;  .44 => s[i].width;  .8 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final;    2. => detune[i].gain;.33 => s[i].width;    .5 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
    0 => s[0].phase;
    0 => s[1].phase;
          } 1 => own_adsr;
} 

fun void BASS (string seq) {
  TONE t;
  t.reg(syntBass s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c  {c" + seq => t.seq;
  0.9 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//  t.adsr[0].set(4::ms, 19::ms, .8, 87::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(20::ms /* Attack */, 10 *10::ms /* Decay */, 0.6 /* Sustain */, -.1 /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(30 * 10 /* Base */, 75 * 10 /* Variable */, 1.1 /* Q */);
stsynclpfx0.adsr_set(.02 /* Relative Attack */, .4/* Relative Decay */, 0.3 /* Sustain */, .2 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.6, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//ADSRMOD adsrmod; // Direct ADSR freq input modulation
//adsrmod.adsr_set(0.01 /* relative attack dur */, 0.01 /* relative decay dur */ , 1.0 /* sustain */, - 0.1 /* relative sustain pos */, .3 /* relative sustain dur */);
//adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
//adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 


  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23 * 10 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
fun void BASS3 (string seq) {
  TONE t;
  t.reg(syntBass s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c  {c" + seq => t.seq;
  0.85 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//  t.adsr[0].set(4::ms, 19::ms, .8, 87::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(20::ms /* Attack */, 10 *10::ms /* Decay */, 0.6 /* Sustain */, -.15 /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(30 * 10 /* Base */, 90 * 10 /* Variable */, 1.2 /* Q */);
stsynclpfx0.adsr_set(.02 /* Relative Attack */, .4/* Relative Decay */, 0.3 /* Sustain */, .2 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.6, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//ADSRMOD adsrmod; // Direct ADSR freq input modulation
//adsrmod.adsr_set(0.01 /* relative attack dur */, 0.01 /* relative decay dur */ , 1.0 /* sustain */, - 0.1 /* relative sustain pos */, .3 /* relative sustain dur */);
//adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
//adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 


  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 165 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void  BASS2  (string seq){ 
   TONE t;
   t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.add(0 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 0.50 /* in freq gain */,  0.5 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
   s0.add(0 /* synt nb */ , 1 /* rank */ , 0.2 /* GAIN */, 0.501 /* in freq gain */,  0.5 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
   s0.add(0 /* synt nb */ , 1 /* rank */ , 0.2 /* GAIN */, 0.498 /* in freq gain */,  0.5 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
   // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
//   s0.add(3 /* synt nb */ , 0.2 /* GAIN */, 0.2501 /* in freq gain */,  .5 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
   // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   1.6 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();//  
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


   1::samp => now;
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
  .28 * data.master_gain => t.gain;
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
  .25 * data.master_gain => t.gain;
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


fun void LEAD (string seq, int nb, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(nb /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


  ADSRMOD adsrmod; // Direct ADSR freq input modulation
  adsrmod.adsr_set(0.1 /* relative attack dur */, 0.1 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
  adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
  adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//////////////////////////////////////////////////////////////////////////////////


fun void LEAD2 (string seq, int nb, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SERUM00 s1);  
  t.reg(SERUM00 s2);  
  s0.config(nb /* synt nb */ ); 
  s1.config(nb /* synt nb */ ); 
  s2.config(nb /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


  ADSRMOD adsrmod; // Direct ADSR freq input modulation
  adsrmod.adsr_set(0.1 /* relative attack dur */, 0.1 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
  adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
  adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 30* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////




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
   s0.add(22 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(9 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 

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


//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

// MOD LEAD
TriOsc tri0 => /* MULT m => */ Gain modLead;
83.0 => tri0.freq;
14.0 => tri0.gain;
0.5 => tri0.width;

//SinOsc sin0 =>  m;
//0.1 => sin0.freq;
//1.0 => sin0.gain;


fun void MODLEAD (string seq, int nb, float g) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(nb /* synt nb */ , 2 /* rank */ ); 
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


ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
" 18F1818F811F81  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 10 * 100 /* freq base */, 30 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////
150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

//SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;
//4*data.tick => w.sync_end_dur;


// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

//STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
//stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .03 /* mix */, 9 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

//STMIX stmix2;
//stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

//STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
//stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 7 * 100 /* freq base */, 26 * 100 /* freq var */, data.tick * 9 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  


   if ( 1  ){
       
   spork ~  BASS2        ("  1////1____"); 
   spork ~   SUPERHIGH ("____ *8}c 1_1___1_1_1___1_"); 
   8 * data.tick =>  w.wait;   
   spork ~  BASS2        ("  1////1____"); 
   spork ~   SUPERHIGH ("____ *8}c 1___1_1_1___1_1_"); 
   8 * data.tick =>  w.wait;   
   spork ~  BASS2        ("  1////1____"); 
   spork ~   SUPERHIGH ("____ *8}c 1_1_1_1_1_1_1_1_"); 
   8 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ ____ ____ K___K___ K_K_ K_K_ KKKK "); 
   spork ~   SUPERHIGH ("*8}c 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_}c 1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_"); 
   spork ~   MODLEAD ("{c F//// ////f " , 12, .5); 
   spork ~  BASS2        ("  1//// ////1"); 
   8 * data.tick =>  w.wait;   

   }



//while(1) { /********************************************************/
if ( 0  ){

}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/


//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/


//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
//   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
//   spork ~  BASS        ("*4 __!1!1__!1!1__!1!1__!1!1__!1!1__!1!1__!1!1_ _!5_"); 
//   spork ~  BASS        ("*2 _1_1_1_1_1_1_1__"); 
//   8 * data.tick =>  w.wait;   



//}
//if ( 0  ){
    

   spork ~   MODLEAD ("*4 {c 8////1 _1__ F////1____ " , 12, .4); 
   spork ~   LEAD ("___ *8 {c 1_1_1_1_1_1_1_1_ " , 10, .3); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
   spork ~  BASS        ("*4 __!1!1__!1!1__!1!1__!1!1__!1!1__!1!1__!1!1_ _!5_"); 
   8 * data.tick =>  w.wait;   

   spork ~   MODLEAD ("*4 F////f _1__ f////F____ " , 12, .4); 
   spork ~   SUPERHIGH ("____ *8 1_1_1_1_8_1___1_"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
   spork ~  BASS        ("*4 __!1!1__!1!1__!1!1__!1!1__!1!1__!1!1__!1!1_ _!5!1"); 
   8 * data.tick =>  w.wait;   


   spork ~   MODLEAD ("*8 8_8_8////ff////F 8243431341 " , 12, .5); 
   spork ~   LEAD ("*8 {c 1_1_1_1_1_1_1___1_1_8_5_3_1 " , 16, .3); 
//   spork ~   SUPERHIGH ("____ *8}c 1_1_8_1_1_1___1_"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
   spork ~  BASS        ("*4 __!1!1__!1!1__!1!1__!1!1__!1!1__!1!1__!1!1_ _!5_"); 
   8 * data.tick =>  w.wait;   



   spork ~   LEAD2 ("*4{c  1|3|5__1|3|5_ 1|3|5__1|3|5_1|3|5__1|3|5_ 1|3|5__1|3|5_ *2 1|3|5_1|3|5_1|3|5_1|3|5_" , 58, .3); 
   spork ~   MODLEAD ("{c F//// ////f " , 12, .4); 
   spork ~   MODLEAD (" f//// ////F " , 12, .4); 
   spork ~  TRANCEBREAK ("*4 K___ ____ ____ K___K___ K_K_ K_K_ KKKK "); 
   8 * data.tick =>  w.wait;   


   spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
//   spork ~  BASS3        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 "); 
   spork ~  BASS3        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!0 !1!5!3!1 "); 
   8 * data.tick =>  w.wait;   
   spork ~   SUPERHIGH ("*8 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
//   spork ~  BASS3        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 "); 
   spork ~  BASS3        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!0 !1!5!3!8 "); 
   8 * data.tick =>  w.wait;   
   spork ~   SUPERHIGH ("*8}c 1_1_ __1_ 1_1_ __1_  1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
   spork ~  BASS3        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!0 !1!5!3!1 "); 
   8 * data.tick =>  w.wait;   

   spork ~   LEAD2 ("*4 {c 1|3|5__1|3|5_ 1|3|5__1|3|5_1|3|5__1|3|5_ 1|3|5__1|3|5_ *2 1|3|5_1|3|5_1|3|5_1|3|5_" , 43, .3); 
   spork ~   MODLEAD ("{c F//// ////f " , 12, .5); 
   spork ~   MODLEAD (" f//// ////F " , 12, .5); 
   spork ~  TRANCEBREAK ("*4 K___ ____ ____ K___K___ K_K_ K_K_ KKKK "); 
   8 * data.tick =>  w.wait;   

//
//   spork ~   LEAD ("*8 {c 1_1_1_1_1_1_1_1_ " , 12, .5); 

//   spork ~   LEAD2 ("*4  1|3|5__1|3|5_ 1|3|5__1|3|5_1|3|5__1|3|5_ 1|3|5__1|3|5_ *2 1|3|5_1|3|5_1|3|5_1|3|5_" , 45, .4); 

//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__KK___ K___ K___ K_K_ "); 
//   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh__h_ s_hh __h_ shhh "); 
//   spork ~  BASS        ("*4 __!1!1__!1!1__!1!1__!1!1__!1!1__!1!1__!1!1_ _!5_"); 
//   spork ~  BASS        ("*4 _!1__ _!1 _!1 __!1_ _!1_!1 ___!1 _!1__ !5__!1"); 
//   spork ~  BASS2        ("  1////1____"); 

//   spork ~   PADS (" *4 __1|3|5_ __1|3|5_ ____ __:21|3|5"); 

//   8 * data.tick =>  w.wait;   

//   spork ~   LEAD ("*4 8_8_5_3_1__11 " , 0, .2); 
//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
//   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
//   spork ~  BASS        ("*4 __!1!1 __!1!1 __!1!1 __8//1"); 
//   spork ~   PADS (" *4 __1|3|5_ __1|3|5_ ____ __:21|3|5"); 

//   4 * data.tick =>  w.wait;   


}


