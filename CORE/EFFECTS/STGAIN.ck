
public class STGAIN extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g) {
    tone.left() => gainl;
    tone.right() => gainr;

    g => gainl.gain => gainr.gain;
  }


}
