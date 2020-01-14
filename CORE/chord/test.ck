Step s;
440=>s.next;

s=> SinOsc si => dac;

si.gain(0.3);

while(1) {0.5::ms => now; <<< si.last() >>>;}
