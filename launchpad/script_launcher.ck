LAUNCHPAD l;

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

	fun void prepare(int in_nb, int in_note , LAUNCHPAD @ in_l ){
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
while(1) {
	     100::ms => now;
}
 

