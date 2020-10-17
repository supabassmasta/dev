class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1" => t.seq;
.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


class STFREEFILTERX extends ST{
  FILTERX_PATH fpath;

  // Enable Filter LIMITS
  1 => fpath.enable_limit;

  1::ms => dur Period;

  Gain freq => blackhole;

  fun void f1 (){ 
    while(1) {
        freq.last() => fpath.freq; 
        Period => now;
    }
  } 
  spork ~ f1 ();


  fun void connect(ST @ tone, FILTERX_FACTORY @ factory, float q,  int order, int channels, dur period) {
    fpath.build(channels,  order, factory);
    fpath.freq(100);
    fpath.Q(q);
   
    period => Period;

     if ( channels == 1  ){
         tone.left() => fpath.in[0];
         tone.right() => Gain trash;
         fpath.out[0] => outl;
         fpath.out[0] => outr;
     }
     else if (channels > 1) {
        tone.left() => fpath.in[0];
        tone.right() => fpath.in[1];
 
        fpath.out[0] => outl;
        fpath.out[1] => outr;
     }
  }

}

STFREEFILTERX stfilter; RES_XFACTORY stfilterfactory;
stfilter.connect(last $ ST , stfilterfactory, 3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stfilter $ ST @=>  last; 

SinOsc sin0 =>  OFFSET ofs0 => stfilter.freq;
450. => ofs0.offset;
1. => ofs0.gain;

.1 => sin0.freq;
400.0 => sin0.gain;



while(1) {
       100::ms => now;
}
 
