SinOsc sin0 => Gain g0 => Gain g1 => dac;
0.3 => g1.gain;
// 3 => g0.op; //1+ 2- 3* 4/ 0 off -1 passthrough

1.0 => g0.gain;
 -1 => g0.op; //1+ 2- 3* 4/ 0 off -1 passthrough

SinOsc sin1 => g0; 
100.0 => sin1.freq;
1.0 => sin1.gain;

66.0 => sin0.freq;
1.0 => sin0.gain;

while(1) {
       100::ms => now;
}
 
