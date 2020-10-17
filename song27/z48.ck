MGAINC2 mgain2c0; mgain2c0.config( HW.lpd8.potar[1][1] /* gain */, 1.0 /* Static gain */ , 50::ms /* ramp dur */ ); 
SinOsc sin0 => mgain2c0 =>   dac;
440 => sin0.freq;
0.2 => sin0.gain;

while(1) {
       100::ms => now;
}
 
