SinOsc s => Wavetable w => dac;
400 => s.gain;
.2 =>s.freq;

.01 => w.gain;

1000 => w.freq;
[-1.0,1] @=> float myTable[];
w.setTable(myTable);

while(1) {
	     100::ms => now;
}
 
