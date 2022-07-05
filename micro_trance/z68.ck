1 => float fact;

adc => Delay d0 => Gain out;
fact * data.tick - 186::ms * 2 => d0.max => d0.delay;
.55 => d0.gain;
d0 => Delay d1 => out;
fact * data.tick  => d1.max => d1.delay;
.55 => d1.gain;
d1 => Gain fb => d1;

MGAINC mgainc0; mgainc0.config( HW.lpd8.potar[1][4] /* gain */, 1.0 /* Static gain */ ); 
out  => mgainc0 =>  dac;  

while(1) {
       100::ms => now;
}
 

