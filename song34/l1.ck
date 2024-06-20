class STCONVREV extends ST{
  ConvRev cr;
  SndBuf2 ir => blackhole;

  Gain gainl => outl;
  Gain gainr => outr;

  Gain dryl => outl;
  Gain dryr => outr;
  Delay dl ;
  Delay dr ;
  1. => dl.gain => dr.gain;

  1. => dl.gain => dr.gain;

  1. => gainl.gain => gainr.gain;


  fun void connect(ST @ tone, dur pre_delay, float rev_g, float dry_g) {
"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => ir.read; // 48000 sr, mono
//"../_SAMPLES/ConvolutionImpulseResponse/bottle_hall.wav" => ir.read; // 48000 sr, mono
//"../_SAMPLES/ConvolutionImpulseResponse/cement_blocks_1.wav" => ir.read; // 48000 sr, mono

//    "../_SAMPLES/ConvolutionImpulseResponse/five_columns.wav" => ir.read;
    ir.samples() => cr.order;
    cr.order() => int order;
    for (0 => int i; i < order; i++) {
      /* cr.coeff(i, ir.valueAt(i*2));  // do this if the IR is stereo */
      cr.coeff(i, ir.valueAt(i));  // do this if IR is mono
    }

    256 => cr.blocksize; // set to any power of 2
    cr.init();  // initialize the conv rev engine

    dry_g => dryl.gain => dryr.gain;

    tone.left() => dryl;
    tone.right() => dryr;

    rev_g => cr.gain;

    pre_delay => dl.max => dl.delay;
    pre_delay => dr.max => dr.delay;

    // CR is mono
    tone.left() => dl => cr => gainl;
    tone.right() => dr =>  cr => gainr;
//    tone.right() => cr.right() => gainr;

  }

}


TONE t;
t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *2 }c 123_ ____ 4___ 5_1_" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 6 * 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
