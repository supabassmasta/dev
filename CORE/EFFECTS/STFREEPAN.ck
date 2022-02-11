public class STFREEPAN extends ST{

  Gain pan => OFFSET ofs0 => MULT ml => outl;
  1. => ofs0.offset;
  //0.5 => ofs0.gain;

  pan => OFFSET ofs1 => MULT mr => outr;
  -1. => ofs1.offset;
  //0.5 => ofs1.gain;


  fun void connect(ST @ tone) {
    tone.left() => ml;
    tone.right() => mr;
  }
}

