  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    1 => update_on_reg ;

    Step one => Envelope e => blackhole;
    1. => one.next;
    10::ms => e.duration;
    
    fun void set (float in) {
      float f;
      Std.mtof(in) => f;
      if (f>19000) {
        <<<"control_freq TOO HIGH:", f>>>;
        19000 => e.target;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => e.target;
      }
      else {

        f =>  e.target;
        <<<"control_freq ", f >>>; 
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
    LPF @ fl;
    LPF @ fr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_freq ", fr.freq()>>>; 
    }
  }

public class STLPFC2 extends ST{
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


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => lpfl;
    tone.right() => lpfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}
