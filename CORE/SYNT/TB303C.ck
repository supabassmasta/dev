public class TB303C extends SYNT{

    1 =>  own_adsr;
		inlet =>  LPF sli  => SqrOsc s => LPF f => LPF f2 => PowerADSR padsr => outlet;		
    padsr.set(1::ms, 20::ms, 1. , 2::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

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


        // 2nd Osc
        inlet => Gain gaintri => TriOsc tri => f;
        2. => gaintri.gain;



				fun void f1 (){ 
						while(1) {
				outa.last() => float fr;
				fr => f.freq;
				fr => f2.freq;
								

							     1::samp => now;
						}
						 
					 } 
					 spork ~ f1 ();

				fun void control (){ 
						
						while(1) {
                
								LPD8.k(2,1)/127.  =>  padsr.gain;
								LPD8.k(2,2)  *31 + 40 => st2.next;
								LPD8.k(2,3) *31 =>  st.next;
								LPD8.k(2,3) / 32. + 1. =>f.Q => f2.Q;
								LPD8.k(2,5) /256. => s.width;
								LPD8.k(2,6) /256. => tri.gain;
								LPD8.k(2,7) /256. => tri.width;

								100::ms => now;
						}
						 
					 } 
					 spork ~  control ();
					  
<<<"_______ TB303C ________ 
___ LPD8:                        ___ 
___ Pot 2.1  Gain                ___ 
___     2.2  lpf freq base       ___ 
___     2.3  lpf freq variable   ___ 
___     2.4  lpf Q               ___ 
___     2.5  SqrOsc width        ___ 
___     2.6  2*tone TriOsc gain  ___ 
___     2.7  2*tone TriOsc width ___ 
___     2.8                      ___ 
_______ TB303C ________">>>; 
					  

						fun void on()  {padsr.keyOn(); }	fun void off() {padsr.keyOff(); }	fun void new_note(int idx)  {a.keyOn();		}
}



