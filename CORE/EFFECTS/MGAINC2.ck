class control_gain extends CONTROL {
    Envelope @ e;
    float factor;


    1 => update_on_reg ;

   
    fun void set (float in) {
      in  * factor  / 127. => e.target ;

     <<<"control_gain ", e.target() >>>; 
    }

  }


public class MGAINC2 extends Chubgraph {

  inlet => MULT m => outlet;
  
  Step one => Envelope e => m;
  1. => one.next;
  10::ms => e.duration;
  
  control_gain cgain;
  e @=> cgain.e;

  END_CONTROL endg;

  fun void config(CONTROLER c, float  fact, dur rd) {

    rd => e.duration;

    c.reg(cgain);

    fact => cgain.factor;

    endg.conf(endg, c ,cgain);

  }
}

