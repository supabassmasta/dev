class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"PHR" => f0.scale;
"*2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
">5 *2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
"*2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
">5 *2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     

"*2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
">7 *2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
">2 *2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
">7 *2 CBA0 0_4_ 1_5_ 2_0_" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
