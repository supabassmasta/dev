public class NOISE1 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.15 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		1.8 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

