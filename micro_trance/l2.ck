15 => int mixer;

fun void TRANCEBREAK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
// SEQ s3; SET_WAV.TRANCE(s3);
// s3.wav["k"] => s.wav["K"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .87 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
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

fun void BASS (string seq) {
  TONE t;
  t.reg(PSYBASS6 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .79 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(4::ms, 19::ms, .8, 87::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 248.1 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

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

////////////////////////////////////////////////////////////////////////////////////////////
fun void  RandSERUMMOD  (string begin, int nb){ 

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
  .45 * data.master_gain => t.gain;
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

//spork ~   RandSERUMMOD ("}c *8 ", Std.rand2(8, 16));   4 * data.tick =>  w.wait; 

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
      ["1", "1", "f", "F", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(syntRand s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .4 * data.master_gain => t.gain;
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

//spork ~  Rand("*4 }c" /* Seq begining */ , 12 /* Nb rand elements */ ); 
//////////////////////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU7 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
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
stmix.send(last, mixer + 2  );

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////
SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

151 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

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

STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .8);  ech2 $ ST @=>  last; 





///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"MrRobot_main.wav" => string name_main;
"MrRobot_aux.wav" => string name_aux;
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

//    strevaux.connect(stauxout $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

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



/********************************************************/
//if (    0     ){
//}
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K_K_ KKKK "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

 spork ~   SINGLEWAV("../_SAMPLES/MrRobot/full.wav", .7); 

  for (0 => int i; i < 6       ; i++) {
   
  <<<"i", i>>>;


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4}c }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 12 /* Nb rand elements */ );
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4}c }c" /* Seq begining */ , 12 /* Nb rand elements */ );
   4 * data.tick =>  w.wait;   



  }

  ////////////////////////////////////////////////////////////////////////////

 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ KK_ KK_KK "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 16 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c *8 ", 32);   
   4 * data.tick =>  w.wait;   

