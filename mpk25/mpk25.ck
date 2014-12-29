class SYNTA {
	fun void in(	MidiMsg msg){}
	
	}


class mpk25 {

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

class GLIDE extends SYNTA {

		20::ms => dur duration;

		Step one => Envelope e => SinOsc s => ADSR adsr => dac;
		1. => one.next;
		300::ms => dur release;
		adsr.set(3::ms, 30::ms, .7, release);
		
		0 => int last_note;
		0 => int note_on;
		
		fun void in (	MidiMsg msg ) {
				//                 msg.data1  => group_no_;
				//                msg.data2 => pad_nb_;
				//                msg.data3 => val_;


		if (msg.data1 == 144){
				note_on ++;
				if(last_note == 0)
				{
				  Std.mtof (msg.data2) => e.value;

					msg.data3 / 256. + .2 => adsr.sustainLevel;
					adsr.keyOn();

				  msg.data2 => last_note;
				
				}
				else {
						Std.mtof (msg.data2) => e.target;
						duration => e.duration;
					msg.data3 / 256. + .2 => adsr.sustainLevel;
	//					msg.data3 / 127. => adsr.gain;

msg.data2 => last_note;
				
					adsr.keyOn();
				}

		}
		else if (msg.data1 == 128){
			  note_on --;

				if (note_on <=0)
				{
					  
						adsr.keyOff();
						0=> note_on;
						spork ~ end(msg.data2);
				}
		}


		}

		fun void end(int note) {
       adsr.releaseTime() => now;
				if (note == last_note)
					0 => last_note;
		}



}




	mpk25 m;
m.reg(GLIDE g);
  


	while(1) {
		     100::ms => now;
	}
	
