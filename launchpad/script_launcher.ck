HW.launchpad @=> LAUNCHPAD @ l;

class script_launcher extends CONTROL {
	string xname; // oneshot script
	string yname; // stop on release script
	string zname; // toggle script
	int nb;
	int note;
	LAUNCHPAD @ lau;
	0 => int yid;
	0 => int zid;
	0 => int pad_on;

	fun void prepare(int in_nb, int in_note , LAUNCHPAD @ in_l){
		in_nb => nb;
		in_note => note;
		in_l @=> lau;

		if (nb < 10) {
			"x0" + nb + ".ck" => xname;
			"y0" + nb + ".ck" => yname;
			"z0" + nb + ".ck" => zname;
		}
		else {
			"x" + nb + ".ck" => xname;
			"y" + nb + ".ck" => yname;
			"z" + nb + ".ck" => zname;
		}

		//				<<<"xname", xname>>>; 

	}

	fun void set(float in) {
		//				<<<"HEY", in>>>;
		if (in == 127.) {
			if (pad_on) {
				killer.kill(zid);
				0 => pad_on;
				if (nb < 10) 
					lau.clearc(note);
				else
					lau.clear(note);

			} 
			else {
				Machine.add( xname );
				Machine.add( yname ) => yid;
				Machine.add( zname ) => zid;
				if (zid != 0) {
					1 => pad_on;
				}

				if (nb < 10) 
					lau.greenc(note);
				else
					lau.green(note);
			}
		}
		else {
			killer.kill(yid);
			if (!pad_on) {
				if (nb < 10) 
					lau.clearc(note);
				else
					lau.clear(note);
			}

		}

	}



}

script_launcher s [72];
int n;
int nt;

// Keys and right side controls
for (0 => int i; i <  8     ; i++) {
	for (0 => int j; j < 9      ; j++) {
	  (i+1)*10 + j +1 => n; 
	  (i)*16 + j  => nt; 
		s[i*9 + j].prepare(n, nt, l);

		l.keys[nt].reg(s[i*9 + j]);
	}
}
 
// Up side controls
script_launcher s2 [8];
for (0 => int  i; i <  8     ; i++) {
		i + 1 => n;
		i + 104 => nt;
		s2[i].prepare(n, nt, l);

		l.controls[nt].reg(s2[i]);
}

l.start();

// KB management
    Hid hi;

    // open keyboard 0
    if( !hi.openKeyboard( 0 ) ) me.exit();
    <<< "keyboard '" + hi.name() + "' ready", "" >>>;
    spork ~ kb_management(hi);

fun void kb_management (Hid hi)
{
	HidMsg msg; 
	int num;
	// infinite event loop
	while( true )
	{
		// wait on event
		hi => now;

		// get one or more messages
		while( hi.recv( msg ) )
		{
			//<<<"note_active 1",note_active>>>;
			// check for action type
			if( msg.isButtonDown() )
			{
//				<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
				//--------------------------------------------//
				//--------------------------------------------//
				if(msg.which == 31)
				{
					<<<"replace YI">>>;
          500::ms => now;
					// Get last key (note, will not work wity controls on the top of launchpad)
					l.keys[l.last_key].controls[0] $ script_launcher @=> script_launcher last;
					if (last.pad_on == 1) {
							 killer.kill(last.zid);	
						   Machine.add(last.zname) => last.zid;
					}
				}
			} 
		}
	}
}

while(1) {
	     100::ms => now;
}
 

