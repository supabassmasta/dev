public class STDUCKMASTER extends ST {
	global_mixer.stduck_l.duck();
	.2 => global_mixer.stduck_l.slopeAbove;
	2::ms => global_mixer.stduck_l.attackTime;
	30::ms => global_mixer.stduck_l.releaseTime;
	.04 => global_mixer.stduck_l.thresh;

	global_mixer.stduck_r.duck();
	.2 => global_mixer.stduck_r.slopeAbove;
	2::ms => global_mixer.stduck_r.attackTime;
	30::ms => global_mixer.stduck_r.releaseTime;
	.04 => global_mixer.stduck_r.thresh;

	Gain sidein_l => blackhole;
	Gain sidein_r => blackhole;
	9=>sidein_l.gain;
	9=>sidein_r.gain;

	fun void side_process(){ 

		while(1) 
		{
			sidein_l.last() =>  global_mixer.stduck_l.sideInput;
			sidein_r.last() =>  global_mixer.stduck_r.sideInput;
			1::samp => now;
		}

	} 

	fun void connect(ST @ tone) {
		tone.left() => sidein_l;
		tone.right() => sidein_r; 

		tone.left() => outl;
		tone.right() => outr; 

		spork ~ side_process();
	}

}






