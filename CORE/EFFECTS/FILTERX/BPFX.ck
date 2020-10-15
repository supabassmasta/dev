public class BPFX extends FILTERX {
  inlet => BPF f => outlet;
  
  fun void freq(float i) {f.freq(i);}
  fun void Q(float i) {f.Q(i);}

  10 =>  min;
  19000 =>  max;

}
