  class control_gain extends CONTROL {
    Gain @ gl;
    Gain @ gr;
    float factor;


    1 => update_on_reg ;
    
    fun void set (float in) {
      in  * factor  / 127. => gl.gain => gr.gain;

     <<<"control_gain ", gl.gain()>>>; 
    }

  }

public class STGAINC extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  control_gain cgain;
  gainl @=> cgain.gl;
  gainr @=> cgain.gr;

  END_CONTROL endg;
  0 => int connected;

  fun void connect(ST @ tone, CONTROLER g, float fact) {

    tone.left() => gainl;
    tone.right() => gainr;

    if (!connected) {
      fact => cgain.factor;
      g.reg(cgain);
      endg.conf(endg, g ,cgain);
      1 =>  connected;
    }

  }


}
