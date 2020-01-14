public class STBRF extends ST{
  BRF brfl => outl;
  BRF brfr => outr;

  1000 => brfl.freq;
  1000 => brfr.freq;
  1 => brfl.Q;
  1 => brfr.Q;


  fun void connect(ST @ tone, float f, float q) {
    
    f => brfl.freq => brfr.freq;
    q => brfl.Q => brfr.Q; 

    tone.left() => brfl;
    tone.right() => brfr;

  }


}
