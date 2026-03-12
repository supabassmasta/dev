class tick_adjust {

	// ------------ LATENCY --------------
		196::ms => dur latency;
    48::ms => dur jitter_mean; 
		[5 , 8, 16, 24, 32] @=> int refresh_rate[];
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
//					delta * 0.05 + delta_mean * 0.95 => delta_mean;

					delta * (1. / (refresh_rate[refresh_index] $ float) )  + delta_mean *(1.- ( 1. / (refresh_rate[refresh_index] $ float ))) => delta_mean;

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

	}
}


 


