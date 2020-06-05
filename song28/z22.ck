class MULT extends Chubgraph {
  inlet => outlet;
  3 => inlet.op;
}

SinOsc mod => OFFSET o => SinOsc s => MULT m => dac;

305 => o.gain;
1.4 => o.offset;
10.8 => mod.freq;

.1 => s.gain;

STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
stepc.out => m; 


while(1) {
       100::ms => now;
}
 

