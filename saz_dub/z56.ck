21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////
fun void KICK3_HPF(string seq, string hpfseq) {
TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.35 =>p.phase; } 1 => own_adsr;
} 

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

fun void BASS0 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2330 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
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
stsynclpfx0.freq(11 * 10 /* Base */, 58 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.22 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0_HPF (string seq, string hpfseq) {


TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2330 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
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
stsynclpfx0.freq(11 * 10 /* Base */, 58 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.22 /* Sustain */, .17 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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

/////////////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE_KICK(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
// SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
// s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("S", 1.7); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   0.8 => s.wav_o["S"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 5. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

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

fun void  FROG  (float fstart, float fstop, float lpfstart, float lpfstop, dur d, float g){ 
    ST st; st $ ST @=> ST @ last;

    Step step => Envelope e0 => SqrOsc s => st.mono_in;
    1. => step.next;
    .2 => s.gain;

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

//spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 24 * 100 /* lpfstop */, 1* data.tick /* dur */, .3 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////////
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

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.1 /* Q */, 15 * 100 /* freq base */, 22 * 100 /* freq var */, data.tick * 3 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

//  STREVAUX strevaux;
//  strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 0 /* Serum00 synt */, 1000 /* lpf_f */, 50::ms /* glide dur */, .19 /* gain */);

//////////////////////////////////////////////////////////////////////////////////
fun void GLIDE (string seq, int n, float lpf_f, dur gldur, float v) {

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
t.set_adsrs(2::ms, 50::ms, .2, 400::ms);
t.set_adsrs_curves(0.6, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.1 /* Q */, 15 * 100 /* freq base */, 46 * 100 /* freq var */, data.tick * 3 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

//  STREVAUX strevaux;
//  strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

//spork ~ SYNTGLIDE("*4 }c }c 92921204_" /* seq */, 0 /* Serum00 synt */, 1000 /* lpf_f */, 50::ms /* glide dur */, .19 /* gain */);

//////////////////////////////////////////////////////////////////////////////////
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

//STREVAUX strevaux;
//strevaux.connect(last $ ST, .2 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
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


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 7 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 






//150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//4 * data.tick => w.fixed_end_dur;

4*data.tick => w.sync_end_dur;

//2 * data.tick =>  w.wait; 

// INTRO
if ( 0  ){
      spork ~   SINGLEWAV("../_SAMPLES/LovinaLouie/Song_short.wav", .15); 
    18 * data.tick =>  w.wait;   
 
     spork ~ KICK3_HPF(" kkkkkkkk kkkkkkkk kkkkkkkk kkkkkkk_ 
    " , ":2:4 f//55//M ");
    spork ~  BASS0_HPF ("*4    ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1_
   ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1_ 
   ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1_ 
  ___1 __1_ ___1 __1_ ___1 __1_  
    ",  ":2:4 f////M "); 

    8  * data.tick =>  w.wait;   
    8  * data.tick =>  w.wait;   
    8  * data.tick =>  w.wait;   
  spork ~ TRIBAL("      ____ __U_    ", 0 /* bank */, 1 /* tomix */, 0.29 /* gain */);
    8  * data.tick =>  w.wait;   

  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ __X_ ____   ", 0 /* bank */, 1 /* tomix */, 0.44 /* gain */);
}

/********************************************************/
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ab_ __ ____   ", 0 /* bank */, 1 /* tomix */, 0.47 /* gain */);
  8 * data.tick =>  w.wait;   
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ VV__ ____   ", 0 /* bank */, 1 /* tomix */, 0.44 /* gain */);
  8 * data.tick =>  w.wait;   
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ ii__ ____   ", 0 /* bank */, 1 /* tomix */, 0.49 /* gain */);
  8 * data.tick =>  w.wait;   
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ __U_ ____   ", 0 /* bank */, 1 /* tomix */, 0.22 /* gain */);
  8 * data.tick =>  w.wait;   

// 00000000000000000000000000000000000000000000000000000000000000000000

}
if(0){


//  spork ~   MODU (3157, "111" , "{c{c Z//MM", "f//mm", 3 *1000, .33); 
//  spork ~   MODU (3157, "}c 11181" , "{c{c T/ZZ/FF", "f", 2 *1000, .33); 
  spork ~   GLIDE (" {c    *2 " + RAND.seq("1!3!5!8,!3!5!8!5,!7!5!1!3,!1!3!2!1", 8)  , 85, 14 * 100, 30::ms, 0.001 * 96); 
  8 * data.tick =>  w.wait;   
  spork ~   GLIDE (" {c    *4 " + RAND.seq("1!3!5!8,!3!5!8,!7!5,!1!0, !3!2!1", 8)  , 46, 12 * 100, 30::ms, 0.001 * 135); 
  8 * data.tick =>  w.wait;   
  spork ~   PLOC (" {c    *4 " + RAND.seq("1!3!5!8,!3!5!8,!7!5,!1!0, !3!2!1", 8)   , 21, 20 * 100, 0.081 ); 



//spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   
  spork ~   GLIDE (" {c    *4 " + RAND.seq("1!3!5!8,!3!5!8,!7!5,!1!0, !3!2!1", 8)  , 41, 20 * 100, 30::ms, 0.001 * 135); 
  8 * data.tick =>  w.wait;   




}




if (0) {

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   


  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 13 * 100 /* lpfstart */, 35 * 100 /* lpfstop */, 2* data.tick /* dur */, .2 /* gain */);
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ ____ fff_    ", 0 /* bank */, 1 /* tomix */, .39 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

  spork ~   MODU (3157, "111" , "{c{c Z//MM", "f//mm", 3 *1000, .17); 
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ __U_ ____   ", 0 /* bank */, 1 /* tomix */, 0.29 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

   spork ~   SINGLEWAV("../_SAMPLES/LovinaLouie/Love.wav", .23); 
  spork ~   MODU (60, "____ ____ *4 1_8" , "{c{c f", "m", 3 *1000, .14); 
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ __cc ____ ____   ", 0 /* bank */, 1 /* tomix */, .39 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

  spork ~   MODU (2060, "f//11" , "{c{c Z", "f//mm", 3 *1000, .20); 
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ ii__ ____   ", 0 /* bank */, 1 /* tomix */, 0.68 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

  spork ~   MODU (64, "*8 8_8_8_8_8_8_8_8_" , "{c{c f//8", "m", 10 *1000, .17); 
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ ____ __VV ____   ", 0 /* bank */, 1 /* tomix */, 0.29 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

  spork ~   MODU (64, "*1 5555" , "{c{c{c{c Z////D", "m////t", 10 *1000, .10); 
  spork ~ TRIBAL("*4      ____ ____ ____ ____ ____ __a_ ____ ____   ", 0 /* bank */, 1 /* tomix */, .32 /* gain */);

  spork ~   PLOC ("  {c ____  *4 __1", 21, 29 * 100, 0.2 ); 
  spork ~  KICK3 ("*4     k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4     ___1 __1_ ___1 __1_ ___1 __1_ __1!1 __1     "); 
  spork ~  TRANCEHH ("*4  __h_ S_h_ _hh_ S_h_ __h_ S_ht __h_ ShhT "); 
  spork ~ TRIBAL("*4      ____ _a_a ____ __AF ____ ____ _u__ __xx  ", 1 /* bank */, 0 /* tomix */, .25 /* gain */);
  8 * data.tick =>  w.wait;   

}
