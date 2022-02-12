public class STFREEGAIN extends ST{
  MULT ml => outl;
  MULT mr => outr;

  Gain g => ml;
       g => mr;

  fun void connect(ST @ tone) {
    tone.left() =>  ml;
    tone.right() => mr;
  }
}


