1 => float fact;

adc => Delay d0 => Gain out;
fact * data.tick - 186::ms * 2 => d0.max => d0.delay;
.6 => d0.gain;
d0 => Delay d1 => out;
fact * data.tick  => d1.max => d1.delay;
.6 => d1.gain;
d1 => Gain fb => d1;

out => /* BRF brf => */ /* LPF lpf=> */ dac;

//3500 => brf.freq;
//1.=> brf.Q;

//3000 => lpf.freq;
//1.=> lpf.Q;

while(1) {
       100::ms => now;
}
 

