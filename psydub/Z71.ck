SawOsc s => dac;
.2 => s.gain;
1000::ms/20::ms =>s.freq;

SawOsc s2 => dac;
.2 => s2.gain;
1000::ms/20::ms =>s2.freq;

