class control_gain extends CONTROL {
    Gain @ gl;
    float factor;


    1 => update_on_reg ;
    
    fun void set (float in) {
      in  * factor  / 127. => gl.gain ;

     <<<"control_gain ", gl.gain()>>>; 
    }

  }


public class MGAINC extends Chugraph {

  inlet => Gain G => outlet;

  control_gain cgain;
  G @=> cgain.gl;

  END_CONTROL endg;

  fun void config(CONTROLER c, float  fact) {
    c.reg(cgain);

    fact => cgain.factor;

    endg.conf(endg, c ,cgain);

  }
}

