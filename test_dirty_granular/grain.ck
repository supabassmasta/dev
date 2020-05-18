SqrOsc s => ADSR a => LPF lpf => dac;
.02 => s.width;
2000 => lpf.freq;
a.set(3::ms , 0::ms, 1. , 5::ms);
.004 => s.gain;
4 * 220 + Std.rand2f(-50, 50) => s.freq;

a.keyOn();

  Std.rand2f(1, 5) * 1::ms =>now;

a.keyOff();
5::ms => now;
