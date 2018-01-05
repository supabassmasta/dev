public class NOISE2 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.3 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		2.3 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

