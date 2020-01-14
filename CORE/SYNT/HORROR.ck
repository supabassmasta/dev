public class HORROR extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;
		
		TriOsc m => s;
		5 => m.freq;
		17 => m.gain;

		TriOsc m2 => m;
	3 => m2.freq;
		9 => m2.gain;

		Step st => m;
		5 => st.next;

		m => m2;




						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}
