HW.launchpad @=> LAUNCHPAD @ l;

data.page_manager_page_nb => int nb_page;

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
  0 => int color;
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
      if ( fio => color  ){
          // Do nothing color is read in the "if"
          <<<"COLOR: ", color>>>;

      }
      else {
        <<<"RED: color:", color>>>;

        1 => red;
      }

      fio.close();
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

//			<<<"xname", xname>>>; 

    // turn on light for existing files
    if (file_exist(xname) || file_exist(yname) || file_exist(zname) ) {
      1 => pad_with_file;
      // Check red files and colors
      red_file_exist(xname); red_file_exist(yname) ; red_file_exist(zname) ;
    }
	}

	fun void set(float in) {
//						<<<"HEY", in, note, zid, pad_on>>>;
    
    // DIRTY: To optimize
    0 => int no_light;

    if ( in < 0  ){
        1 => no_light;
        in * -1 => in;
        <<<"No light">>>;
    }

    if ( color ==-1   ){
        1 => no_light;
    }

		if (in == 127.) {
			if (pad_on) {
				killer.kill(zid);
				0 => pad_on;

        if ( ! no_light  ){
          if (nb < 10) { 
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.colorc(note, color);  
            }
            else {
              if (red)
                lau.redc(note);
              else
                lau.amberc(note);
            }
          }
          else {
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.color(note, color);  
            }
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
			else {
        Machine.add( xname ) => xid;
        Machine.add( yname ) => yid;
        Machine.add( zname ) => zid;

        if ( xid != 0 || yid !=0 || zid != 0) {
          1 =>  pad_with_file;
        }

        if (zid != 0) {
          1 => pad_on;
          if ( ! no_light  ){
            if (nb < 10) 
              lau.greenc(note);
            else
              lau.green(note);
          }
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

          if ( ! no_light  ){
            if (nb < 10) 
              lau.greenc(note);
            else
              lau.green(note);
          }

        }

			}
		}
		else if (in == 125.) { // VIRTUAL KEY OFF only if ON 
			if (pad_on) {
				killer.kill(zid);
				0 => pad_on;
        if ( ! no_light  ){
          if (nb < 10) { 
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.colorc(note, color);  
            }
            else {
              if (red)
                lau.redc(note);
              else
                lau.amberc(note);
            }
          }
          else {
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.color(note, color);  
            }
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
		else {

			if (yid != 0) {
				killer.kill(yid);
			}

      /*

			else if (yid == 0 && 	zid == 0){
        //	Do nothing but keep this case. To do not light up pads.
			}
			else if (!pad_on) {
        if ( ! no_light  ){
          if (nb < 10) 
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.colorc(note, color);  
            }
            else {
              if (red)
                lau.redc(note);
              else
                lau.amberc(note);
            }
          else {
            if ( color != 0 ){
              if (color !=-1) // -1 means no color update
                lau.color(note, color);  
            }
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
      */

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

    // light it up
      if(s2[0][i].pad_on) {
        if (s2[0][i].cont){
          l.greenc(s2[0][i].note);
        }
        else {
          l.green(s2[0][i].note);
        }
      }
      else if (  s2[0][i].red  ){
        if (s2[0][i].cont){
          l.redc(s2[0][i].note);
        }
        else {
          l.red(s2[0][i].note);
        }
      }
      else if (   s2[0][i].pad_with_file  ){
        if (s2[0][i].cont){
          l.amberc(s2[0][i].note);
        }
        else {
          l.amber(s2[0][i].note);
        }

      }

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
      else if ( s[p][i].color != 0 ) { 
        if ( s[p][i].color != -1 ){ // -1 means no color update
          if (s[p][i].cont){
            l.colorc(s[p][i].note, s[p][i].color);
          }
          else {
            l.color(s[p][i].note, s[p][i].color);
          }
        }
      }
      else if ( s[p][i].red ){
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

      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"SCRIPT LAUNCHER: PAGE ", current_page>>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;


    }
    else {
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"SCRIPT LAUNCHER: MAX PAGE reached">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
    }

  }

  fun void page_down () {
    if (current_page > 0 ){
      light_down_page(current_page);
      unregister_in_lp(current_page);
      current_page --;
      register_in_lp(current_page);
      light_up_page(current_page);
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"SCRIPT LAUNCHER: PAGE ", current_page>>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
    }
    else {
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"SCRIPT LAUNCHER: MIN PAGE reached">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
      <<<"~~~~~~~~~~~~~~~~~~~~~~~~~", "">>>;
    }
  }

  fun void kill_page(int p){
    int no_light;

    if (p != current_page) -1 => no_light;
    else 1 => no_light;
    if ( p < nb_p ){
      for (0 => int i; i < 72; i++) {
        if(s[p][i].pad_on) {
          s[p][i].set(no_light * 125); // Off only
        }
      }
    }
    else {
      <<<"ERROR KILL PAGE: page too high: ", p>>>;
    }

  }

}

page_manager pm;
l @=> pm.l;
s @=> pm.s;
nb_page => pm.nb_p;
// Load first page
pm.register_in_lp(0);
pm.light_up_page(0);


// CONTROL Page up an down
class uppage extends CONTROL {
  page_manager @ pm;    // 0 =>  update_on_reg ;
  fun void set(float in) {
    if ( in == 127  ){
      pm.page_up();
    }
  }
} 

uppage upagec;
pm @=> upagec.pm;

class dwnpage extends CONTROL {
  page_manager @ pm;    // 0 =>  update_on_reg ;
  fun void set(float in) {
    if ( in == 127  ){
      pm.page_down();
    }
  }
} 

dwnpage dwnpagec;
pm @=> dwnpagec.pm;

// Register page up and down in launchpad
l.controls[104].reg(dwnpagec);
l.controls[105].reg(upagec);


////////////////////////////////////////////////////////////////////////////////////////////////////
class launchpad_virtual_control extends CONTROL {
     // 0 =>  update_on_reg ;
    script_launcher s[][];
    script_launcher s2 [][];
    int nb_p;
    page_manager @ pm;
    1 => int no_light;
    int cmd;

    fun void set(float in) {
      <<<"launchpad_virtual_control, command : ", cmd, " sid: ", in>>>;
      

      in $ int => int sid;
      sid / 100 => int p;
      (sid - p * 100) / 10 => int i;
      (sid - p * 100 - i*10) => int j;
      (i - 1)*9 + j - 1 => int idx;
      <<<"sid: ", sid, " page: ", p, " i: ", i, " j: ", j," idx: ", idx>>>;
      if ( idx >=72 || p > nb_p || idx < 0 || p < 0  ){
          <<<"ERROR LAUNCHPAD_VIRTUAL invalid sid ", sid>>>;
          <<<"sid: ", sid, " page: ", p, " i: ", i, " j: ", j," idx: ", idx>>>;
      }


      if ( sid < 9 ){
        // upside control
        s2 [0][sid - 1].set(cmd); 
          
      }
      else {
        if (p != pm.current_page) -1 => no_light;
        else 1 => no_light;
          
        s[p][idx].set(no_light * cmd); 
      }


    }
} 

launchpad_virtual_control launchpad_virtual_control_on;
126 => launchpad_virtual_control_on.cmd; // On only
s @=> launchpad_virtual_control_on.s;
s2 @=> launchpad_virtual_control_on.s2;
nb_page => launchpad_virtual_control_on.nb_p;
pm @=> launchpad_virtual_control_on.pm;

LAUNCHPAD_VIRTUAL.on.reg(launchpad_virtual_control_on);

launchpad_virtual_control launchpad_virtual_control_off;
125 => launchpad_virtual_control_off.cmd; // Off only
s @=> launchpad_virtual_control_off.s;
s2 @=> launchpad_virtual_control_off.s2;
nb_page => launchpad_virtual_control_off.nb_p;
pm @=> launchpad_virtual_control_off.pm;

LAUNCHPAD_VIRTUAL.off.reg(launchpad_virtual_control_off);

launchpad_virtual_control launchpad_virtual_control_toggle;
127 => launchpad_virtual_control_toggle.cmd; // Toggle
s @=> launchpad_virtual_control_toggle.s;
s2 @=> launchpad_virtual_control_toggle.s2;
nb_page => launchpad_virtual_control_toggle.nb_p;
pm @=> launchpad_virtual_control_toggle.pm;

LAUNCHPAD_VIRTUAL.toggle.reg(launchpad_virtual_control_toggle);

////////////////////////////////////////////////////////////////////////////////////////////////////

class launchpad_virtual_kill_page extends CONTROL {
     // 0 =>  update_on_reg ;
     page_manager @ pm;
     
     fun void set(float in) {
        pm.kill_page(in $ int);
     }
} 

launchpad_virtual_kill_page launchpad_virtual_kill_page_o;
pm @=> launchpad_virtual_kill_page_o.pm;

LAUNCHPAD_VIRTUAL.kill_page.reg(launchpad_virtual_kill_page_o);



////////////////////////////////////////////////////////////////////////////////////////////////////




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
 

