public class lpk25 {

	"LPK25 MIDI 1" => string device;

	MidiIn min;
	MidiMsg msg;
	MidiOut mout;	

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

				if(mout.open(i)) {
					<<< "device", i, "->", min.name(), "->", "open as output: SUCCESS" >>>;
				}
				else {
					<<<"Fail to open lpk25 as output">>>; 

				}

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
		

	fun void midi_clock (){ 
			MidiMsg msg;

			0xF8 => msg.data1;
			0xF8 => msg.data2;
			0xF8 => msg.data3;
		while(1) {
			mout.send(msg);
			     data.tick / 4 / 24 => now;
		}
		 
	} 
	spork ~ midi_clock ();
		  
	
	}



/*
	mpk25 m;
m.reg(GLIDE g);
  


	while(1) {
		     100::ms => now;
	}
	*/
