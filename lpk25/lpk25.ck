public class lpk25 {

	"LPK25 MIDI 1" => string device;

	MidiIn min;
	MidiMsg msg;

  SYNTA synta[0];

	for(0 =>  int i; i < 8; i++ )
	{
		// no print err
		//    min.printerr( 0 );

		// open the device
		if( min.open( i ) )
		{
			if ( min.name() == device ) {
				<<< "device", i, "->", min.name(), "->", "open: SUCCESS" >>>;
				break;
			}
			else {
				//					min.close();
			}

		}
		else break;
	}

	<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

	fun void start_midi_rcv() {

		while( true )
		{
			min => now;

			while( min.recv(msg) )
			{
				<<< msg.data1, msg.data2, msg.data3 >>>;

				for (0 => int i; i < synta.size()      ; i++) {
					synta[i].in(msg);
				}
				 
			}

		}
	}
	spork ~ start_midi_rcv() ;
 		
	fun void reg(SYNTA @ s) {
		synta << s;
	}
		
	
	}



/*
	mpk25 m;
m.reg(GLIDE g);
  


	while(1) {
		     100::ms => now;
	}
	*/
