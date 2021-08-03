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



151 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;


/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

  ////////////////////////////////////////////////////////////////////////////


   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ KK_ KK_KK "); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 16 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c *8 ", 32);   
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
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 1_1_ 1___ 8_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K_KK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!8!5!3"); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   __f_ 8_18 1___ 8_8_" );
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K__K K_K_ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !8!1!8!0"); 
   spork ~  RAND("*4 }c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   

   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
   spork ~ DISTMOD ("*8 f_1_ 1___ f_1_ 1_1_   f81f 81f8 1f81 f81_");
   4 * data.tick =>  w.wait;   
   spork ~  TRANCEBREAK ("*4 K___ K___ K_K_ KKKK "); 
   spork ~  TRANCEHH ("*4 +3 hhhh shhh hhhh shhh "); 
   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !5!3!1!5 !3!1!5!3"); 
   spork ~  RAND("*4 }c}c" /* Seq begining */ , 8 /* Nb rand elements */ );
   spork ~   RANDSERUMMOD ("}c}c __ *8 ", Std.rand2(8, 16));   
   4 * data.tick =>  w.wait;   



//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
//   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
//   spork ~ DIST ("*4 1_1_ 1___ *2 1_1_1_8_  " );
//   4 * data.tick =>  w.wait;   
//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
//   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
//   spork ~ DIST ("*4 1_1_ 1___ " );
//   4 * data.tick =>  w.wait;   
//   spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
//   spork ~  BASS        ("*4 !1!1!1!1 !1!1!1!1 !1!1!1!1 !1!1!1!1"); 
//   spork ~ DIST ("*8 1_1_ 1_8_  1___1_8_ __1_1_8  " );
//   4 * data.tick =>  w.wait;   


}


