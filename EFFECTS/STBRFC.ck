public class STBRFC extends ST{
  BRF brfl => outl;
  BRF brfr => outr;

  1000 => brfl.freq;
  1000 => brfr.freq;
  1 => brfl.Q;
  1 => brfr.Q;

  class control_freq extends CONTROL {
    BRF @ fl;
    BRF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      Std.mtof(in) => fl.freq => fr.freq;

      <<<"control_freq ", fr.freq()>>>; 
    }

  }

  class control_q extends CONTROL {
    BRF @ fl;
    BRF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_freq ", fr.freq()>>>; 
    }
  }

  control_freq cfreq;
  brfl @=> cfreq.fl;
  brfr @=> cfreq.fr;

  control_q cq;
  brfl @=> cq.fl;
  brfr @=> cq.fr;


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => brfl;
    tone.right() => brfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}