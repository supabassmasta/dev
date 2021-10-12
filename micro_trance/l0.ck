13 => int mixer;

fun void TRANCEBREAK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
// SEQ s3; SET_WAV.TRANCE(s3);
// s3.wav["k"] => s.wav["K"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .80 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  .7 => s.wav_o["K"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  // SUBWAV //// 
//  SEQ s2; SET_WAV.TRANCE_KICK(s2); s.add_subwav("K", s2.wav["K"]); 
//  s.gain_subwav("K", 0, .12);
  s.go();     s $ ST @=> ST @ last; 

  STDUCKMASTER duckm;
  duckm.connect(last $ ST, 6. /* In Gain */, .10 /* Tresh */, .5 /* Slope */, 3::ms /* Attack */, 100::ms /* Release */ );      duckm $ ST @=>  last; 

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
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", .12); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
   1.1 => s.wav_o["S"].wav0.rate;
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


class syntBASS extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .5 => s.phase;
          } 0 => own_adsr;
}

//spork ~  TRANCEBREAK ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
class PSYBASSX extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
    
    1.0 => s.width;

    .25 => padsrin.gain;
    padsrin.set(0::ms, data.tick  , .7 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick/4, .000001 , 2::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        2.0 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 4 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1.3 => filter.Q;
    99 => base.next;
    47 * 8 => variable.next;

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
      //     data.tick / 4 => now;
      //     padsr.keyOff();
      // }
      // spork ~ auto_off();

      fun void filter_freq_control (){ 
            while(1) {
                    filter_freq.last() => filter.freq;
                          1::ms => now;
                              }
      } 
      spork ~ filter_freq_control (); 


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 
class PSYBASS6X extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
//   padsrin => Gain f2=> SinOsc s2 => filter; 
//    4 => f2.gain;
//    0.7 => s2.gain;


    1.0 => s.width;

    .25 => float  padsrin_gain=> padsrin.gain;
    padsrin.set(0::ms, data.tick/6  , 0.5 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick/7, .000001 , 200::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        2.4 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 6 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1.0 => filter.Q;
    22 * 10 => base.next;
    35 * 10 => variable.next;

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
      //     data.tick / 4 => now;
      //     padsr.keyOff();
      // }
      // spork ~ auto_off();

      fun void filter_freq_control (){ 
            while(1) {
                    filter_freq.last() => filter.freq;
                          1::ms => now;
                              }
      } 
      spork ~ filter_freq_control (); 


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 


fun void BASS (string seq) {
  TONE t;
<<<<<<< HEAD
  t.reg(PSYBASS6X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
=======
  t.reg(syntBASS s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//  "*4{c {c  _!1!1!1" => t.seq;
  "{c{c " + seq => t.seq;
  1.3 * data.master_gain => t.gain;
  t.no_sync();// s.element_sync(); //s.no_sync()
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(5 * 10 /* Base */, 34 * 10 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.01 /* Relative Attack */, .22/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0, 0.6, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  //STCOMPRESSOR stcomp;
  //7. => float in_gain;
  //stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
  //2.1 => stcomp.gain;

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
  t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
>>>>>>> a8e48cc4a9c4a41b13ac203463e05b288b00f2bc
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .60 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  t.adsr[0].set(1::samp, 0::ms, 1, 4::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 37 * 10 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void HIGH (string seq) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .14 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

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
50::ms => arp.t.glide;
"*4 1538123412315  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


  STMIX stmix;
  stmix.send(last, mixer);
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
  .28 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


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
    while(now < target) {
      s0.set_chunk(Std.rand2(0, 63)); 
        .5 * data.tick => now;
    }
}


//////////////////////////////////////////////////////////////////////////////////
fun void LEAD (string seq) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(1 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .45 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 3 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

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
  .45 * data.master_gain => t.gain;
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
   s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(10 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 


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




////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

fun void f1 (){ 
  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 
  WAIT w;
  1::samp => w.fixed_end_dur;
  //2 * data.tick =>  w.wait; 
  while(1) {
    spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 2* data.tick /* dur */, .25 /* gain */);
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
    spork ~   FROG(9 /* fstart */, 16 /* fstop */, 37 * 100 /* lpfstart */, 6 * 100 /* lpfstop */, 2* data.tick /* dur */, .25 /* gain */);
    8 * data.tick =>  w.wait;      
    spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
    spork ~  LEAD        ("*4 ____ ____ ____ 8__B 3232 1___ 88___"); 
    8 * data.tick =>  w.wait;      

  }
} 
//spork ~ f1 ();

fun void f2 (){ 
  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 
  WAIT w;
  1::samp => w.fixed_end_dur;
  //2 * data.tick =>  w.wait; 
  while(1) {
    spork ~   PADS (":6 1|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 5|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 1|3_"); 
    8 * data.tick =>  w.wait;      
    spork ~   PADS (":6 0|2_"); 
    8 * data.tick =>  w.wait;      
  }
} 
//spork ~ f2 ();


SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//1::samp => w.fixed_end_dur;
4*data.tick => w.sync_end_dur;

/***************************/
 if  ( 0 ){
    
// INTRO

spork ~  SLIDESERUM1(2000 /* fstart */, 100 /* fstop */, 8* data.tick /* dur */,  .11 /* gain */); 
spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
8.2 * data.tick =>  w.wait;      

spork ~   SINGLEWAV("../_SAMPLES/DeepTCruise/magic.wav", .3); 
3.8 * data.tick =>  w.wait;      

}


/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////

}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
  spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
// spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
  spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      

//} if  ( 0 ){
    
  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
  spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
  spork ~   PADS (":6 5|3_"); 
  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 3* data.tick /* dur */, .25 /* gain */);
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
  spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
  spork ~   PADS (":6 1|3_"); 
  8 * data.tick =>  w.wait;      


  spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
  spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
  spork ~   PADS (":6 0|2_"); 
  8 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////

 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
 spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
 spork ~   PADS (":6 1|3_"); 
 spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___");  8 * data.tick =>  w.wait;      
 

 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
 spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
 spork ~   PADS (":6 5|3_"); 
 spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 46 * 100 /* lpfstop */, 3* data.tick /* dur */, .25 /* gain */);
 8 * data.tick =>  w.wait;      


 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
 spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
 spork ~   PADS (":6 1|3_"); 
 spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
 8 * data.tick =>  w.wait;      


 spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
 spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 __"); 
 spork ~   PADS (":6 0|2_"); 
 spork ~   FROG(9 /* fstart */, 16 /* fstop */, 37 * 100 /* lpfstart */, 6 * 100 /* lpfstop */, 2* data.tick /* dur */, .3 /* gain */);
  8 * data.tick =>  w.wait;   


//////////////////////////////////////////////////////////////////////////////

     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
   
     8 * data.tick =>  w.wait;      
     
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
     spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
   //  spork ~   PADS (":6 5|3_"); 
     spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
     8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
     spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
   //  spork ~   PADS (":6 1|3_"); 
     spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
     spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
      8 * data.tick =>  w.wait;      
   
   
     spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
     spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
     spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 __"); 
   //  spork ~   PADS (":6 0|2_"); 
     spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
     spork ~  HIGH        ("*3 ____ ____ ____ 8__B 3232 1___ 88___"); 
      8 * data.tick =>  w.wait;   






  spork ~   SINGLEWAV("../_SAMPLES/DeepTCruise/DTCcomp2_reduced.wav", .21); 
  spork ~   TRANCEHPF (); 
  spork ~   PADS (":6 1|3_"); 
  spork ~  HIGH        ("*3 ____ _8/1__ ___3 ____ 329_ ____ _1_4_"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 5|3_"); 
  spork ~  HIGH        ("*3 ____ ____ ____ R___ 3_32 ____ _____"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 1|3_"); 
  spork ~  HIGH        ("*3 ____ _1/4 ____ ____ _________ 88___"); 
  8 * data.tick =>  w.wait;      
  spork ~   PADS (":6 0|2_"); 
  spork ~  HIGH        ("*3 ____ _12_ __3_ 4__B 3242 1___ 08___"); 
  8 * data.tick =>  w.wait;     
  


///////////////////////////////////////////////////////////////////////////////

    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
    spork ~   PADS (":6 1|3_"); 
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ ____ ____ ____ ____ _431 __433"); 
  
    8 * data.tick =>  w.wait;      
    
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
    spork ~   PADS (":6 5|3_"); 
    spork ~  LEAD        ("*4 3232 1_1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  ____ _1_5 3_81 _43_ __"); 
    8 * data.tick =>  w.wait;      
  
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K___ KK_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 
    spork ~   PADS (":6 1|3_"); 
    spork ~  LEAD        ("*4 8__8 __1_ _1__ 8__B 3232 1___ 88___"); 
    spork ~   HIGH ("}c}c *4  _41_ _1_5 3__1 _"); 
     8 * data.tick =>  w.wait;      
  
  
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K _K_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __hh S_h_ __h_ S_h_ _hhS __hS "); 
    spork ~  BASS        ("*4!1_1!1 !1_1!1 !1_1!1 !1_1!1 __"); 
    spork ~   PADS (":6 0|2_"); 
    spork ~  LEAD        ("*4 8__8 __1_ 3232 1__B 3232 1___ 88___"); 
    spork ~  HIGH        ("*3 ____ ____ ____ 8__B 3232 1___ 88___"); 
     8 * data.tick =>  w.wait;   


  ///////////////////////////////////////////////////////////////////////////////::




    spork ~   SUPERHIGH (" *4 +5 4_3_4___4_3_3__24231 -5}c 423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423142314 {c +5 2313142423142 }c -5 3131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423_42__42__3_}c -5 4_4__14__131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K KK_K"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

    8 * data.tick =>  w.wait;   

    spork ~   SUPERHIGH ("}c *4 {c +5 4231 4231 4231 }c -5 4231 4231 4231}c -5 4231 4231  "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ "); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_   "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 __"); 

     8 * data.tick =>  w.wait;   




    spork ~   SUPERHIGH ("}c *4 4_3_4___4_3_3__2 {c +5 4231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K___"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

     8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 42314231423131424{c +5231423131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K K_K_"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

 
    8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 423_42__42__3_4_4{c +5__14__131423142 "); 
    spork ~  TRANCEBREAK ("*4 K___ K___ K___ K___ K___ K___ K__K KKKK"); 
    spork ~  TRANCEHH ("*4 __h_ S_h_ __h_ S_h_ __h_ S_h_ __hS S_hS "); 
    spork ~  BASS        ("*4 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !1_1!1 !18!1!1"); 

    8 * data.tick =>  w.wait;   
    spork ~   SUPERHIGH ("}c *4 4231 4231 4231 4231 {c +54231 4231 4231 4231  "); 
    spork ~  SLIDESERUM1(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */,  .11 /* gain */); 
    spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
    spork ~  TRANCEBREAK ("*4 ____ ____ ____ ____ K___ K_K_ K__K K_KK"); 

     8 * data.tick =>  w.wait;   

}


