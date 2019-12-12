HW.launchpad @=> LAUNCHPAD @ l;

8 => int nb_page;

class script_launcher extends CONTROL {
	string xname; // oneshot script
	string yname; // stop on release script
	string zname; // toggle script
	int nb;
	int note;
	LAUNCHPAD @ lau;
	0 => int xid;
	0 => int yid;
	0 => int zid;
	0 => int pad_on;
	0 => int pad_with_file;
	0 => int red;
  0 => int cont;

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
      
	fun void prepare(int p /* page */, int in_nb, int in_note , LAUNCHPAD @ in_l){
		in_nb => nb;
		in_note => note;
		in_l @=> lau;
    
    string pa;

    if (p == 0) "" => pa;
    else "" + p => pa;

		if (nb < 10) {
			"x" + pa + "0" + nb + ".ck" => xname;
			"y" + pa + "0" + nb + ".ck" => yname;
			"z" + pa + "0" + nb + ".ck" => zname;
      1 => cont;
		}
		else {
			"x" + pa + nb + ".ck" => xname;
			"y" + pa + nb + ".ck" => yname;
			"z" + pa + nb + ".ck" => zname;
      0 => cont;
		}

			<<<"xname", xname>>>; 

    // turn on light for existing files
    if (file_exist(xname) || file_exist(yname) || file_exist(zname) ) {
      1 => pad_with_file;
      if (red_file_exist(xname) || red_file_exist(yname) || red_file_exist(zname) ) {
        1 => red;
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
				Machine.add( xname ) => xid;
				Machine.add( yname ) => yid;
				Machine.add( zname ) => zid;
				if (zid != 0) {
					1 => pad_on;
				}

        if ( xid != 0 || yid !=0 || zid != 0) {
          1 =>  pad_with_file;
          if (nb < 10) 
            lau.greenc(note);
          else
            lau.green(note);
        }
			}
		}
		else if (in == 126.) { // VIRTUAL KEY ON only if OFF 
			if (!pad_on) {
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
		else if (in == 125.) { // VIRTUAL KEY OFF only if ON 
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

    }
		else {
			if (yid != 0) {
				killer.kill(yid);
			}

			else if (yid == 0 && 	zid == 0){
//				if (nb < 10) 
//					lau.clearc(note);
//				else
//					lau.clear(note);
			}
			else if (!pad_on) {
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


		}

	}

}

// Keys and right side controls
// Create array
script_launcher s[0] [72];
for (0 => int i; i < nb_page; i++) {
  s << new script_launcher[72];
}

int n;
int nt;
// Prepare controls
for (0 => int p; p < nb_page; p ++ ){
  for (0 => int i; i <  8     ; i++) {
    for (0 => int j; j < 9      ; j++) {
      (i+1)*10 + j +1 => n; 
      (i)*16 + j  => nt; 
      s[p][i*9 + j].prepare(p, n, nt, l);

    }
  }

} 

// Up side controls
// Create array 
script_launcher s2 [1][8];

// prepare controls
for (0 => int  i; i <  8     ; i++) {
		i + 1 => n;
		i + 104 => nt;
		s2[0][i].prepare(0, n, nt, l);
		l.controls[nt].reg(s2[0][i]);
}


class page_manager {

  LAUNCHPAD @ l;
  script_launcher s[][];

  0 => int current_page;
  int nb_p;

  fun void register_in_lp (int page) {

    for (0 => int i; i <  8     ; i++) {
      for (0 => int j; j < 9      ; j++) {
        (i)*16 + j  => int nt; 

        l.keys[nt].reg(s[page][i*9 + j]);
      }
    }


  }

  fun void unregister_in_lp (int page) {

    for (0 => int i; i <  8     ; i++) {
      for (0 => int j; j < 9      ; j++) {
        (i)*16 + j  => int nt; 

        l.keys[nt].unreg(s[page][i*9 + j]);
      }
    }


  }

  fun void light_up_page(int p) {
    for (0 => int i; i < 72; i++) {
      if(s[p][i].pad_on) {
        if (s[p][i].cont){
          l.greenc(s[p][i].note);
        }
        else {
          l.green(s[p][i].note);
        }
      }
      else if (  s[p][i].red  ){
        if (s[p][i].cont){
          l.redc(s[p][i].note);
        }
        else {
          l.red(s[p][i].note);
        }
      }
      else if (   s[p][i].pad_with_file  ){
        if (s[p][i].cont){
          l.amberc(s[p][i].note);
        }
        else {
          l.amber(s[p][i].note);
        }

      }

    }

  }

  fun void light_down_page(int p) {
    for (0 => int i; i < 72; i++) {
      if (   s[p][i].pad_with_file  ){
        if (s[p][i].cont){
          l.clearc(s[p][i].note);
        }
        else {
          l.clear(s[p][i].note);
        }

      }

    }

  }

  fun void page_up () {
    if (current_page < nb_p - 1 ){
      light_down_page(current_page);
      unregister_in_lp(current_page);
      current_page ++;
      register_in_lp(current_page);
      light_up_page(current_page);

      <<<"SCRIPT LAUNCHER: PAGE ", current_page>>>;
    }
    else {
      <<<"SCRIPT LAUNCHER: MAX PAGE reached">>>;
    }

  }

  fun void page_down () {
    if (current_page > 0 ){
      light_down_page(current_page);
      unregister_in_lp(current_page);
      current_page --;
      register_in_lp(current_page);
      light_up_page(current_page);
      <<<"SCRIPT LAUNCHER: PAGE ", current_page>>>;
    }
    else {
      <<<"SCRIPT LAUNCHER: MIN PAGE reached">>>;
    }
  }

}

page_manager pm;
l @=> pm.l;
s @=> pm.s;
nb_page => pm.nb_p;

// TODO 
class uppage extends CONTROL {
  page_manager @ pm;    // 0 =>  update_on_reg ;
  fun void set(float in) {
    pm.page_up();
  }
} 

uppage upagec;
pm @=> upagec.pm;

// TODO dwnpage
class dwnpage extends CONTROL {
  page_manager @ pm;    // 0 =>  update_on_reg ;
  fun void set(float in) {
    pm.page_down();
  }
} 

dwnpage dwnpagec;
pm @=> dwnpagec.pm;

// Regster page up and down
l.controls[104].reg(dwnpagec);
l.controls[105].reg(upagec);


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
 

