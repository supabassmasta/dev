TriOsc s => Gain add;
.9 => s.gain;
1000::ms/20::ms =>s.freq;
0. => s.width;

TriOsc s2 => add;
-.3 => s2.gain;
1000::ms/20::ms =>s2.freq;
0.4 => s2.width;
SinOsc s3 => add;
-.2 => s3.gain;

Step st => add;
.8 => st.next;

2000 => add.gain;

add => SinOsc si => dac;
//add => dac;
.01 => si.gain;

while(1) {
	     100::ms => now;
}
 
