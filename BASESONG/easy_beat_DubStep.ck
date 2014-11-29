class lpd8_ext extends lpd8 {
		string WAV[0];
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_2.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_3.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_4.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_5.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_6.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_7.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_10.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_11.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_2.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_3.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_4.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_5.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_6.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_7.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_8.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_9.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_2.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_3.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_4.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_5.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_6.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_7.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_8.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_10.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_11.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_12.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_13.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_2.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_3.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_4.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_5.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_6.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_7.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_8.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_9.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_10.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_11.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_2.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_3.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_4.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_5.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_6.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_7.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_8.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_9.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Tom_1.wav";
		WAV << "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Tom_2.wav";
//		WAV << ;

		0 => int wav_index;


   0 => int last_pad;
   0 => int last_pad_up;
   0 => int pad_active_nb;
   0 => int pad_active_nb_up;

		Gain final => global_mixer.line4;


  fun void f1 (){ 
		SndBuf s => final;
		.3 => s.gain;

		WAV[wav_index] => s.read;
		s.length() => now;



	 } 

   fun void play_hh(int pad){
				// sync
				Math.pow(2,pad) => float ratio;

        data.tick/ratio - ((now - data.wait_before_start) % ( data.tick / ratio )) => now;

				while (pad_active_nb > 0 && last_pad == pad){
					spork ~ f1 ();
				  data.tick/ ratio => now;
				}

	 }


   fun void play_hh_up(int pad){
				// sync
				Math.pow(2,pad - 4) => float ratio;

        data.tick/ratio - ((now - data.wait_before_start -  data.tick / (2 *ratio) ) % ( data.tick / ratio )) => now;

				while (pad_active_nb_up > 0 && last_pad_up == pad){
					spork ~ f1 ();
				  data.tick/ ratio => now;
				}

	 }


//	 spork ~ f1 ();
	  


	    // PADS
			fun void pad_ext (int group_no, int pad_nb, int val) {
//						<<<group_no, pad_nb, val>>>;
						 36-=> pad_nb;
				   if (group_no == 144) {

								if (pad_nb < 4) {
								    pad_active_nb ++;
										pad_nb => last_pad;
								    spork~play_hh(pad_nb);
//										<<<pad_nb,pad_active_nb>>>;
								}
								else {
								    pad_active_nb_up ++;
										pad_nb => last_pad_up;
								    spork~play_hh_up(pad_nb);
								}
						 }
			       else if (group_no == 128 ) {
										if (pad_nb < 4) {
												pad_active_nb --; 
//										<<<pad_nb,pad_active_nb>>>;
										}
										else {
												pad_active_nb_up --; 
										}
								 }
}

			    // POTARS
					fun void potar_ext (int group_no, int pad_nb, int val) {
						    if (group_no == 176) {

									if (pad_nb  == 1)      { val $ float / 64. => final.gain;}   
									else if (pad_nb  == 2) {
												val / (127 / WAV.size()) => wav_index;
												if (wav_index >= WAV.size()) WAV.size() - 1 => wav_index;
												<<<wav_index, WAV[wav_index] >>>;
										}
									else if (pad_nb  == 3) {}
									else if (pad_nb  == 4) {}
									else if (pad_nb  == 5) {}
									else if (pad_nb  == 6) {}
									else if (pad_nb  == 7) {}
										}    
					}
}

lpd8_ext lpd;

while (1) 1::second => now; 
