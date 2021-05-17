 0 =>int mixer;

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

///////////////////////////////////////////////////////////////////////////////
fun void  AMB1  (){ 
  "amb1.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    ":4 111_666_444_555_" => t.seq;
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

//////////////////////////////////////////////////////////////////////////////////////////////////
fun void  AMB2  (){ 
  "amb2.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 50::ms /* ATTACK */, 2::second /* RELEASE */, 1 /* FILE */, 100::ms /* UPDATE */); 
    s0.config(.5 /* G */, 50::ms /* ATTACK */, 2::second /* RELEASE */, 1 /* FILE */, 100::ms /* UPDATE */); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    ":4 }c 1___6___4___5___" => t.seq;
    .2 * data.master_gain => t.gain;
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


///////////////////////////////////////////////////////////////////////////////
fun void  AMB3  (){ 
  "amb3.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    ":4 {c{c  1///1_6///6_4///4_5///5_" => t.seq;
    .3 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    
    STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
    stsynclpfx0.freq(100 /* Base */, 10 * 100 /* Variable */, 1. /* Q */);
    stsynclpfx0.adsr_set(.3 /* Relative Attack */, .2/* Relative Decay */, 0.4 /* Sustain */, .1 /* Relative Sustain dur */, 0.2 /* Relative release */);
    stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
    // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

//    STMIX stmix;
//    stmix.send(last, mixer);

    t.s.duration + 2::ms => now;


  }

} 

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
fun void  AMB4  (){ 
  "amb4.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 20::ms /* ATTACK */, 1600::ms /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    ":2  {c 1_1_1_1_ 6_6_6_6_  4_4_4_4_ 5_5_5_5_ " => t.seq;
    .3 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    
    STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
    stsynclpfx0.freq(10 /* Base */, 10 * 100 /* Variable */, 1. /* Q */);
    stsynclpfx0.adsr_set(.6 /* Relative Attack */, .1/* Relative Decay */, 0.7 /* Sustain */, .1 /* Relative Sustain dur */, 0.4 /* Relative release */);
    stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
    // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer);

    t.s.duration + 2::ms => now;


  }

} 

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////
class arp1 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void  ARP1  (){ 
  "arp1.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(arp1 s0);  //data.tick * 8 => t.max; //
    20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    " }c *4
    8532 1BA0  8532 1BA0  8532 1BA0  8532 1BA0  
    8532 1BA0  8532 1BA0  8532 1BA0  8532 1BA0  
   
    AB01 2486  AB01 2486  AB01 2486  AB01 2486  
    AB01 2486  AB01 2486  AB01 2486  AB01 2486  

    4C4C 6324  4C4C 6324  4C4C 6324  4C4C 6324  
    4C4C 6324  4C4C 6324  4C4C 6324  4C4C 6324  
    
    B031 5275 B031 5275 B031 5275    B031 5275  
    B031 5275 B031 5275 B031 5275    B031 5275  

    " => t.seq;
    .24 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    
    STAUTOPAN autopan;
    autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

    STECHO ech;
    ech.connect(last $ ST , data.tick * 1 / 4 , .1);  ech $ ST @=>  last; 

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer);

    t.s.duration + 2::ms => now;


  }

} 


//////////////////////////////////////////////////////////////////////////////////////////////////
fun void  ARP2  (){ 
  "arp2.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer );

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //
//    20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    " }c *4
    8532 1BA0  8532 1BA0  8532 1BA0  8532 1BA0  
    8532 1BA0  8532 1BA0  8532 1BA0  8532 1BA0  
   
    AB01 2486  AB01 2486  AB01 2486  AB01 2486  
    AB01 2486  AB01 2486  AB01 2486  AB01 2486  

    4C4C 6324  4C4C 6324  4C4C 6324  4C4C 6324  
    4C4C 6324  4C4C 6324  4C4C 6324  4C4C 6324  
    
    B031 5275 B031 5275 B031 5275    B031 5275  
    B031 5275 B031 5275 B031 5275    B031 5275  

    " => t.seq;
    .25 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    
    STAUTOPAN autopan;
    autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.45 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//    STECHO ech;
//    ech.connect(last $ ST , data.tick * 1 / 4 , .1);  ech $ ST @=>  last; 

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer );

    t.s.duration + 2::ms => now;


  }

} 


//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
fun void  ARP3  (){ 
  "arp3.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer );

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(PLOC1 s0);  //data.tick * 8 => t.max; //
//    20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    " }c}c *4
    1BA0 8532 1BA0  8532 1BA0  8532 1BA0  8532   
    1BA0 8532 1BA0  8532 1BA0  8532 1BA0  8532   
         
    2486 AB01 2486  AB01 2486  AB01 2486  AB01   
    2486 AB01 2486  AB01 2486  AB01 2486  AB01   
         
    6324 4C4C 6324  4C4C 6324  4C4C 6324  4C4C   
    6324 4C4C 6324  4C4C 6324  4C4C 6324  4C4C   
         
    5275 B031 5275 B031 5275 B031 5275    B031   
    5275 B031 5275 B031 5275 B031 5275    B031   

    " => t.seq;
    .24 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 



    1::samp => now; // Let duration computed by go() sub sporking
    
    STAUTOPAN autopan;
    autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.15 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//    STECHO ech;
//    ech.connect(last $ ST , data.tick * 1 / 4 , .1);  ech $ ST @=>  last; 

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer );

    t.s.duration + 2::ms => now;


  }

} 


