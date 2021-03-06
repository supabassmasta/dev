  class control_freq extends CONTROL {
    HPF @ fl;
    HPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      float f;
      Std.mtof(in) => f;
      if (f>19000) {
        <<<"control_freq TOO HIGH:", f>>>;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
      }
      else {

        f => fl.freq => fr.freq;
        <<<"control_freq ", fr.freq()>>>; 
      }
    }

  }

  class control_q extends CONTROL {
    HPF @ fl;
    HPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_Q ", fr.Q()>>>; 
    }
  }

public class STHPFC extends ST{
  HPF hpfl => outl;
  HPF hpfr => outr;

  1000 => hpfl.freq;
  1000 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;

  control_freq cfreq;
  hpfl @=> cfreq.fl;
  hpfr @=> cfreq.fr;

  control_q cq;
  hpfl @=> cq.fl;
  hpfr @=> cq.fr;

  END_CONTROL endf;
  END_CONTROL endq;

  0 => int connected;

  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => hpfl;
    tone.right() => hpfr;

    if (!connected) {
      f.reg(cfreq);
      endf.conf(endf, f ,cfreq);
      if(q != NULL){
        q.reg(cq);
        endq.conf(endq, q ,cq);
      }
      1 =>  connected;
    }
  }


}
