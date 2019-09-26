SawOsc s => LPF f => dac;

300 => f.freq;

.1 => s.gain;


while(1) {
0 => s.gain;       100::ms => now;
1 * 200 =>s.freq; 0.1 => s.gain;       100::ms => now;
0 => s.gain;       100::ms => now;
3 * 200 =>s.freq; 0.1 => s.gain;       100::ms => now;
0 => s.gain;       100::ms => now;
2 * 200 =>s.freq; 0.1 => s.gain;       100::ms => now;
0 => s.gain;       100::ms => now;
5 * 200 =>s.freq; 0.1 => s.gain;       100::ms => now;
}
 
