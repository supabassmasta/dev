public class LPF_ST {


  Gain inl =>  Gain outl;
  Gain inr =>  Gain outr;
  LPF lpfl;
  LPF lpfr;

  0 => int enabled;
  fun void enable(){
    if (!enabled) {
      1 => enabled;
      inl =< outl;
      inr =< outr;
      inl => lpfl => outl;
      inr => lpfr => outr;
    }
    
  }

  class cont extends CONTROL {
    LPF @ fl;    
    LPF @ fr;    
    LPF_ST @ mother;

   fun void set(float in) {
     mother.enable();
     Std.mtof(in) => fl.freq => fr.freq;
   }

  }

  cont c;
  lpfl @=> c.fl;
  lpfr @=> c.fr;
  this @=> c.mother;
  
  // Init as full open
  Std.mtof(127)=> lpfl.freq => lpfr.freq;
}
