
147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
51 => data.ref_note;

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


TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(2368 /* synt nb */ ); 
s0.config(2374 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c  _!1!1!1" => t.seq;
1.50 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
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

while(1) {
       100::ms => now;
}
 

