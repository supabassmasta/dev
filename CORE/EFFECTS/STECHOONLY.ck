public class STECHOONLY extends ST{

 Gain fbl => outl;
 fbl => Delay dl => fbl;

 Gain fbr => outr;
 fbr => Delay dr => fbr;

  fun void connect(ST @ tone, dur d, float g) {
    tone.left() => dl;
    tone.right() => dr;

    g =>  dl.gain => dr.gain;
    d => dl.max => dl.delay => dr.max => dr.delay;

  }

}

