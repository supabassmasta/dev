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
	0 => int red;

  fun int file_exist (string filename){ 
    FileIO fio;
    fio.open( filename, FileIO.READ );
    if( !fio.good() )
        return 0;
    else {
      fio.close();
      return 1;
    }
  } 

  fun int red_file_exist (string filename){ 
    FileIO fio;
    fio.open( "red/" + filename, FileIO.READ );
    if( !fio.good() )
        return 0;
    else {
      fio.close();
			1 => red;
      return 1;
    }
  } 
      
	fun void prepare(int in_nb, int in_note , LAUNCHPAD @ in_l){
		in_nb => nb;
		in_note => note;
		in_l @=> lau;
    0 => int cont;

		if (nb < 10) {
			"x0" + nb + ".ck" => xname;
			"y0" + nb + ".ck" => yname;
			"z0" + nb + ".ck" => zname;
      1 => cont;
		}
		else {
			"x" + nb + ".ck" => xname;
			"y" + nb + ".ck" => yname;
			"z" + nb + ".ck" => zname;
      0 => cont;
		}

		//				<<<"xname", xname>>>; 

    // turn on light for existing files
    if (file_exist(xname) || file_exist(yname) || file_exist(zname) ) {
      if (red_file_exist(xname) || red_file_exist(yname) || red_file_exist(zname) ) {
        // <<<"RED ", zname>>>; 
        if (cont){
            lau.redc(note);
        }
        else {
            lau.red(note);
        }
      }
      else {
        if (cont){
          lau.amberc(note);
        }
        else {
          lau.amber(note);
        }
      }
    }
	}

	fun void set(float in) {
//						<<<"HEY", in, note, zid, pad_on>>>;
		if (in == 127.) {
			if (pad_on) {
				killer.kill(zid);
				0 => pad_on;
				if (nb < 10) 
					if (red)
						lau.redc(note);
					else
					  lau.amberc(note);
				else {
					if (red)
						lau.red(note);
					else{
						lau.amber(note);
					}
				}

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
			if (yid != 0) {
				killer.kill(yid);
				if (!pad_on) {
					if (nb < 10) 
						lau.amberc(note);
					else
						lau.amber(note);
				}
			
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
 

