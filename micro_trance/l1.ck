18 => int mixer;

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  1 * data.tick => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(23 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  8 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, attackRelease /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.001 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 

SinOsc sin0 =>  s0.sl[0].inlet;
10.0 => sin0.freq;
60.0 => sin0.gain;



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

///////////////////////////////////////////////////////////////////////////////////////////////////

class KIK_TEST extends SYNT{

    // inlet 
  Step stp0 =>  Envelope fe =>  SinOsc sin0 =>  Envelope ge => outlet; 
  1.0 => stp0.next;
  0.0 => ge.value;
  1.0 => sin0.gain;
  
  float initSinPhase;
  float initfe;
  float initfg;

  float freqValue [0];
  dur freqDur [0];
  float gainValue [0];
  dur gainDur [0];

  0 => int spork_cnt;

  fun void  addFreqPoint (float f, dur d){ 
     freqValue << f;
     freqDur << d;
  } 

  fun void  addGainPoint (float g, dur d){ 
     gainValue << g;
     gainDur << d;
  } 


  fun void  config  (float p, float ife, float ifg){ 
    p => initSinPhase;
    ife => initfe;
    ifg => initfg;
  } 

  
  0 => int ongoing;
  2::ms => dur stop_dur;


   fun void  trig_freq  (){ 

    // Attack
    if ( ongoing) {
      stop_dur => now;
    }

    spork_cnt => int own_cnt;
    initfe => fe.value;

    for (0 => int i; i <  freqValue.size() &&  spork_cnt == own_cnt  ; i++) {
      freqValue[i] =>  fe.target;
      freqDur[i] => fe.duration  => now;
    }
     
     
  } 
 
  fun void  trig_env  (){ 
    //    <<<"TRIG">>>;
    spork_cnt => int own_cnt;

<<<"ongoing", ongoing,spork_cnt >>>;


    // Attack
    if ( ongoing) {
      0 => ge.target;
      stop_dur => ge.duration => now;
    }

    initfg => ge.value;
    initSinPhase => sin0.phase;

    1=> ongoing;
    for (0 => int i; i <  gainValue.size() &&  spork_cnt == own_cnt ; i++) {
      gainValue[i] =>  ge.target;
      gainDur[i] => ge.duration  => now;
    }

    if (spork_cnt == own_cnt){
      0=> ongoing;
    }
  }

  //fun void on()  { }  fun void off() { }  
  
  fun void new_note(int idx)  {
        <<<"new note", idx>>>;

        1 +=> spork_cnt;
        spork ~ trig_freq();
        spork ~ trig_env();
  }
  
  1 => own_adsr;
} 


// Declare KIK outside funk 
KIK kik;
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (1500.0, 2::ms);
kik.addFreqPoint (241.0, 2::ms);
kik.addFreqPoint (117.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 2::ms);
kik.addGainPoint (-0.5, 2::ms);
kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (0.7, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK3(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


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
//t.print();

STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 4::ms /* Attack */, 13::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  - 1::samp=> now;
}


///////////////////////////////////////////////////////////////////////////////////////////////


fun void KICK3_HPF(string seq, string hpfseq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (117.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (0.8, 10::ms);
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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 


STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 




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

          fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.52 =>p.phase; 
          //<<<"new note", idx>>>;
} 1 => own_adsr;
} 


fun void BASS0 (string seq) {
  TONE t;
  //t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2331 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c" + seq => t.seq;
  0.8 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
  t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(0::ms, 10::ms, 1, 4::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  //STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
  //sthpfx0.connect(last $ ST ,  sthpfx0_fact, 1* 10.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(12 * 10 /* Base */, 74 * 10 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


  STADSR stadsr;
  stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.32 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
  stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff();

  //STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  //stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STDUCK duck;
  duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////
fun void BASS0_HPF (string seq, string hpfseq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2331 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(0::ms, 10::ms, 1, 4::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 1* 10.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(12 * 10 /* Base */, 74 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.32 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
  SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
//   s.wav["T"]=> s.wav["u"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  1.1 * data.master_gain => s.gain; //
  s.gain("S", 3.0); // for single wav 
  s.gain("T", 3.0); // for single wav 
  if(seq.find('S') != -1 )  1.5 => s.wav_o["S"].wav0.rate; // s.out("k") /* return ST */
  //s.sync(4*data.tick);// s.element_sync(); //
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();   //  s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

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
    stmix.send(last, mixer);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);
////////////////////////////////////////////////////////////////////////////////////////////

fun void TRIBAL_CUSTOM(string seq, int tomix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  
  SET_WAV.TRIBAL(s);
  s.wav["M"] => s.wav["a"];  // act @=> s.action["a"]; 
  s.wav["M"] => s.wav["b"];  // act @=> s.action["a"]; 

  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  1.2=> s.wav_o["a"].wav0.rate;
  1.4=> s.wav_o["b"].wav0.rate;
  s.go();     s $ ST @=> ST @ last; 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL_CUSTOM("*4 __a_", 0 /* tomix */, 2.0 /* gain */);
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


////////////////////////////////////////////////////////////////////////////////////////////
class WAVCTL {
  STADSR stadsr;
  stadsr.keyOff();
  SndBuf s;
  3::ms => dur att_dur;
  3::ms => dur rel_dur;
  fun void  load_connect (string file, float g){ 
    ST st; st $ ST @=> ST @ last;
    s => st.mono_in;

    stadsr.set(att_dur /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 0 ,rel_dur   /* release */);
    //stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
    stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
    // stadsr.keyOn(); stadsr.keyOff(); 

//    STMIX stmix;
//    stmix.send(last, mixer + 1);

    STREVAUX strevaux;
    strevaux.connect(last $ ST, .25/* mix */); strevaux $ ST @=>  last;  

    g => s.gain;

    file => s.read;
  }

 fun void _play(float phase, float rate, dur d){
    phase => s.phase;
    rate => s.rate;
    stadsr.keyOn();
    d => now;
    stadsr.keyOff();
    rel_dur=> now;
  }
  fun void play(float phase, float rate, dur d){
    spork ~ _play(phase, rate, d);
  }
 }



///////////////////////////////////////////////////////////////////////////////////////////////


fun void ACOUSTICTOM(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////

fun void ACOUSTICTOM_EFFECT(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
fun void  SUPLEADHPF  (string seq, float v){ 
  TONE t;
  t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
  t.no_sync();//1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  //STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
  //stbpfx0.connect(last $ ST ,  stbpfx0_fact, 91* 100.0 /* freq */ , 2.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
  //9. => stbpfx0.gain;

  STFILTERX stresx0; RES_XFACTORY stresx0_fact;
  stresx0.connect(last $ ST ,  stresx0_fact, 91* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  

  STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
  stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 2.3 /* Q */, 4 * 100 /* freq base */, 55 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

  STCOMPRESSOR stcomp;
  25. => float in_gain;
  stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

  3.2 => stcomp.gain;

  STMIX stmix;
  stmix.send(last, mixer + 1);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

} 

///////////////////////////////////////////////////////////////////////////////////////////////////


fun void GLITCH (string seq, string seq_cutter, string seq_arp,  int instru , float g) {
  
  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 
  
  
  STCUTTER stcutter;
  stcutter.t.no_sync();
  seq_cutter => stcutter.t.seq;
  stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 
  
  STGVERB stgverb;
  stgverb.connect(last $ ST, .1 /* mix */, 7 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 
  
  ARP arp;
  arp.t.dor();
  50::ms => arp.t.glide; 
  arp.t.no_sync();
  seq_arp => arp.t.seq;
  arp.t.go();   
  
  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 
  
  
  // MOD ////////////////////////////////
  
   SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
   1::second / (13 * data.tick) => s.freq;
 
//   SYNC sy;
//   sy.sync(1 * data.tick);
   //sy.sync(4 * data.tick , 0::ms /* offset */); 
   0 => s.phase;
   
   .2 => mod.freq;
   
   1.9 => o.offset;
   .9 => o.gain;
   
  // MOD ////////////////////////////////
  
  STMIX stmix;
  stmix.send(last, mixer + 1);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

fun void  LEAD  (){ 
  WAIT w;
  1 *data.tick => w.fixed_end_dur;

  spork ~ SUPLEADHPF("*3 }c 8__ _5_ ___ 3__    1__ 1__ ___ ___ ", 0.5 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c 30_5_*31_1_1_1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 16 /* instru */, .7 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ SUPLEADHPF("*3 }c G///f ", 0.3 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 3_0__5__1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 18 /* instru */, .5 /* gain */);
  4 * data.tick =>  w.wait; 

  spork ~ SUPLEADHPF("*3 }c 8__ _5_ ___ 3__    1__ 1__ ___ ___ ", 0.5 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 1_1_1___1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 19 /* instru */, .5 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ SUPLEADHPF("*3 }c f////GG//1_ ", 0.3 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 15818  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 19 /* instru */, .5 /* gain */);
  4 * data.tick =>  w.wait; 
} 

//////////////////////////////////////////////////////////////////////
fun void  CUT_VOICES  (){ 
   WAVCTL wc;
   wc.load_connect ("../_SAMPLES/Kecak/ooh.wav", .2);

   WAIT w;
   1 *data.tick => w.fixed_end_dur;

   wc.play(.4, 1., .5 * data.tick);    1 * data.tick => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;
     
   wc.play(.4, 1., .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   wc.play(.4, 1., .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;

    wc.play(.3, 1., .5 * data.tick);    1 * data.tick => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;

   16 * data.tick =>  w.wait; 


    
} 
//////////////////////////////////////////////////////////////////////
fun void  CUT_VOICES1  (){ 
   WAVCTL wc;
   wc.load_connect ("../_SAMPLES/Kecak/ooh.wav", .2);

   WAIT w;
   1 *data.tick => w.fixed_end_dur;

   wc.play(.4, 1., .5 * data.tick);    1 * data.tick => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;
     
   wc.play(.4, 1., .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   wc.play(.4, 1., .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;

    wc.play(.3, 1., .5 * data.tick);    1 * data.tick => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .25 * data.tick);    data.tick * 1. / 3. => w.wait;
   wc.play(.4, 1., .5 * data.tick);   data.tick * 1 => w.wait;

   for (0 => int i; i < 3 * 8      ; i++) {
     wc.play(.4 , 1 + i *.1 , .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   }
   16 * data.tick =>  w.wait; 


    
} 

///////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
fun void  CUT_VOICES2  (){ 
   WAVCTL wc;
   wc.load_connect ("../_SAMPLES/Kecak/ooh.wav", .2);

   WAIT w;
   1 *data.tick => w.fixed_end_dur;

   for (0 => int i; i < 3 * 4      ; i++) {
     wc.play(Std.rand2f(0.2, .5) , Std.rand2f(0.5, 2.0) , .125 * data.tick);    data.tick * 1. / 3. => w.wait;
   }
 
   for (0 => int i; i < 3 * 6      ; i++) {
     wc.play(Std.rand2f(0.2, .5) , Std.rand2f(0.5, 2.0) , .125 * data.tick);    data.tick * 1. / 4. => w.wait;
   }
   for (0 => int i; i < 3 * 12      ; i++) {
     wc.play(Std.rand2f(0.2, .5) , Std.rand2f(0.5, 2.2) , .125 * data.tick);    data.tick * 1. / 6. => w.wait;
   }
    16 * data.tick =>  w.wait; 


    
} 

///////////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

140 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

WAIT w;
1 *data.tick => w.fixed_end_dur;

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

// --------------------------------------------------------------

STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=> last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 2 / 3 , .7);  ech2 $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(last $ ST, .3 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  



fun void  LOOP_LAB  (){ 

  while(1) {


//    spork ~  KICK3 (":4  LLLL   "); 
//    spork ~  KICK3 (":2  L_L_L_L_   "); 
    spork ~  KICK3 (" LLLL LLLL *3L__L__L__L__  L__ L__ L__ L_L :3  "); 
//  spork ~  KICK3 (" *2  L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_ "); 
//    spork ~  KICK3 (" LLLL LLLL LLLL  LLL *3L_L :3  "); 
//    spork ~  BASS0 ("  !1!1!1 ");
//    spork ~  BASS0 ("  !111 ");
    spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
        !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 

      16 * data.tick =>  w.wait; 
  }


    
} 
//LOOP_LAB();


///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"kecak_main.wav" => string name_main;
"kecak_aux.wav" => string name_aux;
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


  spork ~  SLIDESERUM1(2000 /* fstart */, 37 /* fstop */, 16* data.tick /* dur */,  .08 /* gain */); 

  8 * data.tick =>  w.wait; 

  LONG_WAV l;
  "../_SAMPLES/CostaRica/processed/ZOOM0014_Processed.wav" => l.read;
  0.4 * data.master_gain => l.buf.gain;
  0 => l.update_ref_time;
  l.AttackRelease(8 * data.tick , 8 * data.tick);
  l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=>  last;  

  8 * data.tick =>  w.wait; 

  LONG_WAV l2;
  "../_SAMPLES/Kecak/chants.wav" => l2.read;
  0.7 * data.master_gain => l2.buf.gain;
  0 => l2.update_ref_time;
  l2.AttackRelease(3::ms , 3::ms);
  l2.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disabl2e) */ , 0 * data.tick /* END sync */); l2 $ ST @=>  last;  



  32::second =>  w.wait; 
  spork ~ l.the_end.kill_me();

  spork ~  SLIDESERUM1(37 /* fstart */, 2000 /* fstop */, 12* data.tick /* dur */,  .12 /* gain */); 


  16 * data.tick =>  w.wait; 


  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ L_L :3  "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);

  spork ~  KICK3 ("  LLLL LLLL LLLL *3 L__ L__ L__ LLL :3
  "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);

  spork ~  KICK3 ("  LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3 "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L_L _L_ *2 L_L_L_ LLLLLL :6   "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 

  8 * data.tick =>  w.wait; 
  spork ~  SLIDESERUM1(2000 /* fstart */, 37 /* fstop */, 8* data.tick /* dur */,  .08 /* gain */); 
  8 * data.tick =>  w.wait; 
  ////////////////////////////////////////////////////////////////////////////////////

   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ");
   spork ~  KICK3("____ *8 L___ L_L_ LLLL LLLL*2 LLLL LLLL LLLL LLLLLLLL LLLL LLLL LLLL"); 

   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/Kecak/kecak.wav", .5); 

    //    4 * data.tick - 1::samp =>  w.wait; 
    4 * data.tick =>  w.wait; 
    spork ~  SLIDESERUM1(20/* fstart */, 3000 /* fstop */, 4* data.tick /* dur */,  .08 /* gain */); 
    spork ~ ACOUSTICTOM("__ *4 ABCD :4 *6 +2U+2A+2B+2C+2D+2U ");
    4 * data.tick =>  w.wait; 

  //////////////////////////////////////////////////////////////////////////////////////////////////
  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ L_L :3  "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ LLL :3  "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3 "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  16 * data.tick =>  w.wait;   

 spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L_L _L_ *2 L_L_L_ LLLLLL :6 "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 _hh_hh_hh_hh_hh_hh *2 __h_h___h_hh :2 "); 
  8 * data.tick =>  w.wait;   
  spork ~  SLIDESERUM1(2000 /* fstart */, 37 /* fstop */, 8* data.tick /* dur */,  .10 /* gain */); 
  8 * data.tick =>  w.wait; 

//////////////////////////////////////////////////////////////////////////////////
   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ");
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/Kecak/ooh.wav", .5); 
   8 * data.tick  =>  w.wait; 
   spork ~  SLIDESERUM1(20/* fstart */, 3000 /* fstop */, 4* data.tick /* dur */,  .08 /* gain */); 
   spork ~  KICK3 ("*8 L___ L_L_ LLLL LLLL*2 LLLL LLLL LLLL LLLLLLLL LLLL LLLL LLLL"); 
    4 * data.tick =>  w.wait; 
//////////////////////////////////////////////////////////////////////////////////

  /// LEAD ///////
  spork ~ LEAD (); // 32 tick 
  /////////////////

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ L_L :3  "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ LLL :3  "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  /// LEAD ///////
  spork ~ LEAD (); // 32 tick 
  /////////////////

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 ("LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3"); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 ("  LLLL LLLL LLLL *3 L_L _L_ *2 L_L_L_ LLLLLL :6  "); 

  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ");
   spork ~  KICK3("____ *8 L___ L_L_ LLLL LLLL*2 LLLL LLLL LLLL LLLLLLLL LLLL LLLL LLLL"); 

   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/Kecak/kecak.wav", .5); 

    //    4 * data.tick - 1::samp =>  w.wait; 
    4 * data.tick =>  w.wait; 
    spork ~  SLIDESERUM1(20/* fstart */, 3000 /* fstop */, 4* data.tick /* dur */,  .08 /* gain */); 
    spork ~ ACOUSTICTOM("__ *4 ABCD :4 *6 +2U+2A+2B+2C+2D+2U ");
    4 * data.tick =>  w.wait; 

  //////////////////////////////////////////////////////////////////////////////////////////////////

  spork ~ CUT_VOICES  ();
  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
  spork ~  KICK3 ("LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3"); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
  spork ~ CUT_VOICES2  ();
  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ LLL :3 "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
  spork ~ CUT_VOICES1  ();
  spork ~  KICK3 ("LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3"); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL_CUSTOM("*3 )2M__ ___ ___ ___ ___   _MM ___ (3a__ M__ ___ ___ ___ __a   _MM ___ (1b_a ", 0 /* tomix */, 2.0 /* gain */);
  spork ~ CUT_VOICES2  ();
  spork ~  KICK3 ("  LLLL LLLL LLLL *3 L_L _L_ *2 L_L_L_ LLLLLL :6  "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////////////////////////////
   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ");
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/Kecak/ooh.wav", .5); 
   8 * data.tick  =>  w.wait; 
   spork ~  SLIDESERUM1(20/* fstart */, 3000 /* fstop */, 4* data.tick /* dur */,  .08 /* gain */); 
   spork ~  KICK3 ("*8 L___ L_L_ LLLL LLLL*2 LLLL LLLL LLLL LLLLLLLL LLLL LLLL LLLL"); 
    4 * data.tick =>  w.wait; 

///// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
/// END ///
0 => data.next;
while (! data.next) {

    <<<"********">>>;
    <<<"END LOOP">>>;
    <<<"********">>>;

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

  /// LEAD ///////
  spork ~ LEAD (); // 32 tick 
  /////////////////

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ L_L :3  "); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 (" LLLL LLLL LLLL *3 L__ L__ L__ LLL :3  "); 
  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  /// LEAD ///////
  spork ~ LEAD (); // 32 tick 
  /////////////////

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 ("LLLL LLLL LLLL *3 L_L _L_ L_L LLL :3"); 
  spork ~  BASS0 ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                       !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  "); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

  spork ~ TRIBAL("*3 _y_ A_u _yy _AB yy_ A_u _yy yAB _y_ A_u _yy _AB CDC yAB yAB yAA ", 1 /* bank */, 0 /* tomix */, .4 /* gain */);

  spork ~  KICK3 ("  LLLL LLLL LLLL *3 L_L _L_ *2 L_L_L_ LLLLLL :6  "); 

  spork ~  BASS0     ("*3  !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1
                           _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  "); 
  spork ~  BASS0_HPF ("*3  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  _ _ _  
                           !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1 !1!1!1  ", ":8 F/8"); 
  spork ~  TRANCEHH ("*3 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 _hhS|Thh_hhS|Thh_hhS|Thh *2 __h_h_S|T_h_hh :2 "); 
  16 * data.tick =>  w.wait;   

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

   spork ~   SINGLEWAV("../_SAMPLES/Kecak/ooh.wav", .5); 
   16 * data.tick  =>  w.wait; 
 
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}


