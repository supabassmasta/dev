13 => int mixer;


// Declare KIK outside funk 
KIK kik;
kik.config(0.1 /* init Sin Phase */, 15 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (117.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (0.8, 10::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


fun void KICK3(string seq) {

TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.44 * data.master_gain => t.gain;
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
.44 * data.master_gain => t.gain;
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
  1.31 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
  // t.print(); //t.force_off_action();
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
1.05 * data.master_gain => t.gain;
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
  0.02 => sin0.gain;

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

    g * data.master_gain => stfreelpfx0.gain;

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
   
   g * data.master_gain => s.gain;

   file => s.read;

   s.length() => now;
} 

fun void  SINGLEWAVRATE  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g* data.master_gain => s.gain;

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
   g * data.master_gain => s.gain;

   file => s.read;

   12 * data.tick => now;
} 

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

fun void  VOICES  (){ 
   WAIT w;
   8 *data.tick => w.fixed_end_dur;
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/MicroDosage.wav",  .3); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .4); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/DoncJusteUnBout.wav", .5); 
   12 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/CestpourCaQuonDitMicorDosage.wav", .5); 
   12 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.1, .5); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.4, .5); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.6, .5); 
   2 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATEECHO("../_SAMPLES/HighMaintenance/MicroDosage2.wav", 1.8, .5); 
   16 * data.tick =>  w.wait; 
} 

fun void  VOICES_2  (){ 
   WAIT w;
   8 *data.tick => w.fixed_end_dur;
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/AChaqueFois.wav", .5); 
   16 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/EnPrendreCombien.wav", .3); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/CaJenSaisRien.wav", .5); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .5); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .5); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .6, .5); 
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

