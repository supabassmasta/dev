class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; 8 => f0.max; 2=> f0.sync;
"<c 0_0__ *25/1010101" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
				 
