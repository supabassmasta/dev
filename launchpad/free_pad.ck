LAUNCHPAD l;

Gain out => dac;
.2 => out.gain;

class pad extends LAUNCHPAD_KEY {
	    SndBuf s;
			SAVE save;
			 

			fun void start() {
				save.init(me.path());	
//				<<<"pad_sample"+key>>>;
			  
				save.reads("pad_sample"+key) => string file;	
				<<<file>>>;
				file => s.read;
				s.samples() => s.pos;
				s => out;
			}
	
		  fun int on() {
						0 => s.pos;
						return 32;
				}	

}


pad p;
0=> p.key;
144=> p.channel;
p.start();

p @=> l.keys[0];
 l.start();


while(1) {
	     100::ms => now;
}

