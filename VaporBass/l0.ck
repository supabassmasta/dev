class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"030 4/1" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post() => DUCK duck => dac;
f0.post()  => dac;DUCK duck;
duck.set(10::ms, 100::ms, 0.1 , 10::ms);
DUCK_MASTER.auto();
while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
