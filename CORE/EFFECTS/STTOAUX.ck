public class STTOAUX extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g2main, float g2aux, int stnb) {
    // TO main
    tone.left() => gainl;
    tone.right() => gainr;
    g2main => gainl.gain => gainr.gain;

    // To AUX
    if (stnb != 0) {
    tone.left() => Gain auxl=> dac.chan(2*stnb);
    tone.right() => Gain auxr =>dac.chan(2*stnb + 1);
    g2aux => auxl.gain => auxr.gain;
    }
    else {
      <<<"ERROR: STTOAUX, Stereo pair index 0 means main">>>;

    }
  }
}
