1 => float fact;

adc => Delay d0 => Gain out;
fact * data.tick - 186::ms * 2 => d0.max => d0.delay;
.6 => d0.gain;
d0 => Delay d1 => out;
d1 => Delay d2 => out;
fact * data.tick  => d1.max => d1.delay;
.4 => d1.gain;
fact * data.tick  => d2.max => d2.delay;
.35 => d2.gain;
d2 => Gain fb => d2;

out => dac;

while(1) {
       100::ms => now;
}
 

