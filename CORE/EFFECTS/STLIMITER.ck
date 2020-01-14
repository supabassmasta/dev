public class STLIMITER extends ST{
  Gain gainl => Dyno dyl => outl;
  Gain gainr => Dyno dyr => outr;
  dyl.limit();
  dyr.limit();

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g, float out_g, float sA, float sB, float tr, dur at, dur rt  ) {
    tone.left() => gainl;
    tone.right() => gainr;
    
    sA => dyl.slopeAbove=> dyr.slopeAbove;
    sB => dyl.slopeBelow=> dyr.slopeBelow;
    tr => dyl.thresh  => dyr.thresh;
    at => dyl.attackTime => dyr.attackTime;
    rt => dyl.releaseTime => dyr.releaseTime;
    out_g => dyl.gain => dyr.gain;
    g => gainl.gain => gainr.gain;
  }


}

