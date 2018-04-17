class tick_adjust {

	// ------------ LATENCY --------------
		196::ms => dur latency;
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
        <<<"UPDATE delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;

        1 => refresh_index;
        0::ms => delta_mean;

        1 => first_sync_received;

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


 


