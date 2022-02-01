21 => int mixer;


///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.3 /* init Sin Phase */, 24 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.5, 8::ms);
kik.addGainPoint (0.3, 30::ms);
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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 3::ms /* Attack */, 10::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
  SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
   s.wav["V"]=> s.wav["u"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  //s.sync(4*data.tick);// s.element_sync(); //
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();   //  s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////

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
  "amb1_"+ idx + ".wav" => string name;

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
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
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
///////////////////////////////////////////////////////////////////////////////
fun void  NIAP  (int idx, string seq, float playback_gain){ 
  "NIAP_"+ idx + ".wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer + 1);

    playback_gain * data.master_gain  => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    87 => int nb;
    t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.reg(SERUM00 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.reg(SERUM00 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(nb /* synt nb */ ); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    seq => t.seq;
    1.9 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    t.set_adsrs(8::ms, 188::ms, .0002, 400::ms);
    t.set_adsrs_curves(0.8, 0.5, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer + 1);

    t.s.duration + 2::ms => now;


  }

}/////////////////////////////////////////////////////////////////////////////////////////////////

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

fun void BASS15 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
t.set_adsrs(1::samp, data.tick *1/16, 1., 1::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(14 * 10 /* Base */, 24 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STPADSR stpadsr;
stpadsr.set(4::ms /* Attack */, 43::ms /* Decay */, 0.7 /* Sustain */, 10::ms /* Sustain dur of Relative release pos (float)*/,  40::ms /* release */);
stpadsr.setCurves(1.0, 0.7, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE (string seq, int n, float lpf_f,  dur gldur, float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
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

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 0 /* Serum00 synt */, 1000 /* lpf_f */, 50::ms /* glide dur */, .19 /* gain */);



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

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 0 /* Serum00 synt */, 1000 /* lpf_f */, 50::ms /* glide dur */, .19 /* gain */);

//////////////////////////////////////////////////////////////////////////////////
fun void SYNT1 (string seq) {
  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(25 /* synt nb */ , 1.8 /* GAIN */, 2.0 /* in freq gain */,  1 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
//  s0.add(25 /* synt nb */ , 0.4 /* GAIN */, 0.5 /* in freq gain */,  200::ms /* attack */, 2 * data.tick /* decay */, 0.2 /* sustain */, 2* data.tick /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  <<<seq>>>;

  seq => t.seq;
  .015 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 12 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

// STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
// stsynclpfx0.freq(100 /* Base */, 53 * 100 /* Variable */, 2. /* Q */);
// stsynclpfx0.adsr_set(.4 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
// stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
// stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 54 * 100.0 /* freq */ , 2.0 /* Q */ , 3 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 24 * 100 /* freq base */, 32 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 3 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
fun void SYNT2 (string seq) {
  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 1.8 /* GAIN */, 2.0 /* in freq gain */,  1 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
//  s0.add(25 /* synt nb */ , 0.4 /* GAIN */, 0.5 /* in freq gain */,  200::ms /* attack */, 2 * data.tick /* decay */, 0.2 /* sustain */, 2* data.tick /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  <<<seq>>>;

  seq => t.seq;
  .015 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 12 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

// STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
// stsynclpfx0.freq(100 /* Base */, 53 * 100 /* Variable */, 2. /* Q */);
// stsynclpfx0.adsr_set(.4 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
// stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
// stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 54 * 100.0 /* freq */ , 2.0 /* Q */ , 3 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 24 * 100 /* freq base */, 32 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 3 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
1. => stmix.gain;

STREVAUX strevaux;
strevaux.connect(last $ ST, .4 /* mix */); strevaux $ ST @=>  last;  


STMIX stmix1;
stmix1.receive(mixer + 1); stmix1 $ ST @=> last; 
1. => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 






150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
//    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
//   8 * data.tick =>  w.wait;   
//} if(0) {

//   spork ~   AMB1 ( 0 /* idx */, ":4  1111_" , 1./* g */ ); 

   spork ~  SYNT1 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6) ); 
  
  
    spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .3 /* gain */);
   spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.5 ); 
  
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

   8 * data.tick =>  w.wait;   


   spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .3 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.5 ); 
  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.5 /* g */ ); 


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

  8 * data.tick =>  w.wait;   
//   spork ~   AMB1 ( 0 /* idx */, ":4  1111_" , 1.5 /* g */ ); 

   spork ~  SYNT2 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6) ); 
  
  
    spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .3 /* gain */);
   spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.5 ); 
  
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

   8 * data.tick =>  w.wait;   


   spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .3 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.5 ); 
  spork ~   NIAP ( 1 /* idx */, " }c____ _*2 8|5|3_1|3|5_" , 0.5 /* g */ ); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

  8 * data.tick =>  w.wait;   
}
