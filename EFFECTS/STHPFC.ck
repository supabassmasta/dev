public class STHPFC extends ST{
  HPF hpfl => outl;
  HPF hpfr => outr;

  1000 => hpfl.freq;
  1000 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;

  class control_freq extends CONTROL {
    HPF @ fl;
    HPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      Std.mtof(in) => fl.freq => fr.freq;

      <<<"control_freq ", fr.freq()>>>; 
    }

  }

  class control_q extends CONTROL {
    HPF @ fl;
    HPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_freq ", fr.freq()>>>; 
    }
  }

  control_freq cfreq;
  hpfl @=> cfreq.fl;
  hpfr @=> cfreq.fr;

  control_q cq;
  hpfl @=> cq.fl;
  hpfr @=> cq.fr;


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => hpfl;
    tone.right() => hpfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}
