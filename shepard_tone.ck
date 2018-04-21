81::ms => dur period;
20000::ms => dur total;

fun void f1 (){ 
LPF lpf;
	Step s => /*lpf =>*/ SinOsc sin => PowerADSR padsr=>  dac;
	13 => lpf.freq;
	.5 => lpf.gain;
	padsr.set(10 *period, 20::ms, 1.0 , 172 * period);
	padsr.setCurves(1, 1, 1); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
  padsr.keyOn();

	Step s2 => ADSR a => blackhole;
	137 => s2.next;
	a.set(total, 3::ms, 0.0000001, 10::ms);
	a.keyOn();

 now + total => time end;

while(now < end) {
 
		Std.mtof(a.last()) => s.next;

		if (now > end - 1000::ms  ){
		 	 padsr.keyOff(); 
		}

		1::samp => now;
	}
	
 	 padsr.keyOff(); 
 
} 
	  


		while(1) {
						spork ~ f1 ();
			     total / 11 => now;
		}


