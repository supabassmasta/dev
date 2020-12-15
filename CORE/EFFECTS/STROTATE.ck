public class STROTATE extends ST{
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

