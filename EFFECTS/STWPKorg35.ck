public class STWPKorg35 extends ST{
  WPKorg35 lpfl => outl;
  WPKorg35 lpfr => outr;

  1000 => lpfl.cutoff;
  1000 => lpfr.cutoff;
1 =>     lpfl.resonance => lpfr.resonance;
true =>  lpfl.nonlinear => lpfr.nonlinear;



  fun void connect(ST @ tone, float f, float q, int nonlinear) {
    
    f => lpfl.cutoff => lpfr.cutoff;
    q =>  lpfl.resonance => lpfr.resonance;
    nonlinear =>  lpfl.nonlinear => lpfr.nonlinear;

    
    tone.left() => lpfl;
    tone.right() => lpfr;
    
  }


}
