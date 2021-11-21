TONE t;
t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 _1" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

class STCROSSOVER extends ST{
ST @ last;
STGAIN stgain;

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;

  fun void connect(ST @ tone, float f, float q, int order, int channels, float g) {
    tone @=> last;

    sthpfx0.connect(tone $ ST ,  sthpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       sthpfx0 $ ST @=>  last;  
    stlpfx0.connect(tone $ ST ,  stlpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       stlpfx0 $ ST @=>  last;  

    g => stlpfx0.gain;

    stgain.connect(sthpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;
    stgain.connect(stlpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;

    if (channels == 1 ){
      stgain.left() => outl;
      stgain.left() => outr;
      stgain.right() => Gain trash;
    }
    else {
      stgain.left() => outl;
      stgain.right() => outr;
    }

  }

}

STCROSSOVER stcrossover0;
stcrossover0.connect(last $ ST , 57 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* LPF Gain */ );       stcrossover0 $ ST @=>  last;  

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 2* 10.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2500.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  
while(1) {
       100::ms => now;
}
 
