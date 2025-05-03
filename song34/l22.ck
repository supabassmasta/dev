class STCONVREVt extends ST{
  ConvRev cr;

  Gain dryl => outl;
  Gain dryr => outr;


  0 => int start_sample;

  fun void read_ir(ST @ tone, UGen @ ir, dur rev_dur, float rev_g) {
    ir =>  blackhole ;

    // Record samples one by one
    now + rev_dur => time end;
    0 => int i;
    while (now < end ) {
      1::samp => now;
      cr.coeff(i, ir.last()); 
      1 +=> i;
    }

    256 => cr.blocksize ; // set to any power of 2
    cr.init();  // initialize the conv rev engine

    rev_g => cr.gain;
    tone.left() => cr => outl;
    tone.right() => cr => outr;

  }


  fun void connect(ST @ tone, UGen @ ir, dur rev_dur, float rev_g, float dry_g) {
      (rev_dur/ 1::samp) $ int + 1 => cr.order;
      spork ~ read_ir(tone, ir, rev_dur, rev_g);

      // Dry will be alone during the ir loading
      dry_g => dryl.gain => dryr.gain;

      tone.left() => dryl;
      tone.right() => dryr;
  }

}







class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0. => s.phase; } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"{c {c *8 ___ :8  *2
//3//3 !3/////3
//:2*8 _ :8 "
"{c {c *2 !5_  "
=> t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 



STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(15 * 10 /* Base */, 12 * 100 /* Variable */, 1.0 /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .24/* Relative Decay */, 0.3 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.6, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


// STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
// stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 13 * 100 /* freq var */, data.tick * 7 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
// 
// STGAIN stgain;
// stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
// stgain.connect(stsynclpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
39::ms => dur rev_dur;
Noise n => LPF lpf => Envelope e0 =>  Gain ir;
700 => lpf.freq;
0.6 => e0.value;
0.0 => e0.target;
rev_dur => e0.duration ;// => now;

STCONVREVt stconvrev;
stconvrev.connect(last $ ST , ir , rev_dur /*rev_dur*/, .2 /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDELAY stdelay;
stdelay.connect(last $ ST , 166::ms /* static delay */ );       stdelay $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


while(1) {
       100::ms => now;
}




