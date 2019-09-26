SinOsc s => dac;

while(1) {
 

660 => s.freq; .3 => s.gain; 100::ms => now;
.0 => s.gain; 100::ms => now;
2*660 => s.freq; .3 => s.gain; 100::ms => now;
.0 => s.gain; 100::ms => now;
1*660 => s.freq; .3 => s.gain; 100::ms => now;
.0 => s.gain; 100::ms => now;
3*660 => s.freq; .3 => s.gain; 100::ms => now;
.0 => s.gain; 100::ms => now;
1*660 => s.freq; .3 => s.gain; 100::ms => now;
.0 => s.gain; 100::ms => now;

}
