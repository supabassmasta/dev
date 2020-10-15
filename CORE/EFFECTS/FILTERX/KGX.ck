public class KGX extends FILTERX {
  inlet => WPKorg35 f => outlet;
  
  1     => f.resonance;
  true  => f.nonlinear;
  
  fun void freq(float i) {f.cutoff(i);}
  fun void Q(float i) {f.resonance(i);}

  10 =>  min;
  19000 =>  max;

}
