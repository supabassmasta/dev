<<<<<<< HEAD

147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

class SERUM00X extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;

  // 1st Harmonic
  inlet => Gain f2 => SinOsc sin0 =>  outlet;
  -0.3 => sin0.gain;
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
s0.config(2368 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c  _!1!1!1" => t.seq;
1.88 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
=======
class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

138 => data.bpm;   (60.0/data.bpm)::second => data.tick;
54 => data.ref_note;


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4{c {c *3  ___!11_!11_!11_" => t.seq;
1.05 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
>>>>>>> b232706525bbfba9ee2ee6cb534a16ad2b59c64e
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

<<<<<<< HEAD

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
=======
/// 0.7 => float sus;
/// ADSRMOD adsrmod; // Direct ADSR freq input modulation
/// adsrmod.adsr_set(0.0001 /* relative attack dur */, 0.1 /* relative decay dur */ , sus /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
/// adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
/// 1/sus => adsrmod.padsr.gain;
/// adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(184 /* Base */, 69 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .11/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 33 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

   STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
   stbpfx0.connect(last $ ST ,  stbpfx0_fact, 22* 10.0 /* freq */ , 3.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
   0.24 => stbpfx0.gain;
//   0.0 => stbpfx0.gain;
>>>>>>> b232706525bbfba9ee2ee6cb534a16ad2b59c64e
   
   STGAIN stgain;
   stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
   stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

<<<<<<< HEAD

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 7*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

=======
//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 24.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  
>>>>>>> b232706525bbfba9ee2ee6cb534a16ad2b59c64e

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

<<<<<<< HEAD
=======
//STREC strec;
//strec.connect(last $ ST, 8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  

>>>>>>> b232706525bbfba9ee2ee6cb534a16ad2b59c64e
while(1) {
       100::ms => now;
}
 
<<<<<<< HEAD

=======
>>>>>>> b232706525bbfba9ee2ee6cb534a16ad2b59c64e
