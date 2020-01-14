public class STLPF extends ST{
  LPF lpfl => outl;
  LPF lpfr => outr;

  1000 => lpfl.freq;
  1000 => lpfr.freq;
  1 => lpfl.Q;
  1 => lpfr.Q;


  fun void connect(ST @ tone, float f, float q) {
    
    f => lpfl.freq => lpfr.freq;
    q =>  lpfl.Q => lpfr.Q;
    
    tone.left() => lpfl;
    tone.right() => lpfr;
    
  }


}
