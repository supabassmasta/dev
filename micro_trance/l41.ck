21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 17 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (250.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 4 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 4 * 10::ms);
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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.38 =>p.phase; } 1 => own_adsr;
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
stsynclpfx0.freq(11 * 10 /* Base */, 69 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .19 /* Relative Sustain dur */, 0.2 /* Relative release */);
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

///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
  SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
   s.wav["U"]=> s.wav["u"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .9 * data.master_gain => s.gain; //
  s.gain("u", 1.6); // for single wav 
  //s.sync(4*data.tick);// s.element_sync(); //
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();   //  s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT1 (string seq, string Arp, int nb, dur glide, float g, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
   s0.config(nb /* synt nb */ ); 

   glide => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
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

    ARP arp;
    arp.t.dor();
    50::ms => arp.t.glide;
    Arp => arp.t.seq;
    arp.t.go();   

    // CONNECT SYNT HERE
    3 => s0.inlet.op;
    arp.t.raw() => s0.inlet; 


STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 25 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 16* 100.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  


   d => now;

} 


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT2 (string seq, string Arp, int nb, dur glide, float g, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
   s0.config(nb /* synt nb */ ); 

   glide => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
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

    ARP arp;
    arp.t.dor();
    50::ms => arp.t.glide;
    Arp => arp.t.seq;
    arp.t.go();   

    // CONNECT SYNT HERE
    3 => s0.inlet.op;
    arp.t.raw() => s0.inlet; 


STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 25 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 26* 100.0 /* freq */ , 1.3 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  

   d => now;

} 
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

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer + 1);
  
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

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 









150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1::samp => w.fixed_end_dur;


// INTRO
  if (1) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  8 * data.tick =>  w.wait;   

}


/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
 ////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

//           SYNT TIME

///////////////////////////////////////////////////////////////////////////////////////////:
  spork ~ SYNT1 ("*4  84B21" /* seq*/, "*2 11118 111B" /*arp*/, 8 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );

  //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
  //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
   
  spork ~ SYNT2 ("*8  5_3_1_" /* seq*/, "*3:211F" /*arp*/, 10 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   


  //////////////////////////////////////////////////////////////////////////////////////:

  //                           SPOCK

  /////////////////////////////////////////////////////////////////////////////////////////:

  spork ~   SINGLEWAV("../_SAMPLES/Spock/MedicOnSpock.wav", .3); 

 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  8 * data.tick =>  w.wait;   


}
