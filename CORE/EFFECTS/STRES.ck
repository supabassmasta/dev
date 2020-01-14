public class STRES extends ST{
  ResonZ resl => outl;
  ResonZ resr => outr;

  1000 => resl.freq;
  1000 => resr.freq;
  1 => resl.Q;
  1 => resr.Q;


  fun void connect(ST @ tone, float f, float q) {
    f  => resl.freq => resr.freq;
    q  => resl.Q => resr.Q;

    tone.left() => resl;
    tone.right() => resr;

  }

}
