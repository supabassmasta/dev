class tick_adjust {

	// ------------ LATENCY --------------
//		186::ms => dur latency;
//    48::ms => dur jitter_mean; 
		0::ms => dur latency;
    8::ms => dur jitter_mean; 
		[4 , 8, 8, 12, 16, 16, 32] @=> int refresh_rate[];
    0=> int refresh_index;

		time ref, next;
		0 => int started;
	  0::ms => dur delta_mean;
		0 => int cnt;


		fun void midi_ev(int in) {
        // in == 1 : Bar (4 beat) start
        // other : other beats
        <<<"CNT", cnt>>>; 

				if (!started) {
          if (in == 1 || in == 2) {
            now => ref;
            ref - latency - jitter_mean => ref => next;

            if (in == 2 ){
              MASTER_SEQ3.update_ref_times(ref, data.tick * 32 );
              <<<"UPDATE 1st ref 32">>>;
            }else {
              MASTER_SEQ3.update_ref_times(ref, data.tick * 4 );
              <<<"UPDATE 1st ref 4">>>;
            }
            1=> started;
            -1 => cnt;
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
            if (in == 2 ){
              MASTER_SEQ3.update_ref_times(ref, data.tick * 32 );
              <<<"UPDATE ref 32">>>;
            }else {
              MASTER_SEQ3.update_ref_times(ref, data.tick * 4 );
              <<<"UPDATE ref 4">>>;
            }
            <<<"UPDATE delta_mean: ", delta_mean/1::ms ," refresh rate: ", refresh_rate[refresh_index] >>>;
            0::ms => delta_mean;
            0=> cnt;
            if (refresh_index < refresh_rate.size() - 1){
              refresh_index + 1 => refresh_index;
            }
          }
          else if (in == 2 && cnt%32 != 0) {
            <<<"DESYNC on 32 beat alignement">>>;
            0 => refresh_index;
            0 => cnt;
          }
          else if (in == 1 && cnt%4 != 0) {
            <<<"DESYNC on 4 beat alignement">>>;
            0 => refresh_index;
            0 => cnt;
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
		if (msg.data1 == 0x90 && msg.data2 == 63  && msg.data3 == 0x7F ){
      // first beat of 32
      ta.midi_ev(2);
    }
		else if (msg.data1 == 0x90 && msg.data2 == 64  && msg.data3 == 0x7F ){
      // first beat of four
      ta.midi_ev(1);
    }
    else if (msg.data1 == 144 && msg.data2 == 65  && msg.data3 == 0x7F ) {
      // other beat
      ta.midi_ev(0);
    }

	}
}


 


