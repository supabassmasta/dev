class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;

"DOR" => f0.set_scale;
"0123456" =>     f0.seq;     
f0.reg(synt0 s0);

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
