public class STOVERDRIVE extends ST{
  Overdrive ol => outl;
  Overdrive or => outr;

  1. => ol.drive => or.drive;

  fun void connect(ST @ tone, float d) {
    tone.left() => ol;
    tone.right() => or;

    d => ol.drive => or.drive;
  }
}

