class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


lpk25 l;
GLIDE synta; 20::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0); 

while(1) {
	     100::ms => now;
}
 
