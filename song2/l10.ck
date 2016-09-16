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

				"x" + nb + ".ck" => xname;
				"y" + nb + ".ck" => yname;
				"z" + nb + ".ck" => zname;
//				<<<"xname", xname>>>; 

		}

   fun void set(float in) {
		 //				<<<"HEY", in>>>;
		 if (in == 127.) {
			 if (pad_on) {
				 killer.kill(zid);
				 0 => pad_on;
				 lau.clear(note);
			 } 
			 else {
				 Machine.add( xname );
				 Machine.add( yname ) => yid;
				 Machine.add( zname ) => zid;
				 if (zid != 0) {
					 1 => pad_on;
				 }

				 lau.green(note);
			 }
		 }
		 else {
				killer.kill(yid);
				if (!pad_on) {
					 lau.clear(note);
				}

		 }

   }
		
		

}

script_launcher s;

s.prepare(11, 0, l);

l.keys[0].reg(s);

l.start();

while(1) {
	     100::ms => now;
}
 

