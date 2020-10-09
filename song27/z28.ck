class F extends Chubgraph {
inlet => LPF f => outlet;
59*10 => f.freq;
}

LPF_XFACTORY f;
f.create() @=> UGen @ u;

(u $ LPFX).freq(300);

SqrOsc sqr0 => u => dac;  
237.0 => sqr0.freq;
0.1 => sqr0.gain;
0.5 => sqr0.width;

while(1) {
       100::ms => now;
}
 
