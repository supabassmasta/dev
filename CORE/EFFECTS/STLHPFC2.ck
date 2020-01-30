  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;

    Step one => Envelope ef => blackhole;
    one => Envelope eh => blackhole;
    1. => one.next;
    10::ms => ef.duration => eh.duration;
    
    fun void set (float in) {
      float f;

      if ( in < 64  ){
        // Open HPF
        10 => eh.target;
        // reset his Q
        // 1. => hl.Q => hr.Q;

        Std.mtof(in * 2) => f;
        if (f>19000) {
          <<<"LPF control_freq TOO HIGH:", f>>>;
          19000 => ef.target;
        }
        else if (f< 10) {
          <<<" LPF control_freq TOO LOW:", f>>>;
          10 => ef.target;
        }
        else {
          f => ef.target;
          <<<"LPF control_freq ", f>>>; 
        }
      }
      else {
        // Open LPF
        19000 => ef.target;
        // reset his Q
        // 1. => fl.Q => fr.Q;

        Std.mtof((in - 64) * 2) => f;
        if (f>19000) {
          <<<"HPF control_freq TOO HIGH:", f>>>;
          19000 => eh.target;
        }
        else if (f< 10) {
          <<<" HPF control_freq TOO LOW:", f>>>;
          10 => eh.target;
        }
        else {
          f => eh.target;
          <<<"HPF control_freq ", f>>>; 
        }



      }
    }


    fun void f1 (){ 
      while(1) {
        ef.last() => fl.freq => fr.freq;
        eh.last() => hl.freq => hr.freq;
        1::samp => now;
      }
    } 
    spork ~ f1 ();
        



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

public class STLHPFC2 extends ST{
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


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q) {
    tone.left() => lpfl;
    tone.right() => lpfr;

    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}

