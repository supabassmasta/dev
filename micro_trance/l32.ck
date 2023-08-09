23 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 16 * 100 /* init freq env */, 0.5 /* init gain env */);
kik.addFreqPoint (233.0, 5::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 14 * 10::ms);

kik.addGainPoint (0.4, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 14 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


fun void KICK3(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STOVERDRIVE stod;
//stod.connect(last $ ST, 1.5 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
//.6 => stod.gain;

STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK4(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 4. /* In Gain */, .07 /* Tresh */, .5 /* Slope */, 4::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3_HPF(string seq, string hpfseq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
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
  t.s.duration - 1::samp => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3_LPF(string seq, string hpfseq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.31 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////
//          Dephased SAW Wavetable building
////////////////////////////////////////////////////////////////////::

    "Dephased_saw_5" => string saw_wt_name;

fun UGen @ add_sin  (float f, float phase, float g){ 
   SinOsc s;
   f => s.freq;
   phase => s.phase;
   g => s.gain;

   return s;
} 


fun void  REC_BASS_WAVTABLE(){
    100::ms => dur T;
  

    ST st;

    Gain out => Gain out2 => st.mono_in;
    .5 => out.gain;

// Original saw generator
//    for (1 => int i; i <  10     ; i++) {
//      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 
//    }


      1 => int i;
      add_sin(1::second*i/T, 0.50, 0.7 * Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, 1.0 * Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0.5, 1.0 * Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;
      add_sin(1::second*i/T, 0, Math.pow(-1, i) / i $ float) => out; 1 +=> i;

STREC strec;
strec.connect(st, T, saw_wt_name + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); 

T + 10::ms => now;
out =< out2;

//    REC rec;
//    rec.rec(8*data.tick, "test.wav",  /* sync_dur, 0 == sync on full dur */);
//    rec.rec_no_sync(T, saw_wt_name); 

//1000::ms => now;
//me.yield();   
} 

if (! MISC.file_exist(saw_wt_name + ".wav"))
  REC_BASS_WAVTABLE();

 
class SERUM_WT extends SYNT{

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
  


   saw_wt_name + ".wav" => s.read;


    0 => int start;

    for (start => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.49 =>p.phase; } 1 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////


fun void BASS0 (string seq) {
TONE t;
t.reg(SERUM_WT s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.84 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(14 * 10 /* Base */, 26 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.65 /* Sustain */, .4 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.28/* Sustain dur of Relative release pos (float) */,  15::ms /* release */);
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

///////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0_HPF (string seq, string hpfseq) {
TONE t;
t.reg(SERUM_WT s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.84 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(14 * 10 /* Base */, 26 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.65 /* Sustain */, .4 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.28/* Sustain dur of Relative release pos (float) */,  15::ms /* release */);
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

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////

fun void BASS0_LPF (string seq, string hpfseq) {
TONE t;
t.reg(SERUM_WT s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.84 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(14 * 10 /* Base */, 26 * 10 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.65 /* Sustain */, .4 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.28/* Sustain dur of Relative release pos (float) */,  15::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; LPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}
///////////////////////////////////////////////////////////////////////////////////////////////

 
///////////////////////////////////////////////////////////////////////////////////////////////



class SERUM01X extends SYNT{

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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.2 =>p.phase; } 1 => own_adsr;
} 

///////////////////////////////////////////////////////////////////////////////////////////////


fun void BASS1 (string seq) {
TONE t;
t.reg(SERUM01X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.65 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(14 * 10 /* Base */, 31 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 27*  .01/* Relative Decay */, 0.52 /* Sustain */, .4 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STADSR stadsr;
stadsr.set(1::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.22/* Sustain dur of Relative release pos (float) */,  13::ms /* release */);
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

///////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
 s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('S') != -1 ){
    s.gain("S", .08); // for single wav 
    0.8 => s.wav_o["S"].wav0.rate;
  }
  if(seq.find('s') != -1 ){
    s.gain("s", .8); // for single wav 
    0.65 => s.wav_o["s"].wav0.rate;
  }
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
////////////////////////////////////////////////////////////////////////////////////////////

fun void TABLA (string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TABLA(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
// s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .4 * data.master_gain => s.gain; //
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
  if(seq.find('S') != -1 ){
//    s.gain("S", .08); // for single wav 
//    0.8 => s.wav_o["S"].wav0.rate;
  }
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STREVAUX strevaux;
  strevaux.connect(last $ ST, 4 * .01 /* mix */); strevaux $ ST @=>  last;  

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 5. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
fun void SIN (string seq, float g) {

  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
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

STMIX stmix;
stmix.send(last, mixer);

  1::samp => now;
  t.s.duration => now;


}


////////////////////////////////////////////////////////////////////////////////////////
fun void  SUPSAWSLIDE  ( string seq, float ph, float g){ 
   
TONE t;
t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c{c" + seq  => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(10::ms, 48::ms, .4, 10::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

// TONE t;
// t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();//
// t.aeo(); // t.phr();// t.loc();
// // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// //____ f/P__
// " {c{c" + seq  => t.seq;
// g => t.gain;
// t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
ph => stautoresx0.sin0.phase;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 2 * 100 /* freq base */, 15 * 100 /* freq var */, data.tick * 21 / 2 /* modulation period */, 3 /* order */, 2 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

2.5 => stautoresx0.gain;

STMIX stmix;
stmix.send(last, mixer + 0);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 
////////////////////////////////////////////////////////////////////////////////////////


fun void MEGAMOD (int n, int nmod, string seq, string modf, string modg, string g_curve, dur d, float g){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   s0.config(n /* synt nb */ ); 
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
   // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
   seq => t.seq;
   g * .6 * data.master_gain => t.gain;
   //t.sync(4*data.tick);// t.element_sync();// 
   t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
   // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
   t.set_adsrs(2::ms, 30::ms, .7, 40::ms);
   //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
   1 => t.set_disconnect_mode;
   t.go();   t $ ST @=> ST @ last; 

STFREEGAIN stfreegain;
stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
AUTO.gain(g_curve) => stfreegain.g; // connect this 

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 


//s1.config(nmod /* synt nb */ ); 

//AUTO.freq(modf) =>  s1 => MULT m0 => s0.inlet;
AUTO.freq(modf) =>  SinOsc sin0 =>  MULT m0 => s0.inlet;
AUTO.freq(modg) =>  m0; 

  d => now; // let seq() be sporked to compute length
}



////////////////////////////////////////////////////////////////////////////////////////
fun void  SUPSAW  (string seq, float ph, string pans, float g){ 
  TONE t;
  t.reg(SUPERSAW1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//"
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

//STFILTERMOD fmod2;
//fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 50 * 100  /* f_var */, 1.03::second / (3 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 
STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
ph => stautoresx0.sin0.phase;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 2.0 /* Q */,600 /* freq base */, 50 * 100 /* freq var */, data.tick * 5 / 2/* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan(pans) => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 



STMIX stmix;
stmix.send(last, mixer + 2);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
  

   
} 

////////////////////////////////////////////////////////////////////////////////////////

fun void  ARP  (string seq, string arpi, int n, float lpf, int out, dur d, float g){ 
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(n /* synt nb */ ); 
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

  STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
  stsynclpfx0.freq(10 /* Base */, 26 * 100 /* Variable */, 1.1 /* Q */);
  stsynclpfx0.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
  stsynclpfx0.nio.padsr.setCurves(0.8, 1.2, 0.8); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
  // CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  STMIX stmix;
  stmix.send(last, mixer + out);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  ARP arp;
  arp.t.dor();
  3::ms => arp.t.glide;
  arpi => arp.t.seq;
  arp.t.no_sync();
  arp.t.go();   

  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

 d => now;

} 


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  


STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 
//.65 => stmix.gain;

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux2;
strevaux2.connect(last $ ST, .3 /* mix */); strevaux2 $ ST @=>  last;  

STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 
//.65 => stmix.gain;

//STFILTERMOD fmod;
//fmod.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 400 /* f_base */ , 50 * 100  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 8* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 2 /* channels */ );       sthpfx0 $ ST @=>  last;  

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

//STFILTERMOD fmod2;
//fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 50 * 100  /* f_var */, 1.03::second / (3 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 

STCOMPRESSOR stcomp;
7. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain +.1 /* out gain */, 0.1 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
.4 => stcomp.gain;


150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
54 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;

//////////////////////////////////////////////////////////////////////////////////////////////
fun void  LOOP_BLIPS  (){ 
    spork ~ SUPSAWSLIDE  ("}c *2_8__ ___8|f ____  ", .4 /* filter mod phase */, 2.3 /* gain */);
  spork ~   SIN ("}c}c __  *8 5___ ____ :8 _  __ *8*2 {c 8___ 8___ ____ 8___ f___ __ "   , .4 ); 
   8 * data.tick => w.wait;
   spork ~ SUPSAWSLIDE  ("}c *2_8__ ___ 8|f ____ 1111_  ", .4 /* filter mod phase */, 2.3 /* gain */);
    spork ~   SIN ("}c}c __  *8 5_"  , .4 ); 
    8 * data.tick => w.wait;
   spork ~ SUPSAWSLIDE  ("}c *2_8__ ___8|f ____  ", .4 /* filter mod phase */, 2.3 /* gain */);
  spork ~   SIN ("}c}c __  *8 5___ ____ :8 _  __ *8*2 {c 8___ 8___ ____ 8___ f___ 1_ "   , .4 ); 
   8 * data.tick => w.wait;
   spork ~ SUPSAWSLIDE  ("}c *2_8__ ___ 8|f ____ 1111_  ", .4 /* filter mod phase */, 2.3 /* gain */);
    spork ~   SIN ("}c}c __  *8 5_"  , .4 ); 
    8 * data.tick => w.wait;
  
} 

fun void  LOOP_MOD (){ 
   spork ~ MEGAMOD (140  /*137*/ , 23 /* nmod */, "*8 }c " + RAND.seq(" 1_,1_,1_,8_,8_", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "f" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;

    4 * data.tick => w.wait;
   spork ~ MEGAMOD (161  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1//8_,8//1_,F/1_,8//f_, ", 8),"*8 81/fc8c3 " /* modf */, "*4 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (160  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"*8 81/fc8/3 " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"1////f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;
   spork ~ MEGAMOD (140  /*137*/ , 23 /* nmod */, "*8 }c " + RAND.seq(" 1_,1_,1_,8_,8_", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "f" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;
    4 * data.tick => w.wait;
   spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*6*2 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"f//11//f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
    4 * data.tick => w.wait;

} 

fun void  BEAT8  (int n){ 

  while(1 -=> n) {

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
    8 * data.tick =>  w.wait;   
  } 
}

fun void  BEAT82  (int n){ 

  while(1 -=> n) {

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!1!1 __!1!1__!1___!1!1   __!1!1 __!1!1 __!1_ __!2!1  "); 
    8 * data.tick =>  w.wait;   
  } 
}
fun void  BEAT83  (int n){ 
  1 +=> n;
  while(1 -=> n) {
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS1 ("*4  _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 "); 
    8 * data.tick =>  w.wait;   
  } 
}

fun void  LOOP_MOD_SLIDES (){ 
  spork ~   SUPSAW ("*8 }c 1_1_1_1_1_1_1_1_", .8, "*2 8/1" ,1.1); 
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (161  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1//8_,8//1_,F/1_,8//f_, ", 8),"*8 81/fc8c3 " /* modf */, "*4 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~   SUPSAW (" A/c", .3, "1/8" ,1.9); 
  4 * data.tick => w.wait;
  spork ~   SUPSAW ("*8 1_1_1_1_1_1_1_1_", .3, "*2 1/8" ,1.9); 
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (140  /*137*/ , 23 /* nmod */, "*8 }c " + RAND.seq(" 1_,1_,1_,8_,8_", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "f" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;

  4 * data.tick => w.wait;
  spork ~   SUPSAW (" c/A", .5, "*2 8/11/8" ,1.9); 
  spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (160  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"*8 81/fc8/3 " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~   SUPSAW (" c/A", .4, "*2 1/88/1" ,1.9); 
  spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"1////f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;

  4 * data.tick => w.wait;
  spork ~   SUPSAW ("*2 f/P", .3, "*2 1/8" ,1.9); 
  spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"1////f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (140  /*137*/ , 23 /* nmod */, "*8 }c " + RAND.seq(" 1_,1_,1_,8_,8_", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "f" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~   SUPSAW (" c/A", .6, "8/1" ,1.9); 
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"1////f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (140  /*137*/ , 23 /* nmod */, "*8 }c " + RAND.seq(" 1_,1_,1_,8_,8_", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "f" /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  spork ~   SUPSAW ("*2 M/f", .3, "*2 8/1" ,1.9); 
  4 * data.tick => w.wait;
  spork ~ MEGAMOD (138  /*137*/ , 23 /* nmod */, "*2 8 " + RAND.char("18f5B3a///////", 8) ,"*8 8cf " + RAND.char(" 8cf", 8) /* modf */, "*2 fim" /*modg*/, "8" /* g curve */, 4 * data.tick, .6)  ;
  4 * data.tick => w.wait;
//  spork ~ MEGAMOD (162  /*137*/ , 23 /* nmod */, "*8 }c  " + RAND.seq("1_1_, 8_,1_, ", 8),"1////f " /* modf */, "*4 " + RAND.char ("fim", 5) /*modg*/, "8" /* g curve */, 4 * data.tick, .7)  ;
  spork ~   SUPSAW ("*8 }c 1_1_1_1_1_1_1_1_}c 1_1_1_1_1_1_1_1_", .8, "*2 8/1" ,1.1); 
  4 * data.tick => w.wait;

}

fun void  LOOPARP1  (){ 

  spork ~   BEAT8 (8); 
  spork ~ MEGAMOD (133  /*137*/ , 23 /* nmod */, "*8  1_1_ 1___ 1___ 1_1_ __5_ __1_ 1___ 1___ 1_1_ 1___  1_1_ __1_ __1_ 8___" ,":8}c 3//55//3 " /* modf */, "n" /*modg*/, ":8 8" /* g curve */, 64 * data.tick, 0.9)  ;

  spork ~   ARP  ("}c *4  !5!3!1"/* seq */,":8 1185"/*arp*/,2050/*synt*/ , 4*1000 /*lpf*/, 2 /* mixer */, 64*data.tick /*dur*/, .25 /*g*/); 

  32 * data.tick => w.wait;
  spork ~ SUPSAWSLIDE  ("}c :8 G////8  ", .4 /* filter mod phase */, 2.3 /* gain */);
  16 * data.tick => w.wait;
  spork ~ SUPSAWSLIDE  ("}c}c :8 G//8  ", .2 /* filter mod phase */, 2.0 /* gain */);
  16 * data.tick => w.wait;


} 

fun void  LOOPLAB  (){ 
  while(1) {
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
//    spork ~  BASS_WT ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
//    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
//    spork ~  BASS_WT ("*2  _!1_!1_!1_!1_!1_!1_!1_!1  "); 

    8 * data.tick => w.wait;


     //-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
//LOOPLAB(); 

/********************************************************/
// INTRO
if ( 1  ){
   spork ~ MEGAMOD (137  /*137*/ , 23 /* nmod */, "*4 }c 1_" ,":8 0//1 " /* modf */, "6" /*modg*/, ":8 4//8" /* g curve */, 16 * data.tick, 1.3)  ;
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
    8 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
    8 * data.tick =>  w.wait;   
  spork ~   SUPSAW (" A/c", .3, "1/8" ,1.9); 
  spork ~ MEGAMOD (137  /*137*/ , 23 /* nmod */, "*4 }c 1_" ,":8 1//8 " /* modf */, "6" /*modg*/, "8" /* arpi */, 16 * data.tick, 1.3)  ;
    ":4m//CC//Z"=> string lseq;
    spork ~  KICK3_LPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___ ", lseq); 
    spork ~  BASS0_LPF ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11 ", lseq); 
    16 * data.tick =>  w.wait;   

  spork ~   LOOP_BLIPS (); 
  for (0 => int i; i <  4     ; i++) {
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!31  "); 
    8 * data.tick =>  w.wait;   
  }

  spork ~ MEGAMOD (137  /*137*/ , 23 /* nmod */, "*4 }c 1_" ,":8 1//8 " /* modf */, "6" /*modg*/, "8" /* arpi */, 16 * data.tick, 1.4)  ;
  spork ~  KICK3_LPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___ ", lseq); 
  spork ~  BASS0_LPF ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11 ", lseq); 
   16 * data.tick =>  w.wait;   
}

/////////////////////////////////////////////////////////////////////////////////////////////////
if (    0     ){
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
 
  spork ~    LOOP_MOD (); 

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   


    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~    LOOP_MOD (); 

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 k___ ____ k_k_ k___ k___ k___ k_k_ k_k_   "); 
    8 * data.tick =>  w.wait;   

/////////////////////////////////////////////////////////////////////////////////////////////////////////

    spork ~  TABLA ("*4_xY_ _z_X _xzx x__z Xx__ zyxy  xzy _yxz  _xY_ _z_X _xzx x__z Xx__ zyxY  xUy _yUz   "); 
  spork ~    LOOP_BLIPS (); 
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  TABLA ("*4_xY_ _z_X _xzx x__z Xx__ zyxy  xzy _yxz  _xY_ _z_X _xzx x__z Xx__ zyxY  xUy _yUz   "); 

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

  //////////////////////////////////////////////////////////////////////////////////////////////////////
    spork ~  TABLA ("*4_xY_ _z_X _xzx x__z Xx__ zyxy  xzy _yxz  _xY_ _z_X _xzx x__z Xx__ zyxY  xUy _yUz   "); 
   spork ~ MEGAMOD (137  /*137*/ , 23 /* nmod */, "*4 }c 1_" ,":8 0//1 " /* modf */, "6" /*modg*/, ":8 4//8" /* g curve */, 16 * data.tick, 1.3)  ;
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
    8 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11  "); 
    8 * data.tick =>  w.wait;   
     spork ~  TABLA ("*4_xY_ _z_X _xzx x__z Xx__ zyxy  xzy _yxz   "); 
  spork ~ MEGAMOD (137  /*137*/ , 23 /* nmod */, "*4 }c 1_" ,":8 1//8 " /* modf */, "6" /*modg*/, "8" /* arpi */, 16 * data.tick, 1.3)  ;
    ":4m//CC//Z"=> string lseq;
    spork ~  KICK3_LPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  k___ k___ k___ k___ k___ k___ k___ k___ ", lseq); 
    spork ~  BASS0_LPF ("*4  __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11   __!11 __!11 __!11 __!11 ", lseq); 
    16 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////////////////////////////////////////
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/
   spork ~   LOOP_MOD_SLIDES (); 

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   


    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k__k  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

//    spork ~    LOOP_MOD_SLIDES (); 

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!31 __!21 __!11  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) + "____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",2) )  ; 
    8 * data.tick =>  w.wait;   

    spork ~ SUPSAWSLIDE  ("}c :8 L//f  ", .4 /* filter mod phase */, 1.6 /* gain */);
    spork ~ SUPSAWSLIDE  ("}c}c :8 G//8  ", .2 /* filter mod phase */, 1.6 /* gain */);

    spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k___  "); 
    spork ~  BASS0 ("*4  __!11 __!11 __!11 __!3_   __!11 __!11 __!11 __!21  "); 
    spork ~  TRANCEHH ("*4 -2 __h_ -4 s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ "); 
    spork ~  TRANCEHH ("*4 -6 ____ ____ ____  " + RAND.seq("___i, _h__ , _i_-6h ",1) )  ; 
    8 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 k___ ____ k_k_ k___ k___ k___ k_k_ k_k_   "); 
    8 * data.tick =>  w.wait;   

//////////////////////////////////////////////////////////
   LOOPARP1  (); 


}
