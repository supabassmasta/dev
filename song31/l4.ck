SinOsc sin0 =>  dac;
440.0 => sin0.freq;
0.03 => sin0.gain;


while(1) {
sin0 =<  dac;
       100::ms => now;
sin0 =>  dac;
       100::ms => now;
}
 

