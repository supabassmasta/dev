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


		CONTROLER  keys[121];
		CONTROLER  controls[112];


		0 => int last_key;
		0 => int last_control;


    fun void start_midi_rcv() {
				int color;
        while( true )
        {
            min => now;

            while( min.recv(msg) )
            {
                                <<< msg.data1, msg.data2, msg.data3 >>>;


                if (msg.data1 == 144){
                        keys[msg.data2].set(msg.data3); 
//                        if (msg.data2 != 8 &&msg.data2 != 24 &&msg.data2 != 40 &&msg.data2 != 56 &&msg.data2 != 72 &&msg.data2 != 88 &&msg.data2 != 104 && msg.data2 != 120 ) 
                            msg.data2=> last_key;
                }
                else {
                        controls[msg.data2].set(msg.data3);
                        msg.data2=> last_control;
                }
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
