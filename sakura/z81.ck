class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *2 1" => t.seq;
.4 * data.master_gain => t.gain;
t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

class STROTATE extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1::ms => dur rate;

  1. => gainl.gain => gainr.gain;

  // Rear front gain
  SinOsc sin0 => OFFSET ofs0 => blackhole;
  1. => ofs0.offset;
  0.5 => ofs0.gain;
  
  0 => sin0.phase;

  // left right gain
  SinOsc sin1 =>OFFSET ofs1 =>  blackhole;
  0.25 => sin1.phase;
  1. => ofs1.offset;
  0.5 => ofs1.gain;

  fun void f1 (){ 
    while(1) {
//      sin1.last() * sin0.last() => gainl.gain; 
//      (1. - sin1.last()) * sin0.last() => gainr.gain; 
      ofs1.last() * ofs0.last()  => gainl.gain; 
      (1. - ofs1.last())* ofs0.last() => gainr.gain; 
        rate => now;
    }
  } 
  spork ~ f1 ();



  fun void connect(ST @ tone, float freq, float depth, float width, dur r ) {
    tone.left() => gainl;
    tone.right() => gainr;
    freq => sin0.freq => sin1.freq;
    depth=> sin0.gain;

    width => sin1.gain;

    r => rate;


  }


}

STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, -1. /* width */  , 1::samp /* update rate */      ); strot$ ST @=>  last; 

//Step stp0 =>  Envelope e0 =>  strot.sin0; e0 => strot.sin1;
//0.6 => e0.value;
//10.0 => e0.target;
//64.0 * data.tick => e0.duration ;// => now;

//1.0 => stp0.next;

SinOsc sin0 => OFFSET ofs0 => strot.sin0; ofs0 => strot.sin1;

1.1 => ofs0.offset;
1. => ofs0.gain;

.03 => sin0.freq;
1.0 => sin0.gain;


//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
