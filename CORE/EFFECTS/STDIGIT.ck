public class STDIGIT extends ST{
  digit digl;
  digit digr;

  Gain inl => digl.connect => outl;
  Gain inr => digr.connect => outr;

  fun void connect(ST @ tone, dur ech, float quant) {

    quant => digl.quant;
    ech   => digl.ech;
    quant => digr.quant;
    ech   => digr.ech;

    tone.left() => inl;
    tone.right() => inr;
    

  }
  fun void set( dur ech, float quant) {

    quant => digl.quant;
    ech   => digl.ech;
    quant => digr.quant;
    ech   => digr.ech;

  }

}
