class POLY extends SYNTA {

		8 => int nb_voice;
		SinOsc s[nb_voice];
		ADSR a[nb_voice];
		int note[nb_voice];

		for (0 => int i; i < nb_voice       ; i++) {
			a[i].keyOff();
			s[i] => a[i] => dac;
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
				Std.mtof (msg.data2) => s[i].freq;
        msg.data2 => note[i];
				a[i].keyOn();
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
		  }
		}
  }
}


mpk25 m;

m.reg(POLY p);

while(1) {
	     100::ms => now;
}
 
