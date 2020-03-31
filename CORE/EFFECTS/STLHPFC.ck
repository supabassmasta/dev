  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      float f;

      if ( in < 64  ){
        // Open HPF
        10 => hl.freq => hr.freq;

        Std.mtof(in * 2) => f;
        if (f>19000) {
          <<<"LPF control_freq TOO HIGH:", f>>>;
          19000 => fl.freq => fr.freq;
        }
        else if (f< 10) {
          <<<" LPF control_freq TOO LOW:", f>>>;
          10 => fl.freq => fr.freq;
        }
        else {
          f => fl.freq => fr.freq;
          <<<"LPF control_freq ", fr.freq()>>>; 
        }
      }
      else {
        // Open LPF
        19000 => fl.freq => fr.freq;
        Std.mtof((in - 64) * 2) => f;
        if (f>19000) {
          <<<"HPF control_freq TOO HIGH:", f>>>;
          19000 => hl.freq => hr.freq;
        }
        else if (f< 10) {
          <<<" HPF control_freq TOO LOW:", f>>>;
          10 => hl.freq => hr.freq;
        }
        else {
          f => hl.freq => hr.freq;
          <<<"HPF control_freq ", hr.freq()>>>; 
        }



      }
    }

  }

  class control_q extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q => hl.Q => hr.Q;

      <<<"control_Q ", fr.Q()>>>; 
    }
  }

public class STLHPFC extends ST{
  LPF lpfl => HPF hpfl => outl;
  LPF lpfr => HPF hpfr => outr;

  1000 => lpfl.freq;
  1000 => lpfr.freq;
  1 => lpfl.Q;
  1 => lpfr.Q;

  0 => hpfl.freq;
  0 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;

  control_freq cfreq;
  lpfl @=> cfreq.fl;
  lpfr @=> cfreq.fr;
  hpfl @=> cfreq.hl;
  hpfr @=> cfreq.hr;

  control_q cq;
  lpfl @=> cq.fl;
  lpfr @=> cq.fr;
  hpfl @=> cq.hl;
  hpfr @=> cq.hr;

  END_CONTROL endf;
  END_CONTROL endq;

  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => lpfl;
    tone.right() => lpfr;

    f.reg(cfreq);
    endf.conf(endf, f ,cfreq);
    if(q != NULL){
      q.reg(cq);
      endq.conf(endq, q ,cq);
    }
  }


}

