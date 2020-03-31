  class control_freq extends CONTROL {
    HPF @ fl;
    HPF @ fr;
    1 => update_on_reg ;

    Step one => Envelope e => blackhole;
    1. => one.next;
    10::ms => e.duration;

    fun void set (float in) {
      float f;
      Std.mtof(in) => f;
      if (f>19000) {

        19000 => e.target;

        <<<"control_freq TOO HIGH:", f>>>;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => e.target;
      }
      else {

        f => e.target;
        <<<"control_freq ", f>>>; 
      }
    }

    fun void f1 (){ 
      while(1) {
        e.last() => fl.freq => fr.freq;

        1::samp => now;
      }
    } 
    spork ~ f1 ();
 
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

public class STHPFC2 extends ST{
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

  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => hpfl;
    tone.right() => hpfr;

    f.reg(cfreq);
    endf.conf(endf, f ,cfreq);
    if(q != NULL){
      q.reg(cq);
      endq.conf(endq, q ,cq);
    }
  }


}
