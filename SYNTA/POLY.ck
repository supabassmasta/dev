public class POLY extends SYNTA {

		0 => int nb_voice;
		ADSR a[0];
		Step f[0];
		int note[0];
		
		SYNT @ s[0];

		
		fun void reg(SYNT in) {
			s.size() + 1 => s.size;
			s.size() => nb_voice;
			nb_voice - 1 => int i;
			in @=> s[i];	

			a.size() + 1 => a.size;
			new ADSR @=> a[i];
			f.size() + 1 => f.size;
			new Step @=> f[i];
			note.size() + 1 => note.size;

			a[i].keyOff();
			f[i] =>  s[i] =>  a[i] => dac;
			.2 => s[i].gain;
		  a[i].set(3::ms, 30::ms, .7, 100::ms);

			0 => note[i];
		}


	fun void in(	MidiMsg msg){
		if (msg.data1 == 144){		
		 // find a voice
		 0=>int i;
		 while (i < nb_voice  &&  note[i] != 0 ) { 
			 i++;
			 }

		 if (i == nb_voice) {
				<<<"POLY: No voice available!! Note skipped">>>; 
		 }
		 else {
				msg.data3 / 256. + .2 => a[i].gain;
				Std.mtof (msg.data2) => f[i].next;
        msg.data2 => note[i];
				a[i].keyOn();
				s[i].on();
				s[i].new_note(0);
		 }
		
		}		
		else if (msg.data1 == 128){
		  0 => int i;
      while (i < nb_voice   &&   note[i] != msg.data2) {
			  i++;
			}
			if (i == nb_voice) {
				 <<<"POLY: Note not found, can't stop">>>; 
		  }
		  else {
        a[i].keyOff();	
				0 => note[i];
				s[i].off();
		  }
		}
  }
}

/*
mpk25 m;

m.reg(POLY p);
TB303C g[4];
p.reg(g[0]);
p.reg(g[1]);
p.reg(g[2]);
p.reg(g[3]);
while(1) {
	     100::ms => now;
}
 
*/
