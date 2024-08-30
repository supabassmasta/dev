
SinOsc sin0 =>  Range r => Gain g => dac;
440.0 => sin0.freq;
.3 => g.gain;

// Activate cliping
1 => r.clip;
r.range(-1, 1, -1, 0);
2 => sin0.gain;



while(1) {
       100::ms => now;
}
 

