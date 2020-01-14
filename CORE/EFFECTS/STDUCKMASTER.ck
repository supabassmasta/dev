public class STDUCKMASTER extends ST {
	global_mixer.stduck_l.duck();

	global_mixer.stduck_r.duck();

	Gain sidein_l => blackhole;
	Gain sidein_r => blackhole;

	fun void side_process(){ 

		while(1) 
		{
			sidein_l.last() =>  global_mixer.stduck_l.sideInput;
			sidein_r.last() =>  global_mixer.stduck_r.sideInput;
			1::samp => now;
		}

	} 

	fun void connect(ST @ tone, float in_gain, float tresh, float slope, dur attack, dur release) {

	in_gain => sidein_l.gain;
	in_gain => sidein_r.gain;
	
	tresh => global_mixer.stduck_l.thresh;
	tresh => global_mixer.stduck_r.thresh;

	slope => global_mixer.stduck_l.slopeAbove;
	slope => global_mixer.stduck_r.slopeAbove;

	attack => global_mixer.stduck_l.attackTime;
	attack => global_mixer.stduck_r.attackTime;

	release => global_mixer.stduck_l.releaseTime;
	release => global_mixer.stduck_r.releaseTime;
  
  tone.left() => sidein_l;
		tone.right() => sidein_r; 

		tone.left() => outl;
		tone.right() => outr; 

		spork ~ side_process();
	}

}






