class OFFSET extends Chubgraph{
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


SinOsc mod => OFFSET o => SinOsc s => dac;

305 => o.gain;
1.4 => o.offset;
10.8 => mod.freq;


.1 => s.gain;

while(1) {
       100::ms => now;
}
 