fun void  PAD  (){ 
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(36 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  4 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
  s0.add(10 /* synt nb */ , 0 /* rank */ , 1.1 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 3 * data.tick /* decay */, .0001 /* sustain */, 1* data.tick /* release */ );
  s0.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );
  s0.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.01 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );

  //t.reg(SERUM1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //s1.add(36 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  4 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
  //s1.add(10 /* synt nb */ , 0 /* rank */ , 1.1 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 3 * data.tick /* decay */, .0001 /* sustain */, 1* data.tick /* release */ );
  //s1.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );
  //s1.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.01 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );

  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  ":2 {c 
    1///1_5///5_ 
    0///0_3///3_

    " => t.seq;
  .32 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//
  t.no_sync();//  t.full_sync(); //
  1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  // Mod
  SinOsc sin0 =>  s0.sl[0].inlet;
  4.0 => sin0.freq;
  1.0 => sin0.gain;


  STROTATE strot;
  strot.connect(last $ ST , 1.6 /* freq */  , 0.01 /* depth */, 0.01 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
  // => strot.sin0;  => strot.sin1; // connect to make freq change 

  STGVERB stgverb;
  stgverb.connect(last $ ST, .15 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

  64 * data.tick => now;

} 

/////////////////////////////////////////////////////////////////////////////////////:

fun void GLITCH (string seq, string seq_cutter, string seq_arp,  int instru ) {
  
  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  seq => t.seq;
  .4 * data.master_gain => t.gain;
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
   
   1.2 => o.offset;
   .7 => o.gain;
   
  // MOD ////////////////////////////////
  
  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////
fun void  SUPERS  ( dur d){ 


  TONE t;
  t.reg(SUPERSAW2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "*4
    1111 1/F___ ____ F/1111
    1/8___ ____ ____ ____
    3333 3/F___ ____ 0000 
    0/8___ ____ ____ ____

    " => t.seq;
  .65 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); 
  4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STECHO ech;
  ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

  STGVERB stgverb;
  stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

  SinOsc sin0 =>  s0.inlet;
  10.0 => sin0.freq;
  3.0 => sin0.gain;

  d => now;

} 


///////////////////////////////////////////////////////////////////////////////////
fun void ARPI (dur d){ 
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(3 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  " }c *4 1530 B438" => t.seq;
  .6 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); //
  .25 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 2 * 100 /* freq base */, 12 * 100 /* freq var */, data.tick * 24 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  d => now;
} 
///////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

.7 => data.master_gain;

147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1*data.tick => w.sync_end_dur;

////////////////////////////////////////////////////////////////////////////////////

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

///////////////////// PLAYBACK/REC /////////////////////////

1 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"HighM_main.wav" => string name_main;
"HighM_aux.wav" => string name_aux;
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


spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 

4 * data.tick =>  w.wait; 

spork ~ ACOUSTICTOM("*4 AA_B B_CC _DD_ UNNU ");


4 * data.tick =>  w.wait; 

LONG_WAV l;
"../_SAMPLES/HighMaintenance/VousFumezTjr.wav" => l.read;
0.25 * data.master_gain => l.buf.gain;
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
0.55 * data.master_gain => l2.buf.gain;
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

  spork ~  KICK3 ("LLLL LLLL LLLL   "); 
  spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
                      __1!1 __1!1 __1!1 __8/1_   "); 

  spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh"); 
  8 * data.tick =>  w.wait;   
  spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
  4 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 L_L_ LLL_ LL_L L__L_"); 
  4 * data.tick =>  w.wait;   


// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  spork ~   PAD (); 
  spork ~  KICK3_HPF ("LLLL LLLL LLLL LLLL    LLLL LLLL LLLL LLLL
                   LLLL LLLL LLLL LLLL    LLLL LLLL LLLL      ", ":8:2 M//f f//M"); 

  8 * data.tick =>  w.wait;
  spork ~ GLITCH("*8 +4 1__1__1__1" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 24 /* instru */);
  8 * data.tick =>  w.wait;

  spork ~ GLITCH("*8 +1 012345" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 23 /* instru */);
  4 * data.tick =>  w.wait;
  spork ~ GLITCH("*4 -3  3/41/5G/00/1" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 18 /* instru */);
  4 * data.tick =>  w.wait;
  4 * data.tick =>  w.wait;
  spork ~ GLITCH("*8  81818" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 23 /* instru */);
  4 * data.tick =>  w.wait;

  ////////////////// MIDDLE BREAK
  spork ~ GLITCH("*8 +3 f//G" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 25 /* instru */);
  4 * data.tick =>  w.wait;
  spork ~ GLITCH("*8 41038501345" /* seq */,  "*2 1_1 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 25 /* instru */);
  4 * data.tick =>  w.wait;
  spork ~ GLITCH("*2  3/41/5G/00/1" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 23 /* instru */);
  4 * data.tick =>  w.wait;
  spork ~ GLITCH("*8 -2  1_11_1" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 8 /* instru */);
  4 * data.tick =>  w.wait;
   

  spork ~  SLIDENOISE(20 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);
  12 * data.tick =>  w.wait; 
  spork ~  KICK3 ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
  4 * data.tick =>  w.wait;


  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }

// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  0 => data.next;

  while(! data.next ) {
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

    spork ~ SUPERS ( 64 * data.tick  );
    spork ~ ARPI ( 64 * data.tick  );

    spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
    spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
        __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 
      spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
    16 * data.tick =>  w.wait;   
    spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L___ __L_  :4 "); 
    spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
        __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 
      spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
    16 * data.tick =>  w.wait;   
    spork ~  KICK3 ("   LLLL LLLL LLLL LL *4 L__L __L_ :4  "); 
    spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
        __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 
      spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
    16 * data.tick =>  w.wait;   
    spork ~  KICK3 ("  LLLL LLLL LLLL LL *4 L___ L_L_ :4  "); 
    spork ~  BASS0 ("*4  __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __0!0 __1/8_
        __1!1 __1!1 __1!1 __8/1_  __1!1 __1!1 __3!2 1!0!1!1/8  "); 
      spork ~  TRANCEHH ("*4 __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh __h_ v|S_hh "); 
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

// END
  spork ~  SLIDENOISE(3000 /* fstart */, 200 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
  16 * data.tick =>  w.wait;   
 
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}


