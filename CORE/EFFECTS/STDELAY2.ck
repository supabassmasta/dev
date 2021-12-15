public class STDELAY2 extends ST{
  Delay dl => outl;
  Delay dr => outr;

  fun void connect(ST @ tone,dur dld, dur drd, float g) {
    tone.left() =>  outl;
    tone.right() => outr;
    tone.left() =>  dl;
    tone.right() => dr;
    g => dl.gain => dr.gain;
    dld => dl.max => dl.delay;
    drd => dr.max => dr.delay;
  }

}

