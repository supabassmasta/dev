class tick_adjust {

	// ------------ LATENCY --------------
		186::ms => dur latency;
    48::ms => dur jitter_mean; 
		[4 , 16] @=> int refresh_rate[];
    0=> int refresh_index;

		time ref, next;
		0 => int started;
	  0::ms => dur delta_mean;
		0 => int cnt;

    0 => int first_sync_received;
    time ref_sync;


		fun void midi_ev(int in) {
        // in == 1 : Bar (4 beat) start
        // other : other beats

				if (!started) {
            now => ref;
            ref - latency - jitter_mean => ref => next;
            <<<"UPDATE 1st beat ref ">>>;
            1=> started;

				}
				else {
					now => time midi_time;
					next  - (midi_time - latency - jitter_mean) => dur delta;

					delta * (1. / (refresh_rate[refresh_index] $ float) )  + delta_mean *(1.- ( 1. / (refresh_rate[refresh_index] $ float ))) => delta_mean;

				}

        if (started) {
          cnt + 1 => cnt;

//          if (cnt == refresh_rate[refresh_index]){
//            next - delta_mean => ref => next;
//            MASTER_SEQ3.update_ref_times(ref, data.tick * 4 );
////            <<<"UPDATE delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;
//            0::ms => delta_mean;
//            0=> cnt;
//            if (refresh_index < refresh_rate.size() - 1){
//              refresh_index + 1 => refresh_index;
//            }
//          }

          next + data.tick => next;
        }
		}

		fun void synchro_ev(int in) {

        now => ref_sync;
        // adjust it with latency and delta_mean already measured
        ref_sync - latency - jitter_mean - delta_mean => ref_sync;
        // adjust to the begining of the song
        ref_sync - in * 16 * data.tick => ref_sync;

        MASTER_SEQ3.update_ref_times(ref_sync, data.tick * 16 * 128 );
        <<<"UPDATE midi counter: ", in, " delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;

        1 => refresh_index;
        0::ms => delta_mean;

        1 => first_sync_received;

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
0 => int tick_cnt;


fun void f2 (){ 
	  ta.latency => now;
    // radom latency
//    Std.rand2( 1, 10 ) * 1::ms => now;

    if (bcnt == 0) {
		  ta.midi_ev(1);	
    }
    else {
		  ta.midi_ev(0);	
    }
    (bcnt + 1) % 4 => bcnt;
    tick_cnt + 1 => tick_cnt;

    if ((tick_cnt % 16) == 0 ) {
       ta.synchro_ev(tick_cnt/16);
    }
} 
	  

fun void f1 (){ 
//  14::ms => now;
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
 

 


