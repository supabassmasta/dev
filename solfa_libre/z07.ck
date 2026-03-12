class tick_adjust {

	// ------------ LATENCY --------------
		186::ms => dur latency;
    48::ms => dur jitter_mean; 
		[4 , 8, 8, 16, 24, 32] @=> int refresh_rate[];
    0=> int refresh_index;

		time ref, next, guard_time;
		0 => int started;
	  0::ms => dur delta_mean;
		0 => int cnt;

    time ref_sync;


		fun void midi_ev(int in) {
        // in == 1 : Bar (4 beat) start
        // other : other beats
					now => time midi_time;

//				if (!started) {

						// DO NOTHING

					// TODO compute early delta_mean
//				}

        if (started && midi_time > guard_time) {
					next  - (midi_time - latency - jitter_mean) => dur delta;

					delta * (1. / (refresh_rate[refresh_index] $ float) )  + delta_mean *(1.- ( 1. / (refresh_rate[refresh_index] $ float ))) => delta_mean;

					cnt + 1 => cnt;

					if (cnt == refresh_rate[refresh_index]){
						next - delta_mean => ref => next;
						MASTER_SEQ3.offset_ref_times(-1. * delta_mean );
						<<<"UPDATE offset_ref_times delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;
						0::ms => delta_mean;
						0=> cnt;
						if (refresh_index < refresh_rate.size() - 1){
							refresh_index + 1 => refresh_index;
						}
					}

					next + data.tick => next;
        }
		}

		fun void synchro_ev(int in) {
				if (!started) {
					now => ref_sync;
					// compute guard time to avoid double sync with other midi channel
					ref_sync + data.tick/2 => guard_time;
					// adjust it with latency and delta_mean already measured
					ref_sync - latency - jitter_mean - delta_mean => ref_sync;
					// compute next
          ref_sync + data.tick => next;

					// adjust to the begining of the song
					ref_sync - in * 16 * data.tick => ref_sync;


					MASTER_SEQ3.update_ref_times(ref_sync, data.tick * 16 * 128 );
					<<<"UPDATE midi counter: ", in, "ref_sync ", ref_sync, " delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;

					
					0 => refresh_index;
					0::ms => delta_mean;

					1=> started;
				}
				else {
				  	<<<"midi counter: ", in	>>>;  
				}



    }


}

"Scarlett 2i4 USB MIDI 1" => string device;
MidiIn min;
MidiMsg msg;
// open the device
for(0 =>  int i; i < 8; i++ )
{
		// open the device
		if( min.open( i ) )
		{
				if ( min.name() == device ) {
				<<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;


				break;
				}
				else {
//					min.close();
				}

	 }
		else {
				<<<"Cannot open", device>>>; 	
			break;
		}
}

<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

tick_adjust ta;

while( true )
{
	min => now;

	while( min.recv(msg) )
	{
		<<< msg.data1, msg.data2, msg.data3 >>>;
		if (msg.data1 == 144 && msg.data2 == 36 && msg.data3 == 100 ){
      // first beat of for
      ta.midi_ev(1);
    }
    else if (msg.data1 == 144 && msg.data2 == 24 && msg.data3 == 100 ) {
      // other beat
      ta.midi_ev(0);
    }
    else if (msg.data1 == 145 &&  msg.data3 == 100 ) {
      ta.synchro_ev( msg.data2 );
    }

	}
}


 


