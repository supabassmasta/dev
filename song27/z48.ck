MGAINC mgainc0; mgainc0.config( HW.lpd8.potar[1][1] /* gain */, 1.0 /* Static gain */ ); 
SinOsc sin0 =>  mgainc0 =>   dac;
440 => sin0.freq;
0.2 => sin0.gain;

while(1) {
       100::ms => now;
}
 
