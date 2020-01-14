public class STMULT_BASE_ONE extends ST {

  Step stepl => Gain inl => Gain multl => outl;
  Step stepr => Gain inr => Gain multr => outr;
  1. => stepl.next;
  1. => stepr.next;
  3 => multl.op;
  3 => multr.op;
  
  fun void connect(ST @ source, ST @ mod){
    source.left() => multl;
    source.right() => multr;

    mod.left() => inl;
    mod.right() => inr;

  }
}

