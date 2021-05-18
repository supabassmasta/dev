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
fun void  AMB1  (int idx, string seq, float playback_gain){ 
  "amb1_"+ idx + ".wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    playback_gain => s.gain;

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

//////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
fun void  BASSAMB1  (int idx, string seq, float playback_gain){ 
  "bassamb1_"+ idx + ".wav" => string name;

  if (  file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    playback_gain => s.gain;

    name => s.read;

    s.length() => now;

  }
  else {
    TONE t;
    t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
    s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
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
    
    STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
    stsynclpfx0.freq(100 /* Base */, 17 * 100 /* Variable */, 1. /* Q */);
    stsynclpfx0.adsr_set(.3 /* Relative Attack */, .2/* Relative Decay */, 0.4 /* Sustain */, .1 /* Relative Sustain dur */, 0.2 /* Relative release */);
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



110 => data.bpm;   (60.0/data.bpm)::second => data.tick;
48 => data.ref_note;

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
  spork ~   AMB1 ( 0 /* idx */, ":4 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 
  spork ~   AMB1 ( 1 /* idx */, ":4 }c __55 __AA __22 -4 88___" , 0.6 /* g */ ); 
//  spork ~   BASSAMB1 ( 0 /* idx */, ":4 {c 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 
//  spork ~   BASSAMB1 ( 1 /* idx */, ":4 {c BB__ AAA_ 22__ 1111_" , 1.0 /* g */ ); 

  64 * data.tick =>  w.wait; 
  spork ~   AMB1 ( 0 /* idx */, ":4 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 
  spork ~   AMB1 ( 1 /* idx */, ":4 }c __55 __AA __22 -4 88___" , 0.6 /* g */ ); 
  spork ~   BASSAMB1 ( 0 /* idx */, ":4 {c 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 

  64 * data.tick =>  w.wait; 
  spork ~   AMB1 ( 0 /* idx */, ":4 555_ AAA_ 444_ 1111_" , 1.0 /* g */ ); 
  spork ~   AMB1 ( 1 /* idx */, ":4 }c __55 __AA __22 -4 88___" , 0.6 /* g */ ); 
  spork ~   BASSAMB1 ( 1 /* idx */, ":4 {c BB__ AAA_ 22__ 1111_" , 1.0 /* g */ ); 

  64 * data.tick =>  w.wait; 

}

