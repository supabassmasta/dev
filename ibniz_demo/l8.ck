Phasor p => SinOsc s => dac;
1. => p.freq;
1000 => p.gain;

.3 => s.gain;
while(1) {
//			 660 => s.freq;
//	     100::ms => now;
//			 440 => s.freq;
//	     100::ms => now;
//	     100::ms => now;
2. => p.freq;
1000::ms => now;
4. => p.freq;
1000::ms => now;


}
 
