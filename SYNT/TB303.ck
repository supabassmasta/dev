public class TB303 extends SYNT{

		inlet => SqrOsc s => LPF f => LPF f2 =>  outlet;		
				.7 => s.gain;
				400 => float fr;
				fr => f.freq;
				fr => f2.freq;

				// Q
				 1.7 => float q;
				 q => f.Q;
				 q => f2.Q;


				Step st => ADSR a => Gain outa => blackhole;
				Step st2 => outa;
				// Limit low freq
				200. => st2.next;
				// Max freq
				1500. => st.next;
		
				// Decay time
				a.set(0::ms, 60::ms, 0.0001, 0::ms);




				fun void f1 (){ 
						while(1) {
				outa.last() => float fr;
				fr => f.freq;
				fr => f2.freq;
								

							     10::samp => now;
						}
						 
					 } 
					 spork ~ f1 ();
					  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {a.keyOn();		}
}