//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
fun void CHORD1  (){ 
  "chord1.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    .5 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
    t.reg(SYNTWAV s1);  
    s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 

    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    ":4 1|5_1|31|26|26|8__4|24|64|8_5|95|75|1_" => t.seq;
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



////////////////////////////////////////////////////////////////////////////////////////


   fun void TRANCE(string seq, int rept) {
   
     SEQ s;  
     SET_WAV.TRANCE(s); 
     
     // SET_WAV.TRANCE_KICK(s); 
     // s.wav["k"]=> s.wav["k"];
    
     
     seq => s.seq;
     .13 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
     s.no_sync();// s.element_sync(); //s.no_sync()
   ; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  .7 => s.wav_o["l"].wav0.rate;
     // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
     //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
     s.go();     s $ ST @=> ST @ last; 
   
     STMIX stmix;
     stmix.send(last, mixer);
     //stmix.receive(11); stmix $ ST @=> ST @ last; 

   STGAIN stgain;
   stgain.connect(s $ ST , 5.0 /* static gain */  );       stgain $ ST @=>  last; 
   
     1::samp => now; // let seq() be sporked to compute length
     while(rept) {
       1-=>rept;
       s.s.duration => now;
     }
      
   }


//spork ~  TRANCE ("*4 L___ L_L_ LLLL *2 LLLL LLLL", 4); 
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{

		inlet => TriOsc s => PowerADSR padsr => outlet;		
				.5 => s.gain;
		.82 => s.width;
		padsr.set(0::ms , data.tick / 6 , .0000001, data.tick / 4);
		padsr.setCurves(2.0, 2.0, .5);

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		padsr.keyOn();}
} 

fun void  NIAP1  (){ 
  "niap1.wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer+1);

    1.2 => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {

    TONE t;
    t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
    t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
    t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
    t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
    t.dor();// t.aeo(); // t.phr();// t.loc();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    "}c
    _1|3|5|8 ____ ____ __2|4_
    _6|1|2|4 ____ ____ ____
    *4 ____ 4|6|1|2_ _4|6|1|2:4 ____ ____ __7|2_
    _B|2|5|1 ____ ____ ____
    " => t.seq;
    0.7 => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
    1 => t.set_disconnect_mode;
    t.go(); t $ ST @=> ST  last;



    STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
    stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 25 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  

    1::samp => now; // Let duration computed by go() sub sporking


       STREC strec;
        strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer + 1);

    t.s.duration + 2::ms => now;

  }
   
} 



//////////////////////////////////////////////////////////////////////////////////////////////////



148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

//SYNC sy;
//sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::ms => w.fixed_end_dur;
//8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 2. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .10 /* mix */, 4 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

// TO REV
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


// LOOP

/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/


  ////////////////

  spork ~   AMB3 (); 
  spork ~   AMB1 (); 
  spork ~   CHORD1 (); 

  64 * data.tick =>  w.wait; 

  spork ~   AMB3 (); 
  spork ~   AMB1 (); 
  spork ~   CHORD1 (); 
  spork ~   ARP2 (); 

  64 * data.tick =>  w.wait; 

  spork ~  TRANCE (":2 llll", 8); 
  spork ~   AMB3 (); 
  spork ~   AMB1 (); 
  spork ~   CHORD1 (); 
  spork ~   ARP2 (); 

  64 * data.tick =>  w.wait; 

  spork ~  TRANCE (":2 llll", 8); 
  spork ~   AMB3 (); 
  spork ~   AMB4 (); 
  spork ~   AMB1 (); 
  spork ~   CHORD1 (); 
  spork ~   ARP2 (); 

  64 * data.tick =>  w.wait; 

  spork ~   AMB3 (); 
  spork ~   AMB4 (); 
  spork ~   AMB2 (); 
  spork ~   AMB1 (); 
  spork ~   NIAP1 (); 
  spork ~   CHORD1 (); 
  spork ~   ARP1 (); 
  spork ~   ARP2 (); 

  64 * data.tick =>  w.wait; 


  /////////

  while(1) {

    spork ~   NIAP1 (); 
    spork ~  TRANCE (":2 llll", 8); 
    spork ~   ARP3 (); 
    spork ~   ARP2 (); 
    spork ~   CHORD1 (); 
    spork ~   AMB4 (); 
    spork ~   AMB3 (); 
    spork ~   ARP1 (); 
    spork ~   AMB2 (); 
    spork ~   AMB1 (); 

    64 * data.tick =>  w.wait; 
  }

} 


