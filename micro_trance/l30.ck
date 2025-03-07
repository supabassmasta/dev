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

fun void KICK3_HPF(string seq, string hpfseq) {

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


STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 


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
fun void BASS16 (string seq) {


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

fun void BASS17 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
0.65 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
t.set_adsrs(1::samp, data.tick *1/16, 1., 1::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 27 * 10 /* Variable */, 1.10 /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .26/* Relative Decay */, 0.7 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
1.0 => stod.gain;

STPADSR stpadsr;
stpadsr.set(4::ms /* Attack */, 43::ms /* Decay */, 0.7 /* Sustain */, 11::ms /* Sustain dur of Relative release pos (float)*/,  26::ms /* release */);
stpadsr.setCurves(1.0, 0.7, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////


class SERUM00X extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;

  1 => w.sync;
  1 => w.interpolate;
  //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
  //[-1.0,  1] @=> float myTable[];
  float myTable[0];

  SndBuf s => blackhole;
  

  fun void config(int wn /* wave number */) {



  list_SERUM0.get(wn) => string wstr;
    
   if ( wstr == ""  ){
    list_SERUM0.get(0) => wstr;
   }
   else {
      <<<"serum wavtable :", wn, wstr>>>;
   }

   wstr => s.read;


    0 => int start;

    for (start => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.204 =>p.phase; } 1 => own_adsr;
} 

fun void BASS15 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2217 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.55 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 49 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 57*  .01/* Relative Decay */, 0.25 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,95 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS15_HPF (string seq, string hpfseq) {


TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2217 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.55 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 50 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 60*  .01/* Relative Decay */, 0.25 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;

//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 



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


// class STFREEGAIN extends ST{
//   MULT ml => outl;
//   MULT mr => outr;
// 
//   Gain g => ml;
//        g => mr;
// 
//   fun void connect(ST @ tone) {
//     tone.left() =>  ml;
//     tone.right() => mr;
//   }
// }


/////////////////////////////////////////////////////////////////////////////////////////////////

fun void SYNTGLIDE_GAIN (string seq, int n, float lpf_f,  dur gldur, float v, string seq_gain) {

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


  STFREEGAIN stfreegain;
  stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
  AUTO.gain(seq_gain) => stfreegain.g; // connect this

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE_GAIN("*4 }c }c 92921204_" /* seq */, 0 /* Serum00 synt */, 1000 /* lpf_f */, 50::ms /* glide dur */, .19 /* gain */, "1////8" /* seq_gain */ );



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
fun void SYNT1 (string seq, float g) {
  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(25 /* synt nb */ , 1.8 /* GAIN */, 2.0 /* in freq gain */,  1 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
//  s0.add(25 /* synt nb */ , 0.4 /* GAIN */, 0.5 /* in freq gain */,  200::ms /* attack */, 2 * data.tick /* decay */, 0.2 /* sustain */, 2* data.tick /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  <<<seq>>>;

  seq => t.seq;
  g * data.master_gain => t.gain;
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
fun void SYNT2 (string seq , float g) {
  TONE t;
  t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 1.8 /* GAIN */, 2.0 /* in freq gain */,  1 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
//  s0.add(25 /* synt nb */ , 0.4 /* GAIN */, 0.5 /* in freq gain */,  200::ms /* attack */, 2 * data.tick /* decay */, 0.2 /* sustain */, 2* data.tick /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  <<<seq>>>;

  seq => t.seq;
  g * data.master_gain => t.gain;
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


fun void  MODU (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

STREVAUX strevaux;
strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////


fun void  MODU2 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}



////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////

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


// spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 


////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
fun void ACOUSTICTOM(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ ACOUSTICTOM("*4 AA_B B_CC _DD_ SKKS ");

/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
fun void TRIBAL(string seq, int nb, int tomix, float g) {

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

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + 1);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;


WAIT w;
1 * data.tick => w.sync_end_dur;


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


fun void  LOOP_LAB  (){ 
  while(1) {
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

//    spork ~   MODU (22, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 8531 8531 ffff" , "5", "F", 4 *1000, .18); 

//    spork ~   MODU2 (21, " }c  m/FF/M___ ____ " , "5//ff//F", "f/////F", 14 *1000, .18); 
//    spork ~   MODU2 (34, " }c  t/M ____ " , "F", "F", 14 *1000, .18); 
//    spork ~   MODU2 (34, " }c  t/M ____ " , "F/f", "F/f", 14 *1000, .18); 

//    spork ~   MODU2 (22, "*4 85318531853185318531853185318531    " , "f//F", "F", 9 *1000, .09); 
//    spork ~   MODU2 (21, "*4 85318531853185318531853185318531    " , "f//F", "F", 9 *1000, .09); 

//  spork ~  SYNT1 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6) , .015 ); 

  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.4 ); 
//  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTGLIDE("*4 8531__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ___B *2 !1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTGLIDE("*4 132c__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 5", 21, 29 * 100, 0.4 ); 
//  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  
  spork ~ SYNTGLIDE("*4 5831__" /* seq */, 3 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ___F *2 !1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTGLIDE("*4 832c__" /* seq */, 7 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 5", 21, 29 * 100, 0.4 ); 
//  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
 
  spork ~ SYNTGLIDE("*4 5831__" /* seq */, 20 /* Serum01 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 !1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTGLIDE("*4 832c__" /* seq */, 7 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 5", 21, 29 * 100, 0.4 ); 
//  spork ~   NIAP ( 14 /* idx */, " }c____ __1|3|5_" , 0.2 /* g */ ); 
  spork ~   NIAP ( 61 /* idx */, " }c____ __1|3|5_" , 0.2 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
// } if  ( 0 ){
    

if ( 1  ){
    

     spork ~ KICK3_HPF(" kkkkkkkk kkkkkkkk kkkkkkkk kkkkkkk_ 
    " , ":2:4 M//ff//M ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __ __
    ",  ":2:4 M//ff//M "); 

   spork ~  SYNT1 ("*4  {c {c  {c :4 ____ ____ ____   *4 " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 5) , .015 ); 
   spork ~ SYNTGLIDE_GAIN("*4 }c }c 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 _ 
   " /* seq */, 1 /* Serum00 synt */,  1 * 1500 /* lpf_f */, 24::ms /* glide dur */, .19 /* gain */, ":8 1////8" /* seq_gain */ );

    8 *4 * data.tick =>  w.wait;   
}

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU2 (22, "   8////1____ ____ " , "5//ff//F", "f/////F", 14 *1000, .15); 
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!8!1 ___!1_   "); 
spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~ TRIBAL("*4 __a_", 0 /* bank */, 1 /* tomix */, .2 /* gain */);
   spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU2 (20, "*8*2   1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 " , "5//f", "F", 4 *1000, .14); 
    spork ~ TRIBAL("__ *4 FFFF", 0 /* bank */, 1 /* tomix */, .3 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU2 (20, "*4 85318531853185318531853185318531    " , "f//F", "F", 9 *1000, .09); 
    spork ~ TRIBAL("__ *4  RR", 0 /* bank */, 1 /* tomix */, .2 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ _  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __   "); 
    spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~   MODU2 (20, "*8*2   1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 " , "f//F", "F", 9 *1000, .18); 
    spork ~ TRIBAL("__ *4 {3 RR", 0 /* bank */, 1 /* tomix */, .3 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k____ __k_  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 _____ !a//1   "); 
spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

    spork ~ TRIBAL("__ *4  F{3R", 1 /* bank */, 1 /* tomix */, .3 /* gain */);
    spork ~   MODU2 (21, "*4 85318531853185318531853185318531    " , "p//FF/m", "F////f", 9 *1000, .09); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k____ ____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!8!5!3!1!8   "); 
spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   
    
    spork ~   MODU2 (2457, "*8*2 }c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 " , "f//F", "F", 9 *1000, .18); 
    spork ~ TRIBAL("__ *4  F_F_F", 1 /* bank */, 1 /* tomix */, .3 /* gain */);
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k____ ____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!8!5!3!1-1!c   "); 
spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
    8 * data.tick =>  w.wait;   

//    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ __k_ k_k_  "); 
//    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 _   "); 

//    8 * data.tick =>  w.wait;   


  }
  
} 
//LOOP_LAB();



///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"l30_main.wav" => string name_main;
"l30_aux.wav" => string name_aux;
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




// INTRO
     spork ~ KICK3_HPF(" kkkkkkkk kkkkkkkk kkkkkkkk kkkkkkk_ 
    " , ":2:4 f//55//M ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __ __
    ",  ":2:4 f////M "); 

   spork ~  SYNT1 ("*4  {c {c  {c :4 ____ ____ ____   *4 " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 5) , .015 ); 
   spork ~ SYNTGLIDE_GAIN("*4 }c }c 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 _ 
   " /* seq */, 1 /* Serum00 synt */,  1 * 1500 /* lpf_f */, 24::ms /* glide dur */, .19 /* gain */, ":8 1////8" /* seq_gain */ );

    8 *4 * data.tick =>  w.wait;   

   spork ~  SYNT2 ("____ *4  {c {c  {c f////////F_F/f " , 0.017 ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    8 * data.tick =>  w.wait;   
    spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    8 * data.tick =>  w.wait;   
   spork ~ SYNTGLIDE_GAIN("*4 }c }c 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 8271 8531 
   8351 8461 _ 
   " /* seq */, 1 /* Serum00 synt */,  1 * 1500 /* lpf_f */, 24::ms /* glide dur */, .19 /* gain */, ":8 1//8" /* seq_gain */ );


    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
    spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
    8 * data.tick =>  w.wait;   
     spork ~ KICK3_HPF(" kkkkkkkk_ 
    " , ":2:4 F/f ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __ __
    ",  ":2:4 M/f "); 
    spork ~ ACOUSTICTOM("____ __ *4 ABCD K+8SKS ");
    8 * data.tick =>  w.wait;   

   
 


/// MAIN //////////////////////////////////////////////////////////////////////////////////////////////


for (0 => int i; i <  2     ; i++) {


  spork ~  SYNT1 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6) , .015 ); 
  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  SYNT2 ("____ __*4  {c {c  {c 8/1 __f_ " , 0.026 ); 
  spork ~   MODU (22, "*4 {c  1__1 _1_1 __1_ 1_1__1" , "1", "f", 2 *1000, .26); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   


  spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.4 ); 
  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 8531 8531 ffff" , "5", "F", 4 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~  SYNT2 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6), 0.015 ); 
  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  SYNT2 ("____ __*4  {c {c  {c FF///f_ " , 0.017 ); 
  spork ~   MODU (23, "*4 {c  1__1 _1_1 __1_ 1_1__1" , "5", "F", 3 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   


  spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.4 ); 
  spork ~   NIAP ( 1 /* idx */, " }c____ _*2 8|5|3_1|3|5_" , 0.5 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

  8 * data.tick =>  w.wait;   
  spork ~   MODU (22, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 8531 8531 ffff" , "5", "F", 4 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

     spork ~  SYNT1 ("__ *4  {c {c  {c 8181818181818181 " , .005 );
     spork ~ KICK3_HPF(" kkkkkkkk kkkkkkkk kkkkkkkk kkkkkkk_ 
    " , ":2:4 M//ff//M ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __ __
    ",  ":2:4 M//ff//M "); 
    8  * data.tick =>  w.wait;   
    8  * data.tick =>  w.wait;   
     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
    8  * data.tick =>  w.wait;   
     spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */, .14 /* gain */); 
     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
    8  * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////////////////////////////////

for (0 => int i; i <  2     ; i++) {

     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_2__ 1", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 1/ff/1 _1_1_1__1_" , .013 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_1__ 2", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 1//FF/f_ F_FF_F_" , .015 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  53_4_2__ 3", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____*4  {c {c  {c f/FF/8_ 8_8_8_8_8_8_8_8_" , .004 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_2__ 8", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 8181818181818181 " , .004 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait; 
  }    

for (0 => int i; i <  2     ; i++) {


  spork ~  SYNT1 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6) , .015 ); 
  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  SYNT2 ("____ __*4  {c {c  {c 8/1 __f_ " , 0.026 ); 
  spork ~   MODU (22, "*4 {c  1__1 _1_1 __1_ 1_1__1" , "1", "f", 2 *1000, .26); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   


  spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.4 ); 
  spork ~   NIAP ( 0 /* idx */, " }c____ __1|3|5_" , 0.4 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 8531 8531 ffff" , "5", "F", 4 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

  spork ~  SYNT2 ("*4  {c {c  {c " + RAND.seq("1////1_, F//f_,8///8, f//1, F////1_", 6), 0.015 ); 
  spork ~ SYNTGLIDE("*4 5231__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 17, 29 * 100, 0.4 ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  SYNT2 ("____ __*4  {c {c  {c FF///f_ " , 0.017 ); 
  spork ~   MODU (23, "*4 {c  1__1 _1_1 __1_ 1_1__1" , "5", "F", 3 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   


  spork ~ SYNTGLIDE("*4 1325__" /* seq */, 2 /* Serum00 synt */, 9 * 100 /* lpf_f */, 5::ms /* glide dur */, .25 /* gain */);
  spork ~   PLOC ("  {c ____ *2 1", 21, 29 * 100, 0.4 ); 
  spork ~   NIAP ( 1 /* idx */, " }c____ _*2 8|5|3_1|3|5_" , 0.5 /* g */ ); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 

  8 * data.tick =>  w.wait;   
  spork ~   MODU (22, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ :2 8531 8531 ffff" , "5", "F", 4 *1000, .18); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
  8 * data.tick =>  w.wait;   

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

     spork ~  SYNT1 ("__ *4  {c {c  {c 8181818181818181 " , .005 );
     spork ~ KICK3_HPF(" kkkkkkkk kkkkkkkk kkkkkkkk kkkkkkk_ 
    " , ":2:4 M//ff//M ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __ __
    ",  ":2:4 M//ff//M "); 
    8  * data.tick =>  w.wait;   
    8  * data.tick =>  w.wait;   
     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
    8  * data.tick =>  w.wait;   
     spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .8 /* width */, .14 /* gain */); 
     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
    8  * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////////////////////////////////

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

     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_2__ 1", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 1/ff/1 _1_1_1__1_" , .013 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_1__ 2", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 1//FF/f_ F_FF_F_" , .015 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  53_4_2__ 3", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____*4  {c {c  {c f/FF/8_ 8_8_8_8_8_8_8_8_" , .004 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait;   


     spork ~   MODU (23, "*8 {c  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_  1_1_ 1_1_ 1_1_ 1_1_ 1_" , "5", "F", 4 *1000, .17); 
     spork ~   PLOC ("  {c *2  54_3_2__ 8", 17, 29 * 100, 0.3 ); 
     spork ~  SYNT1 ("____ *4  {c {c  {c 8181818181818181 " , .004 );
     spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
     spork ~  BASS15 ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1_   "); 
     spork ~  TRANCEHH (" *2 _huh _huh _huh _huh    "); 
 
    8 * data.tick =>  w.wait; 
 





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

     spork ~  SYNT1 ("*4  {c {c  {c 8181818181818181 8181818181818181" , .005 );
     spork ~ KICK3_HPF(" kkkkkkkk_ " , ":2:4 M/f ");
    spork ~  BASS15_HPF ("*4   __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1
      __  ",  ":2:4 M/f "); 
    16  * data.tick =>  w.wait;   



  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}


