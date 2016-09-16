LAUNCHPAD l;

class script_launcher extends CONTROL {
		string xname; // oneshot script
		string yname; // stop on release script
		string zname; // toggle script
		int nb;

		fun void prepare(int in){
				in => nb;

				"x" + nb + ".ck" => xname;
				"y" + nb + ".ck" => yname;
				"z" + nb + ".ck" => zname;
//				<<<"xname", xname>>>; 

		}

   fun void set(float in) {
//				<<<"HEY", in>>>;
				if (in == 127.) {
						 Machine.add( xname );
				}

   }
		
		

}

script_launcher s;

s.prepare(11);

l.keys[0].reg(s);

l.start();

while(1) {
	     100::ms => now;
}
 

