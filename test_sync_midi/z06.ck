class tick_adjust {

	// ------------ LATENCY --------------
		240::ms => dur latency;
		20 => int refresh_rate;

		time ref, next;
		0 => int started;
	  0::ms => dur delta_mean;
		0 => int cnt;


		fun void midi_ev() {
				if (!started) {
						now => ref;
						ref - latency => ref => next;
						1=> started;
				}
				else {
					now => time midi_time;
					next  - (midi_time - latency) => dur delta;
//					midi_time- next + latency  => dur delta;

					// ------------ MEAN ---------------
					delta * 0.05 + delta_mean * 0.95 => delta_mean;

				}
				cnt + 1 => cnt;

				if (cnt == refresh_rate){
						next - delta_mean => ref => next;
						MASTER_SEQ3.update_ref_times(ref - 48::ms, data.tick * 4 );
						<<<"UPDATE delta_mean: ", delta_mean/1::ms>>>;
						0::ms => delta_mean;
						0=> cnt;
				}
				
				next + data.tick => next;

		}


}


// FAKE TEST
tick_adjust ta;

SinOsc s => PowerADSR padsr => dac;
padsr.set(1::ms, 20::ms, .0000000000007 , 20::ms);
padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 

600 => s.freq;
.4 => s.gain;
0 => int t_ready;

fun void f2 (){ 
	  ta.latency => now;
		ta.midi_ev();	
	 } 
	  

fun void f1 (){ 
	     14::ms => now;
while(1) {
	     4096::samp => now;
			 if (t_ready){
					 spork ~ f2 ();
					0 => t_ready;
			 }
}
 

	 } 
	 spork ~ f1 ();
	  


104::ms => now;

while(1) {
		// real tick
	     data.tick => now;
			 1 => t_ready;
			 padsr.keyOn(); 	

}
 


