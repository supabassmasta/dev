public class GLIDE extends SYNTA {

		20::ms => dur duration;

		Step one => Envelope e;
		ADSR adsr => Pan2 pan;
    pan.right => outr;
    pan.left  => outl;

		SYNT @ synt;
fun void reg (SYNT @ in){
		in @=> synt;
		e => synt => adsr;
		.2 => synt.gain;

}
		1. => one.next;
		300::ms => dur release;
		adsr.set(3::ms, 30::ms, .7, release);
		
		0 => int last_note;
		0 => int note_on;
		
		fun void in (	MidiMsg msg ) {
				//                 msg.data1  => group_no_;
				//                msg.data2 => pad_nb_;
				//                msg.data3 => val_;

        send_note_info(msg);

		if (msg.data1 == 144){
				note_on ++;
				synt.new_note(0);
				synt.on();
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
						synt.off();
						0=> note_on;
						spork ~ end(msg.data2);
				}
		}


		}

		fun void end(int note) {
       release => now;
				if (note == last_note)
					0 => last_note;
		}



}


