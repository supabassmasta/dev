public class STLPFN extends ST{
  fun void connect(ST @ tone,float f, float q, int o) {
    STLPF @ lpf;
    tone @=> ST @ last;
    for (0 => int i; i <  o; i++) {
        new STLPF @=> lpf;
        lpf.connect(last, f, q);
        lpf @=> last;
    }

    last.left() => outl;
    last.right() => outr;
  }
}

