class tick_adjust {

	// ------------ LATENCY --------------
		240::ms => dur latency;
    48::ms => dur jitter_mean; 
		[5 , 8, 16, 24] @=> int refresh_rate[];
    0=> int refresh_index;

		time ref, next;
		0 => int started;
	  0::ms => dur delta_mean;
		0 => int cnt;


		fun void midi_ev(int in) {
        // in == 1 : Bar (4 beat) start
        // other : other beats

				if (!started) {
          if (in == 1) {
            now => ref;
            ref - latency - jitter_mean => ref => next;
            MASTER_SEQ3.update_ref_times(ref, data.tick * 4 );
            <<<"UPDATE 1st ref">>>;
            1=> started;
          }

				}
				else {
					now => time midi_time;
					next  - (midi_time - latency - jitter_mean) => dur delta;
//					midi_time- next + latency  => dur delta;

					// ------------ MEAN ---------------
					delta * 0.05 + delta_mean * 0.95 => delta_mean;

				}

        if (started) {
          cnt + 1 => cnt;

          if (cnt == refresh_rate[refresh_index]){
            next - delta_mean => ref => next;
            MASTER_SEQ3.update_ref_times(ref, data.tick * 4 );
            <<<"UPDATE delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;
            0::ms => delta_mean;
            0=> cnt;
            if (refresh_index < refresh_rate.size() - 1){
              refresh_index + 1 => refresh_index;
            }
          }

          next + data.tick => next;
        }
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
1 => int bcnt;

fun void f2 (){ 
	  ta.latency => now;
    if (bcnt == 0) {
		  ta.midi_ev(1);	
    }
    else {
		  ta.midi_ev(0);	
    }
    (bcnt + 1) % 4 => bcnt;
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
       if (bcnt == 0) {
         800 => s.freq;
       }
       else {
         600 => s.freq;
       }
			 padsr.keyOn(); 	

}
 


