public class STWPDiodeLadder extends ST{
  WPDiodeLadder lpfl => outl;
  WPDiodeLadder lpfr => outr;

  1000 => lpfl.cutoff;
  1000 => lpfr.cutoff;
1 =>     lpfl.resonance => lpfr.resonance;
true =>  lpfl.nonlinear => lpfr.nonlinear;
false => lpfl.nlp_type =>  lpfr.nlp_type;



  fun void connect(ST @ tone, float f, float q, int nonlinear, int nlp_type) {
    
    f => lpfl.cutoff => lpfr.cutoff;
    q =>  lpfl.resonance => lpfr.resonance;
    nonlinear =>  lpfl.nonlinear => lpfr.nonlinear;
    nlp_type => lpfl.nlp_type =>  lpfr.nlp_type;

    
    tone.left() => lpfl;
    tone.right() => lpfr;
    
  }


}
