13 => int mixer;


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

////////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////////

fun void MOD1 () {
  ST st;

  SinOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.03 => sin0.gain;

  6.0 => tri0.freq;
  34.0 *100=> tri0.gain;
//  0.5 => tri0.width;

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  4 * data.tick => now;

}

////////////////////////////////////////////////////////////////////////////////////
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
  t.reg(SERUM0 s0); s0.config(15,0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .18 * data.master_gain => t.gain;
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

  1.8 => sin0.freq;
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
fun void  RAND2  (string begin, int nb){ 

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
  t.reg(SERUM0 s0); s0.config(17,1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .4 * data.master_gain => t.gain;
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

  2.8 => sin0.freq;
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

fun void  RAND3  (string begin, int nb){ 

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
  .23 * data.master_gain => t.gain;
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

fun void  RAND4  (string begin, int nb){ 

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
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .4 * data.master_gain => t.gain;
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


fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

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

fun void  SINGLEWAVRATEECHO  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STECHO ech;
   ech.connect(last $ ST , data.tick * 4 / 4 , .8);  ech $ ST @=>  last; 
//   STMIX stmix;
//   stmix.send(last, mixer);

   r => s.rate;
   g => s.gain;

   file => s.read;

   12 * data.tick => now;
} 

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

fun void  VOICES  (){ 
   WAIT w;
   8 *data.tick => w.fixed_end_dur;
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/MicroDosage.wav", .4); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .5); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/DoncJusteUnBout.wav", .5); 
   12 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/CestpourCaQuonDitMicorDosage.wav", .6); 
   12 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.1, .6); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.4, .6); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.6, .6); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATEECHO("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.8, .6); 
   16 * data.tick =>  w.wait; 
} 

fun void  VOICES_2  (){ 
   WAIT w;
   8 *data.tick => w.fixed_end_dur;
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/AChaqueFois.wav", .6); 
   16 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/EnPrendreCombien.wav", .4); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/CaJenSaisRien.wav", .6); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .6); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .6); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .6, .6); 
   16 * data.tick =>  w.wait; 
//   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/.wav", .4); 
//   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/.wav", .4); 
} 


fun void  RAND_FROG  (){ 
    WAIT w;
   1 *data.tick => w.fixed_end_dur;
  
  spork ~   FROG(Std.rand2f(2, 4) /* fstart */, Std.rand2f(200, 400) /* fstop */,Std.rand2f(3 *100, 40* 100)  /* lpfstart */, Std.rand2f(3 *100, 40* 100) /* lpfstop */, 2* data.tick /* dur */, .1 /* gain */);
  
  4 * data.tick =>  w.wait; 


  spork ~   RAND3 ("}c *8 ", Std.rand2(8, 16));   4 * data.tick =>  w.wait; 

  spork ~   RAND ("}c *4 ", Std.rand2(4, 10));   4 * data.tick =>  w.wait; 

  spork ~   FROG(Std.rand2f(200, 400) /* fstart */, Std.rand2f(2, 4) /* fstop */,Std.rand2f(3 *100, 40* 100)  /* lpfstart */, Std.rand2f(3 *100, 40* 100) /* lpfstop */, 2* data.tick /* dur */, .1 /* gain */);
  
  4 * data.tick =>  w.wait; 
 
  spork ~   RAND2 ("}c *6 ", Std.rand2(6, 12));   4 * data.tick =>  w.wait; 

  spork ~   RAND ("}c *4 ", Std.rand2(4, 10));   4 * data.tick =>  w.wait; 

 
  spork ~   RAND2 ("}c }c *8 ", Std.rand2(11, 18));   4 * data.tick =>  w.wait; 

  spork ~   RAND (" *4 ", Std.rand2(4, 10));   4 * data.tick =>  w.wait; 

} 

fun void  RAND_FROG_2  (){ 
    WAIT w;
   1 *data.tick => w.fixed_end_dur;

  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 24 * 100 /* lpfstop */, 2* data.tick /* dur */, .1 /* gain */);
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   FROG(29 /* fstart */, 2 /* fstop */, 9 * 100 /* lpfstart */, 34 * 100 /* lpfstop */, 1* data.tick /* dur */, .1 /* gain */);
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
}
////////////////////////////////////////////////////////////////////////////////////



147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1 *data.tick => w.fixed_end_dur;


////////////////////////////////////////////////////////////////////////////////////
//         OUTPUT
////////////////////////////////////////////////////////////////////////////////////

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


////////////////////////////////////////////////////////////////////////////////////
// INTRO

  if ( 0  ){
}
      

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L___ L__L :4   "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L___ __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  12 * data.tick =>  w.wait;   

//    LLLL LLLL LLLL LL *4 L___ L__L :4
//    LLLL LLLL LLLL LL *4 L___ __L_ :4
//    LLLL LLLL LLLL LL *4 L__L __L_ :4
//    LLLL LLLL LLLL LL *4 L___ L_L_ :4


spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 

4 * data.tick =>  w.wait; 

spork ~ ACOUSTICTOM("*4 AA_B B_CC _DD_ UNNU ");


4 * data.tick =>  w.wait; 

LONG_WAV l;
"../_SAMPLES/HighMaintenance/VousFumezTjr.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1::samp /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=>  last;  

STECHO ech2;
ech2.connect(last $ ST , data.tick * 1 / 4 , .2);  ech $ ST @=>  last; 

4 * data.tick =>  w.wait; 

spork ~   MOD1 (); 
spork ~  SLIDENOISE(4000 /* fstart */, 200 /* fstop */, 4* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
4 * data.tick =>  w.wait; 

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  spork ~  VOICES (); 
  spork ~  RAND_FROG (); 

  spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4 "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  RAND_FROG (); 

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  spork ~  RAND_FROG (); 

  spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4 "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  RAND_FROG (); 

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh __h_ v_hh "); 
  12 * data.tick =>  w.wait;   
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
  4 * data.tick =>  w.wait; 

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

spork ~ ACOUSTICTOM("*4 A_AB B_CC D_DV UNNU ");


4 * data.tick =>  w.wait; 

LONG_WAV l2;
"../_SAMPLES/HighMaintenance/DrgRecreative.wav" => l2.read;
0.6 * data.master_gain => l2.buf.gain;
0 => l2.update_ref_time;
l2.AttackRelease(0::ms, 0::ms);
l2.start(1::samp /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l2 $ ST @=>  last;  

4 * data.tick =>  w.wait; 

spork ~   MOD1 (); 
spork ~  SLIDENOISE(4000 /* fstart */, 200 /* fstop */, 4* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
4 * data.tick =>  w.wait; 



//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  spork ~  VOICES_2 (); 
  spork ~ RAND_FROG_2  ();

  spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~ RAND_FROG_2  ();
  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4 "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   


//////////////////////////////////////////////////////////////////////////////////////////////

  spork ~ RAND_FROG_2  ();
  spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~ RAND_FROG_2  ();
  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4 "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~  RAND_FROG_2 (); 

  spork ~  KICK3 (" LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   

  spork ~ RAND_FROG_2  ();

  spork ~  KICK3 ("LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
  16 * data.tick =>  w.wait;   



//    LLLL LLLL LLLL LL *4 L___ L__L :4
//    LLLL LLLL LLLL LL *4 L___ __L_ :4
//    LLLL LLLL LLLL LL *4 L__L __L_ :4
//    LLLL LLLL LLLL LL *4 L___ L_L_ :4

