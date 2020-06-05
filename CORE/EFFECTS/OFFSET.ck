public class OFFSET extends Chubgraph{
  inlet => Gain add => outlet;
  Step s => add ;

  1. => s.next;

  fun void offset(float in) {
    in => s.next;
  }

//  fun void gain (float in) {
//    in => add.gain;
//  }
}

