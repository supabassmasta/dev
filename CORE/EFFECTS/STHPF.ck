public class STHPF extends ST{
  HPF hpfl => outl;
  HPF hpfr => outr;

  1000 => hpfl.freq;
  1000 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;


  fun void connect(ST @ tone, float f, float q) {

    f => hpfl.freq => hpfr.freq;
    q => hpfl.Q => hpfr.Q;

    tone.left() => hpfl;
    tone.right() => hpfr;

  }


}