//} if (0) {

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~ DISTMOD ("*8 f81f 81f8 1f81 f81_   f81f 81f8 1f81 f81_");
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K_K_ KKKK "); 
   spork ~ DISTMOD ("*8 f_f_ f_f_ 1_1_ 1_1_  8_8_ 8_8_  *2 f_f_ f_f_ f_f_ f_f_ ");
   4 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~ DISTMOD ("*8}c f81f 81f8 1f81 f81_   f81f 81f8 1f81 f81_");
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K_K_ KKKK "); 
   spork ~ DISTMOD ("*8}c f_f_ f_f_ 1_1_ 1_1_  8_8_ 8_8_  *2 f_f_ f_f_ f_f_ f_f_ ");
   4 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////


   spork ~   LEAD ("}c __ *4 5353 0011 "); 
   spork ~   SUPERHIGH ("*8 }c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!B!7!1"); 
   spork ~ DIST ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
 
   spork ~   LEAD ("}c __ *4 5_51 0_11 "); 
   spork ~   SUPERHIGH ("*8 }c}c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
 
   4 * data.tick =>  w.wait;   
 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!1"); 
   spork ~ DIST ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////
 
   spork ~   LEAD ("}c __ *8 5_51 0_11 5_5_ 0_11 "); 
   spork ~   SUPERHIGH ("*8 }c}c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__ K _K_K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!B!5!8"); 
   spork ~ DIST ("*8 f_1_ 1___ f_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
 
   spork ~   LEAD ("}c *8 1155 3333 1111 5151 5_51 0_11 5_51 0_11 "); 
   spork ~ DIST ("*8 f_1_ 1___ f_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   spork ~  TRANCEBREAK ("*4 K___ ____ K___ K___ "); 
 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K_K_ KKKK *2 KKKK KKKK "); 
   spork ~   LEAD ("}c *8 1155 3333 1111 5151 10_1 15_5 F//// ////f "); 
   spork ~ DIST ("*8 f_1_ 1___ f_1_ 1_1_   " );
   4 * data.tick =>  w.wait;   


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_KK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!3"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__K K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !8!1!8!0"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   f81f 81f8 1f81 f81_");
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___  "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh  "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 4 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(4, 8));   
   2 * data.tick =>  w.wait;   
 spork ~   SINGLEWAV("../_SAMPLES/MrRobot/getintothesystem.wav", .8); 
   2 * data.tick =>  w.wait;   

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




   spork ~ MODU6(324, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_KK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!3"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~ MODU6(324, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__K K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   


   spork ~ SLIDENOISE  (100, 2500, 7 *data.tick, 0, .3 );

   spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___  "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh  "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 4 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(4, 8));   
   2 * data.tick =>  w.wait;   
 spork ~   SINGLEWAV("../_SAMPLES/MrRobot/zerodays.wav", .8); 
   2 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////


   spork ~   LEAD ("}c __ *4 5353 0011 "); 
   spork ~   SUPERHIGH ("*8 }c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!B!7!1"); 
   spork ~ DIST ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
 
   spork ~   LEAD ("}c __ *4 5_51 0_11 "); 
   spork ~   SUPERHIGH ("*8 }c}c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
 
   4 * data.tick =>  w.wait;   
 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!1"); 
   spork ~ DIST ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


   spork ~   LEAD ("}c __ *4 5353 0011 "); 
   spork ~   SUPERHIGH ("*8 }c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!B!7!1"); 
   spork ~ DIST ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~ SLIDENOISE  (2500, 100, 13 *data.tick, 0, .3 );

   spork ~   LEAD ("}c __ *4 5_51 0_11 "); 
   spork ~   SUPERHIGH ("*8 }c}c 1_1_ __1_ __1_ 1___"); 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
 
   4 * data.tick =>  w.wait;   

 
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_K_K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!1"); 
   spork ~ DIST ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////
   2 * data.tick =>  w.wait;   
   spork ~   SINGLEWAV("../_SAMPLES/MrRobot/exploit.wav", .8); 
   2 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1"); 
   8 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K_K_ "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1"); 
   8 * data.tick =>  w.wait;   

  for (0 => int i; i <  3     ; i++) {
   
 
  spork ~ MODU7(298, " }c" + RAND.seq("1_,_,5,F_,_,_,*41_1_1_1_:4", 8), "{c{c Z//MM/WW//Z ", "}c  f", 49 *100, .20); 
  spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("____ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1"); 
   8 * data.tick =>  w.wait;   
  spork ~ MODU6(329, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("____ *4*2  " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K__K "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1"); 
   8 * data.tick =>  w.wait;   
  }


   spork ~ SLIDENOISE  (100, 2500, 15 *data.tick, 0, .3 );
  
  spork ~ MODU7(298, " }c" + RAND.seq("1_,_,5,F_,_,_,*41_1_1_1_:4", 8), "{c{c Z//MM/WW//Z ", "}c  f", 49 *100, .20); 
  spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("____ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1"); 
   8 * data.tick =>  w.wait;   
  spork ~ MODU6(329, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 8), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("____ *4*2  " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 6), 4.1);
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___  "); 
   spork ~  BASS        ("*4 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 !1!3!2!1 !1!0!2!1 "); 
   5 * data.tick =>  w.wait;   
   spork ~   SINGLEWAV("../_SAMPLES/MrRobot/Ilive4thisShit.wav", .8); 
   3 * data.tick =>  w.wait;   


  //////////////////////////////////////////////////////////////////////////////////:::

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////



0 => data.next;
while (!data.next) {
    <<<"********">>>;
    <<<"END LOOP">>>;
    <<<"********">>>;
/////////////////////////////////////////////////////////////////////

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



   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 8_1_ f___ 1_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_KK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!3"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__K K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !8!1!8!0"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   f81f 81f8 1f81 f81_");
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___  "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh  "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 4 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(4, 8));   
   2 * data.tick =>  w.wait;   
 spork ~   SINGLEWAV("../_SAMPLES/MrRobot/getintothesystem.wav", .8); 
   2 * data.tick =>  w.wait;   

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




   spork ~ MODU6(324, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K__K "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_KK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!3"); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~ MODU6(324, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__K K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!3!1"); 
   spork ~  Rand("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   


   spork ~ SLIDENOISE  (100, 2500, 7 *data.tick, 0, .3 );

   spork ~ MODU6(326, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .39); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1);
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___  "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh  "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 "); 
   spork ~  Rand("*4 }c}c" /* Seq begining */ , 4 /* Nb rand elements */ );
   spork ~   RandSERUMMOD ("}c}c __ *8 ", Std.rand2(4, 8));   
   2 * data.tick =>  w.wait;   
 spork ~   SINGLEWAV("../_SAMPLES/MrRobot/zerodays.wav", .8); 
   2 * data.tick =>  w.wait;   


/////////////////////////////////////////////////////////////////////
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

   spork ~ SLIDENOISE  (2500, 100, 8 *data.tick, 0, .3 );
   2 * data.tick =>  w.wait;   

   spork ~   SINGLEWAV("../_SAMPLES/MrRobot/programaticexpression.wav", .8); 
   12 * data.tick =>  w.wait;   


  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

 


