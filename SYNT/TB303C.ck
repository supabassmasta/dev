public class TB303C extends SYNT{

		inlet =>  LPF sli  => SqrOsc s => LPF f => LPF f2 =>  outlet;		
				.4 => s.gain;
				400 => float fr;
				fr => f.freq;
				fr => f2.freq;

				35 => sli.freq;


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

				fun void control (){ 
						
						while(1) {
								LPD8.k(2,1) *31 =>  st.next;
								LPD8.k(2,2) / 32. + 1. =>f.Q => f2.Q;
								LPD8.k(2,3) /256. => s.width;
								LPD8.k(2,4)  *31  => st2.next;
								100::ms => now;
						}
						 
					 } 
					 spork ~  control ();
					  

					  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {a.keyOn();		}
}

