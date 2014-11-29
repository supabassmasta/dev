
//<<<me.arg(0)>>>;
Step in_freq;
Std.atof(me.arg(0)) => in_freq.next;
  2. => float attack_coef;
    
	in_freq =>ADSR slide_attack =>  Gain in => SinOsc main => Gain final  => disto dist => ADSR a  => global_mixer.line5;
	a.set(2::ms, 0::ms, 1. , 2::ms);
	slide_attack.set(0::ms, 20::ms, 1./attack_coef, 900::ms);
	attack_coef => slide_attack.gain;



	.05 => final.gain;
  in => Gain two => SinOsc sec => final;
  2.00 => two.gain;
	.8 => sec.gain;

   /*in => Gain three => SinOsc tri => final;
	 3.00 => three.gain;
   .6 => tri.gain;
*/
    4 => dist.gain_in;
		
	    slide_attack.keyOn();
	    a.keyOn();
			10::ms => now;
	    slide_attack.keyOff();
	   
			2000::ms => now;
		a.keyOff();
		2::ms => now;
