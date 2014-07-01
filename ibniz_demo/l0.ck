Phasor p=> SinOsc s => dac;
800 => p.gain;

while(1) {

	     500::ms => now;
//			 440 => s.freq;
			 2 => p.freq;
	     500::ms => now;
			 4 => p.freq;
//			 660 => s.freq;
}
 
