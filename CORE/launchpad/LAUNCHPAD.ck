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

// Dummy key to avoid null pointer exception when not connected
		class dummy extends LAUNCHPAD_KEY {
				fun int on() {
						<<<"Dummy not affected">>>; 
						return 2; //red
				}
			} 

		for (0 => int i; i < keys.size()      ; i++) { new dummy @=> keys[i];	}
		for (0 => int i; i < controls.size()      ; i++) { new dummy @=> controls[i];	}
		 


		0 => int last_key;
		0 => int last_control;


    fun void start_midi_rcv() {
				int color;
        while( true )
        {
            min => now;

            while( min.recv(msg) )
            {
                //                <<< msg.data1, msg.data2, msg.data3 >>>;


                if (msg.data1 == 144)
                    if (msg.data3 == 0)
                        keys[msg.data2].off() => color; 
                    else {
                        keys[msg.data2].on() => color;
                        if (msg.data2 != 8 &&msg.data2 != 24 &&msg.data2 != 40 &&msg.data2 != 56 &&msg.data2 != 72 &&msg.data2 != 88 &&msg.data2 != 104 && msg.data2 != 120 ) 
                            msg.data2=> last_key;
                    }
                else
                    if (msg.data3 == 0)
                        controls[msg.data2].off() => color;
                    else {
                        controls[msg.data2].on() => color;
                        msg.data2=> last_control;
                    }

                set_color(msg.data1,msg.data2, color );
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

		fun void set_color(int channel, int note, int color ){
			MidiMsg msg;

			channel => msg.data1;
		  note => msg.data2;
			color => msg.data3;
			mout.send(msg);
		}

		fun void red(int note){
				set_color(144, note, 2);
		}

		fun void green(int note){
				set_color(144, note, 32);
		}

		fun void amber(int note){
				set_color(144, note, 34);
		}

		fun void clear(int note){
				set_color(144, note, 0);
		}

		fun void redc(int note){
				set_color(176, note, 2);
		}

		fun void greenc(int note){
				set_color(176, note, 32);
		}

		fun void amberc(int note){
				set_color(176, note, 34);
		}

		fun void clearc(int note){
				set_color(176, note, 0);
		}



	  fun void start () {	
	    spork ~ start_midi_rcv() ;
    }

		reset();

}
