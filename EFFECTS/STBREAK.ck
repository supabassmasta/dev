public class STBREAK extends ST{
    Break bl => outl;
    Break br => outr;

  fun void connect(ST @ tone, int break_number) {
    bl.register(break_number * 2);
    br.register(break_number * 2 + 1);

    tone.left() => bl;
    tone.right() => br;
  }

}
