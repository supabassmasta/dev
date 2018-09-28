public class STMULT_BASE_ZERO extends ST {

  Step stepl => Gain inl => Gain multl => outl;
  Step stepr => Gain inr => Gain multr => outr;
  0. => stepl.next;
  0. => stepr.next;
  3 => multl.op;
  3 => multr.op;
  
  fun void connect(ST @ source, ST @ mod){
    source.left() => multl;
    source.right() => multr;

    mod.left() => inl;
    mod.right() => inr;

  }
}

