public class STBPF extends ST{
  BPF bpfl => outl;
  BPF bpfr => outr;

  1000 => bpfl.freq;
  1000 => bpfr.freq;
  1 => bpfl.Q;
  1 => bpfr.Q;



  fun void connect(ST @ tone, float f, float q) {

    f => bpfl.freq => bpfr.freq;
    q => bpfl.Q => bpfr.Q;

    tone.left() => bpfl;
    tone.right() => bpfr;

  }


}
