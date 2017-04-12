public class STBPFC extends ST{
  BPF bpfl => outl;
  BPF bpfr => outr;

  1000 => bpfl.freq;
  1000 => bpfr.freq;
  1 => bpfl.Q;
  1 => bpfr.Q;

  class control_freq extends CONTROL {
    BPF @ fl;
    BPF @ fr;
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
    BPF @ fl;
    BPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_freq ", fr.freq()>>>; 
    }
  }

  control_freq cfreq;
  bpfl @=> cfreq.fl;
  bpfr @=> cfreq.fr;

  control_q cq;
  bpfl @=> cq.fl;
  bpfr @=> cq.fr;


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => bpfl;
    tone.right() => bpfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}
