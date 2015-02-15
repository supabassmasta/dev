public class LAUNCHPAD {
		"Launchpad S MIDI 1" => string device;
    MidiIn min;
    MidiMsg msg;
		MidiOut mout;	

		// open the device
		for(0 =>  int i; i < 8; i++ )
		{
				// no print err
		//    min.printerr( 0 );

				// open the device
				if( min.open( i ) )
				{
						if ( min.name() == device ) {
						<<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

					  if(mout.open(i)) {
							<<< "device", i, "->", min.name(), "->", "open as output: SUCCESS" >>>;
						}
						else {
								<<<"Fail to open launchpad as output">>>; 
						}

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


		LAUNCHPAD_KEY @ keys[121];
		LAUNCHPAD_KEY @ controls[112];




    fun void start_midi_rcv() {

        while( true )
        {
            min => now;

            while( min.recv(msg) )
            {
                <<< msg.data1, msg.data2, msg.data3 >>>;

               /* 
                if (msg.data1 == 144)
									if (msg.data3 == 0)
                    keys[msg.data2].off();
								  else
                    keys[msg.data2].on();
                else
									if (msg.data3 == 0)
                    controls[msg.data2].off();
								  else
                    controls[msg.data2].on();
                */
                
            }
        }
    }

		fun void reset(){
			MidiMsg msg;

			176 => msg.data1;
			0 => msg.data2;
			0 => msg.data3;
			mout.send(msg);
		}


		reset();

    spork ~ start_midi_rcv() ;
    


}
