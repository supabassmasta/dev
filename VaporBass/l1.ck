class synt0 extends SYNT{

	inlet => SinOsc s =>  outlet;	
	.5 => s.gain;

	fun void on()  { } 	fun void off() { } 	fun void new_note(int idx)  {	}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
		

