  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      float f;
      Std.mtof(in) => f;
      if (f>19000) {
        <<<"control_freq TOO HIGH:", f>>>;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => fl.freq => fr.freq;
      }
      else {

        f => fl.freq => fr.freq;
        <<<"control_freq ", fr.freq()>>>; 
      }
    }

  }

  class control_q extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_Q ", fr.Q()>>>; 
    }
  }

public class STLPFC extends ST{
  LPF lpfl => outl;
  LPF lpfr => outr;

  1000 => lpfl.freq;
  1000 => lpfr.freq;
  1 => lpfl.Q;
  1 => lpfr.Q;

  control_freq cfreq;
  lpfl @=> cfreq.fl;
  lpfr @=> cfreq.fr;

  control_q cq;
  lpfl @=> cq.fl;
  lpfr @=> cq.fr;

 END_CONTROL endf;
 END_CONTROL endq;

  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => lpfl;
    tone.right() => lpfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
      endq.conf(endq, q ,cq);
    }
 
    endf.conf(endf, f ,cfreq);
  }


}
