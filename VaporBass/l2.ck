class synt0 extends SYNT{

		inlet => SqrOsc s => LPF lpf =>  outlet;		
				.07 => s.gain;

				1000 => lpf.freq;
	
		.2 => s.width;
		TriOsc m => s;
		7 => m.freq;
		22 => m.gain;

		TriOsc m2 => m;
	1::second/data.tick => m2.freq;
		29 => m2.gain;

		Step st => m;
		9 => st.next;

//		m => m2;




						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

class synt1 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

FREQ_STR f0; //8 => f0.max;
2=> f0.sync;
//"*2 0303 1414 6262 5151" =>     f0.seq;     
"  ___0___6 " =>     f0.seq;     
f0.reg(synt0 s0);
f0.post() =>  DUCK duck => dac;
duck.set(10::ms, 61::ms, 0.2 , 10::ms);
DUCK_MASTER.auto();
while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
