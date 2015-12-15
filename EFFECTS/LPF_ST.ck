public class LPF_ST {

  Gain inl => LPF lpfl => Gain outl;
  Gain inr => LPF lpfr => Gain outr;

  class cont extends CONTROL {
    LPF @ fl;    
    LPF @ fr;    

   fun void set(float in) {
     Std.mtof(in) => fl.freq => fr.freq;
   }

  }

  cont c;
  lpfl @=> c.fl;
  lpfr @=> c.fr;
  
  // Init as full open
  Std.mtof(127)=> lpfl.freq => lpfr.freq;
}
