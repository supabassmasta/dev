2/2 => float fact;

adc => Delay d0 => Gain out;
fact * data.tick - 186::ms * 2 => d0.max => d0.delay;
.7 => d0.gain;
d0 => Delay d1 => out;
fact * data.tick  => d1.max => d1.delay;
.7 => d1.gain;
d1 => Gain fb => d1;

out => dac;

while(1) {
       100::ms => now;
}
 

