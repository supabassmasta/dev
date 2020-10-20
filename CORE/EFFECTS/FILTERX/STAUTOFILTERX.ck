public class STAUTOFILTERX extends ST{
  FILTERX_PATH fpath;

  // Enable Filter LIMITS
  1 => fpath.enable_limit;

  1::ms => dur Period;

  SinOsc sin0 => OFFSET ofs0 => Gain freq => blackhole;
  1. => ofs0.offset;
  1. => ofs0.gain;
  10.0 => sin0.freq;
  1.0 => sin0.gain;


  fun void f1 (){ 
    while(1) {
      freq.last() => fpath.freq; 
      Period => now;
    }
  } 
  spork ~ f1 ();


  fun void connect(ST @ tone, FILTERX_FACTORY @ factory,  float q, float fbase, float fvar, dur modperiod, int order, int channels, dur period) {
    fpath.build(channels,  order, factory);
    fpath.freq(100);
    fpath.Q(q);

    period => Period;

    1::second / modperiod => sin0.freq;
    fvar / 2 => sin0.gain;

    fvar / 2 + fbase => ofs0.offset;
    1. => ofs0.gain;

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

