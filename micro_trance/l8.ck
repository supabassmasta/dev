15 => int mixer;

fun void TRANCEBREAK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
// SEQ s3; SET_WAV.TRANCE(s3);
 s.wav["k"] => s.wav["K"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .49 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  0.9 => s.wav_o["K"].wav0.rate;
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
  SET_WAV.TRIBAL(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.ACOUSTIC(s3);
 s3.wav["H"] => s.wav["o"];  // act @=> s.action["a"]; 
 s3.wav["j"] => s.wav["j"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
//  s.gain("t", .6); // for single wav 
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
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("t", .4); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   1.8 => s.wav_o["t"].wav0.rate;
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

fun void BASS (string seq) {
  TONE t;
  t.reg(PSYBASS6 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .90 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(4::ms, 19::ms, .8, 87::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 216.1 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

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
86.0 => tri0.gain;
0.5 => tri0.width;

SinOsc sin0 =>  m;
0.1 => sin0.freq;
1.0 => sin0.gain;


fun void LEAD (string seq) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(1 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .23 * data.master_gain => t.gain;
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

//  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
//  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 3 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

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
fun void PADS (string seq) {
  TONE t;
  t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  s2.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .35 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .05 /* mix */, 12 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 

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

////////////////////////////////////////////////////////////////////////////////////////////
fun void  RANDSERUMMOD  (string begin, int nb){ 

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
  t.reg(SERUM0 s0); s0.config(18,0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .55 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


  // MOD 
  SinOsc sin0 => OFFSET ofs0 => s0.inlet;
  250. => ofs0.offset;
  1. => ofs0.gain;

  1.4 => sin0.freq;
  200.0 => sin0.gain;

  Std.rand2f(0, 1.) => sin0.phase;


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
  .5 * data.master_gain => t.gain;
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



SYNC sy;
sy.sync(1 * data.tick);

0.9 => data.master_gain;

151 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
.65 => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 7 * 100 /* freq base */, 26 * 100 /* freq var */, data.tick * 9 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  




///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"Harpie_main.wav" => string name_main;
"Harpie_aux.wav" => string name_aux;
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


//if ( 0  ){ // MAGIC //////////////////////////
    

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
//   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

 spork ~   SINGLEWAV("../_SAMPLES/harpie/2.wav", .5); 

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
//   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
//   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ ____ "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
//   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2322 , .4); 
   4 * data.tick =>  w.wait;   

    spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 4* data.tick /* dur */, .5 /* width */, .24 /* gain */);

   4 * data.tick =>  w.wait;   
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___  "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1", 2322 , .4); 
   8 * data.tick =>  w.wait; 

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ ____ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  _jjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2322 , .4); 
   8 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ ____ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  _jjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2322 , .4); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~   SINGLEWAV("../_SAMPLES/harpie/1.wav", .5); 

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ ____ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2322 , .4); 
   8 * data.tick =>  w.wait;   

  //////////////////////////////////////////////////////////////////////////:

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  //////////////////////////////////////////////////////////////////////////:

  spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);

   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1", 2322 , .4); 
   8 * data.tick =>  w.wait;   
//////////////////////////////////////////////////////////////////////////////////////////////////
  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);

   8 * data.tick =>  w.wait;   


   spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


///////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   8 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   4 * data.tick =>  w.wait;   
   spork ~   SINGLEWAV("../_SAMPLES/harpie/1.wav", .5); 
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ ____ K___ ____ K___ ____ K_K_ KKKK "); 
   spork ~  BASS        ("*4 ____ ____   ____    ____      ____   ____   !1_!5!1 !0!1!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___ f////11___ f////11___"); 
   8 * data.tick =>  w.wait;   

///////////////////////////////////////////////////////////////////////////////////////////

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _3_1 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _5_1 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _1_8 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ ____ K___ ____ K___ ____ K_K_ KKKK "); 
   spork ~  BASS        ("*4 ____ ____   ____    ____      ____   ____   !1_!5!1 !0!1!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___ f////11___ f////11___"); 
   8 * data.tick =>  w.wait;   

///////////////////////////////////////////////////////////////////////////////////////////

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _3_1 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _5_1 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _1_8 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ ____ K___ ____ K___ ____ K_K_ KKKK "); 
   spork ~  BASS        ("*4 ____ ____   ____    ____      ____   ____   !1_!5!1 !0!1!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___ f////11___ f////11___"); 
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _3_1 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _5_1 _1__", 2327 , .4);
   4 * data.tick =>  w.wait;   
   spork ~   SINGLEWAV("../_SAMPLES/harpie/2.wav", .5); 
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 ____ ___!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___"); 
   spork ~   ACID ("*4 }c ____ !1!1_1 _1__ 1!1!1_ __8_ 5!1_1 _1_8 _1__", 2327 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ ____ K___ ____ K___ ____ K_K_ KKKK "); 
   spork ~  BASS        ("*4 ____ ____   ____    ____      ____   ____   !1_!5!1 !0!1!8!1"); 
   spork ~  BASS2        ("*4 {c f////11___ f////11___ f////11___"); 
   8 * data.tick =>  w.wait;   

//} // MAGIC /////////////////////////////////////////

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

// END LOOP

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

   spork ~   SINGLEWAV("../_SAMPLES/harpie/1.wav", .5); 

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_KK "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ ____ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2322 , .4); 
   8 * data.tick =>  w.wait;   

  //////////////////////////////////////////////////////////////////////////:

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ _jjj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCEHH    ("*4 -4    __j_ __jj __j_ __jj __j_  __j_ __jj __o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
 
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   

  //////////////////////////////////////////////////////////////////////////:


  spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);

   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c  !1!1!1_ _1_0 _1__ 1_1_ !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1", 2322 , .4); 
   8 * data.tick =>  w.wait;   
//////////////////////////////////////////////////////////////////////////////////////////////////
  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c__1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2320 , .5); 
   8 * data.tick =>  w.wait;   

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  tjjj o   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!5!1 !0!1!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c !1!1!1_ _1_0 _1__ 1_1_ __8_ _1_1 _1__ 5 _1_", 2320 , .5); 
   
   8 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  TRANCESNR    ("*4 -4    __j_ t_jj __j_ tjjt __j_  t_j_ __jj t_o_   "); 
   spork ~  BASS        ("*4 !1_!1!1 !1__!1 !1_!1!1 !1_!5!1   !1_!1!1 !1__!1 !1_!1!1 !1_!8!1"); 
   spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   spork ~   ACID ("*4 }c}c __1_ _1_1 _1__ 1_1_ __8_ _1_1 _1__ 1 _1_", 2322 , .4);

   8 * data.tick =>  w.wait;   


   spork ~  SLIDENOISE(200 /* fstart */, 4000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .24 /* gain */);

  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1 85F1 F185 85F1 F185 " /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   
  spork ~ SYNTGLIDE("*4 }c  85F1 85F1 85F1 85F1   F81F81F81F81F81F81" /* seq */, 37::ms /* glide dur */, 8 /* synt_nb */, .44 /* gain */);
   8 * data.tick =>  w.wait;   


///////////////////////////////////////////////////////////////////////////////////////////





  
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


   spork ~   SINGLEWAV("../_SAMPLES/harpie/1.wav", .5); 

   16 * data.tick =>  w.wait;   


  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

 


