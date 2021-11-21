21 => int mixer;

class KICKACT extends ACTION {
    SndBuf @ s;
    fun int on_time() {
              1.3 => s.rate;
              14::ms =>now;
              0.51 => s.rate;
            }
}

fun void KICK0(string seq) {

KICKACT act; 

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // 
act @=> s.action["k"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
0.76 * data.master_gain => s.gain; //
s.gain("L", .4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
//.6 => s.wav_o["k"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);

s.wav_o["k"].wav0 @=> act.s;

s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(18::samp/* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 16*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 


STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 16* 10.0 /* freq */ , 0.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .4 /* Slope */, 2::ms /* Attack */, 20::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

class KICK1ACT extends ACTION {
    SndBuf @ s;
    fun int on_time() {
              1.3 => s.rate;
              16::ms =>now;
              0.62 => s.rate;
            }
}
fun void KICK1(string seq) {

KICK1ACT act; 

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // 
act @=> s.action["k"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
0.7 * data.master_gain => s.gain; //
s.gain("L", .4); // for single wav 
//s.sync(4*data.tick);// s.element_sync();
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
//.6 => s.wav_o["k"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);

s.wav_o["k"].wav0 @=> act.s;

s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(18::samp/* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 13*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 


STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 16* 10.0 /* freq */ , 0.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .4 /* Slope */, 2::ms /* Attack */, 20::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////


class SERUM00X extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;

  // 1st Harmonic
  inlet => Gain f2 => SinOsc sin0 =>  outlet;
  -0.36 => sin0.gain;
  1.0 => f2.gain;


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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.83 =>p.phase; 0.83 => sin0.phase;} 0 => own_adsr;
} 

fun void BASS0 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.50 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 339 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 4*  .01/* Relative Decay */, 0.5 /* Sustain */, .4 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,107 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 41* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
   .47 => stbpfx0.gain;
//   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS1 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.50 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(5 * 10 /* Base */, 190 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 8*  .01/* Relative Decay */, 0.5 /* Sustain */, .4 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,3 * 0.0001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


40 => float cross0;

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(stsynclpfx0 $ ST ,  sthpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stlpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 




 
STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx1; //LPF_XFACTORY stlpfx0_fact;
stlpfx1.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx1 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS2 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2374 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.41 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(3 * 10 /* Base */, 212 * 10 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 4*  .01/* Relative Decay */, 0.5 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,2 * 0.01, 0.8); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


//   41 => float cross0;
//   
//   STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//   stlpfx0.connect(last $ ST ,  stlpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
//   
//   STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//   sthpfx0.connect(stsynclpfx0 $ ST ,  sthpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  
//   
//   STGAIN stgain;
//   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
//   stgain.connect(stlpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 




 
STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx1; LPF_XFACTORY stlpfx1_fact;
stlpfx1.connect(last $ ST ,  stlpfx1_fact, 33* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx1 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS3 (string seq) {

TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2374 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.50 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(3 * 10 /* Base */, 246 * 10 /* Variable */, 1. /* Q */);
  stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 4*  .01/* Relative Decay */, 0.5 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(1.0,2 * 0.01, 0.8); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


   26 => float cross0;
   
   STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
   stlpfx0.connect(last $ ST ,  stlpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
   
   STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
   sthpfx0.connect(stsynclpfx0 $ ST ,  sthpfx0_fact, cross0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stlpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
stbrfx0.connect(last $ ST ,  stbrfx0_fact, 3149.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 2 /* channels */ );       stbrfx0 $ ST @=>  last;  

 
STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx1; LPF_XFACTORY stlpfx1_fact;
stlpfx1.connect(last $ ST ,  stlpfx1_fact, 32* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx1 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS4 (string seq) {

TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.48 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 339 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 7*  .01/* Relative Decay */, 0.5 /* Sustain */, .4 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,107 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 14* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
//   0.68 => stbpfx0.gain;
   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 7* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void BASS5 (string seq) {

TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.35 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 



STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 168 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 7*  .01/* Relative Decay */, 0.5 /* Sustain */, .4 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,107 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 14* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
//   0.68 => stbpfx0.gain;
   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 6* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 
  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS6 (string seq) {

TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
1.72 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 



STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 92 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 7*  .01/* Relative Decay */, 0.5 /* Sustain */, .4 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,107 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 14* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
//   0.68 => stbpfx0.gain;
   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}


fun void BASS7 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.05 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

/// 0.7 => float sus;
/// ADSRMOD adsrmod; // Direct ADSR freq input modulation
/// adsrmod.adsr_set(0.0001 /* relative attack dur */, 0.1 /* relative decay dur */ , sus /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
/// adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
/// 1/sus => adsrmod.padsr.gain;
/// adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(12 * 10 /* Base */, 56 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .17/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 36 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 19* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
   0.68 => stbpfx0.gain;
//   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 24.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void BASS8 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

/// 0.7 => float sus;
/// ADSRMOD adsrmod; // Direct ADSR freq input modulation
/// adsrmod.adsr_set(0.0001 /* relative attack dur */, 0.1 /* relative decay dur */ , sus /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
/// adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
/// 1/sus => adsrmod.padsr.gain;
/// adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(12 * 10 /* Base */, 38 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .20/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 43 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 19* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
   0.68 => stbpfx0.gain;
//   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 24.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS9 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(18 * 10 /* Base */, 38 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .24/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 16 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 9* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
   0.11 => stbpfx0.gain;
//   0.0 => stbpfx0.gain;
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 24.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS10 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 38 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .27/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.1, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 12* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
0.40 => stbpfx0.gain;
//0.0 => stbpfx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 35.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void BASS11 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 26 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.1, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


fun void BASS12 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 31 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}




fun void BASS13 (string seq) {


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(15 * 10 /* Base */, 30 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .16/* Relative Decay */, 0.7 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.01, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STCROSSOVER stcrossover0;
stcrossover0.connect(last $ ST , 54 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* LPF Gain */ );       stcrossover0 $ ST @=>  last;   

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}





////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

//STMIX stmix;
//stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;








142 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

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

  spork ~  KICK0 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS13 ("*4 _!1!1!1 _!1!5!1 _!1!1!1 _!1!8!1 _!1!1!1 _!1!5!1 _!1!1!1 _!8!5!1 _    "); 
  8 * data.tick =>  w.wait;   
 // spork ~  KICK0 ("*4 k___ k___ k___ k___ k___ k___ k___ ____  "); 
 // spork ~  BASS13 ("*4 _!1!1!1 _!1!5!1 _!1!1!1 _!1!8!1 _!1!1!1 _!1!5!1 _!1!1!1 _!8!5!1 _    "); 
 // 8 * data.tick =>  w.wait;   
 // spork ~  KICK0 ("*4 k___ k___ k___ k___ k___ k___ k___ kk_k_  "); 
 // spork ~  BASS13 ("*4 _!1!1!1 _!1!5!1 _!1!1!1 _!1!8!1 _!1!1!1 _!1!5!1 _!1!1!1 _!8!5!1 _    "); 
 // 8 * data.tick =>  w.wait;   
 // spork ~  KICK0 ("*4 k___ k___ k___ k___ k___ k___ k___ ____  "); 
 // spork ~  BASS13 ("*4 _!1!1!1 _!1!5!1 _!1!1!1 _!1!8!1 _!1!1!1 _!1!5!1 _!1!1!1 _!8!5!1 _    "); 
 // 8 * data.tick =>  w.wait;   

}
