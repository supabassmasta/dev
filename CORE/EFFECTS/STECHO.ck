public class STECHO extends ST{

 Gain fbl => outl;
 fbl => Delay dl => fbl;

 Gain fbr => outr;
 fbr => Delay dr => fbr;

  fun void connect(ST @ tone, dur d, float g) {
    tone.left() => fbl;
    tone.right() => fbr;

    g =>  dl.gain => dr.gain;
    d => dl.max => dl.delay => dr.max => dr.delay;

  }

}

