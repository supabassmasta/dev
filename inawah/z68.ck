2/2 => float fact;

adc => Gain in => Delay d0  => Gain out;
2.2 => in.gain;
fact * data.tick - 186::ms * 2 => d0.max => d0.delay;
.5 => d0.gain;
d0 => Delay d1 => out;
fact * data.tick  => d1.max => d1.delay;
.5 => d1.gain;
d1 => Gain fb => d1;

out => dac;

//out => BRF brf => /* LPF lpf=> */ dac;

//3500 => brf.freq;
//1.=> brf.Q;

//3000 => lpf.freq;
//1.=> lpf.Q;

while(1) {
       100::ms => now;
}
 

