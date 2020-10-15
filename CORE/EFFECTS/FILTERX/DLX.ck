public class DLX extends FILTERX {
  inlet => WPDiodeLadder f => outlet;
  
  1     => f.resonance;
  true  => f.nonlinear;
  false  => f.nlp_type;
  
  fun void freq(float i) {f.cutoff(i);}
  fun void Q(float i) {f.resonance(i);}

  10 =>  min;
  19000 =>  max;

}
