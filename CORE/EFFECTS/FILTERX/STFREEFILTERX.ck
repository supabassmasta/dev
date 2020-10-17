public class STFREEFILTERX extends ST{
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

