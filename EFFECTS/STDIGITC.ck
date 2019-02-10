  class control_ech extends CONTROL {
    digit @ dlp;
    digit @ drp;

    1 => update_on_reg ;

    fun void set (float in) {
      if (in == 0) 1. => in;
      (in $ int) * 1::samp   =>  dlp.ech => drp.ech;
      <<<"control_ech ", dlp.ech>>>;
    }
  
  }

  class control_quant extends CONTROL {
    digit @ dlp;
    digit @ drp;

    1 => update_on_reg ;
    
    fun void set (float in) {
      in / 1000. =>  dlp.quant => drp.quant;
      <<<"control_quant ", dlp.quant>>>;

    }
  }

public class STDIGITC extends ST{
  digit digl;
  digit digr;

  Gain inl => digl.connect => outl;
  Gain inr => digr.connect => outr;

  control_ech cech;
  digl @=> cech.dlp;
  digr @=> cech.drp;
  
  control_quant cquant;
  digl @=> cquant.dlp;
  digr @=> cquant.drp;

  fun void connect(ST @ tone, CONTROLER ech, CONTROLER quant) {

    tone.left() => inl;
    tone.right() => inr;
    
    ech.reg(cech);
    quant.reg(cquant);
  }

}
