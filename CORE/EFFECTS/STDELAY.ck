public class STDELAY extends ST{
  Delay dl => outl;
  Delay dr => outr;

  1. => dl.gain => dr.gain;

  fun void connect(ST @ tone, dur d) {
    tone.left() =>  dl;
    tone.right() => dr;
    d => dl.max => dl.delay;
    d => dr.max => dr.delay;
  }

}

