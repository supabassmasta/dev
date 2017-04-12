public class STRESC extends ST{
  ResonZ resl => outl;
  ResonZ resr => outr;

  1000 => resl.freq;
  1000 => resr.freq;
  1 => resl.Q;
  1 => resr.Q;

  class control_freq extends CONTROL {
    ResonZ @ fl;
    ResonZ @ fr;
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
    ResonZ @ fl;
    ResonZ @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_freq ", fr.freq()>>>; 
    }
  }

  control_freq cfreq;
  resl @=> cfreq.fl;
  resr @=> cfreq.fr;

  control_q cq;
  resl @=> cq.fl;
  resr @=> cq.fr;


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => resl;
    tone.right() => resr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}
