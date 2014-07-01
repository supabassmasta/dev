class lpd8_ext extends lpd8 {
		string WAV[0];
		WAV << "../_SAMPLES/FreeDrumKits.net - 1017 BRICKSQUAD Drum Kit/1017 BrickSquad Kit/Kicks/Kick (3).wav";
		WAV << "../_SAMPLES/FreeDrumKits.net - 1017 BRICKSQUAD Drum Kit/1017 BrickSquad Kit/Snares/Sanre (12).wav";
		WAV << "../_SAMPLES/FreeDrumKits.net - 1017 BRICKSQUAD Drum Kit/1017 BrickSquad Kit/Hi Hats, Crashes, & Percs/Pers (16).wav";

//		WAV << ;

		0 => int wav_index;

    .5 => float ratio_fact;

		Gain final => global_mixer.line4;
		.3 => final.gain;

// SHRED Management
int shred_to_kill_a[0];

fun int shred_to_kill(){
		0 => int res;
		int idx_to_remove;
		for (0=> int i; i < shred_to_kill_a.size() ; i ++) {
				if (me.id() == shred_to_kill_a[i]) {
					1 => res;
					i => idx_to_remove;
				}
			}

		if (res) {
				for (idx_to_remove =>int i; i < (shred_to_kill_a.size() - 1) ; i ++) {
						shred_to_kill_a[i + 1] => shred_to_kill_a[i];
				}

				shred_to_kill_a.popBack();
		}

/* CHECK shred_to_kill

	<<< "shred_to_kill[i];">>>;

for (0 => int i; i <  shred_to_kill_a.size()     ; i++) {
	<<< shred_to_kill_a[i]>>>;
}
*/ 
    return res;
}

int pad_shred_id[8];


// PLAY FUNCS
  fun void f1 (int offset){ 
		SndBuf s => final;
		.3 => s.gain;

		WAV[wav_index + offset] => s.read;
		s.length() => now;



	 } 

   fun void play_hh(float ratio, int contre_temp, int wav_offset){
				// sync
				if (!contre_temp)
		        data.tick/ratio - ((now - data.wait_before_start) % ( data.tick / ratio )) => now;
				else
						data.tick/ratio - ((now - data.wait_before_start -  data.tick / (2 *ratio) ) % ( data.tick / ratio )) => now;
			
				while (!shred_to_kill()){
					spork ~ f1 (wav_offset);
				  data.tick/ ratio => now;
				}

	 }



	    // PADS
			fun void pad_ext (int group_no, int pad_nb, int val) {
//						<<<group_no, pad_nb, val>>>;
						 36-=> pad_nb;
				   if (group_no == 144) {

								if (pad_nb == 0)    (spork~play_hh( 1.*ratio_fact /*ratio*/, 0 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 1)    (spork~play_hh( 4.*ratio_fact /*ratio*/, 0 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 2)    (spork~play_hh( 4.*ratio_fact /*ratio*/, 1 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 3)    (spork~play_hh( 16.*ratio_fact /*ratio*/, 0 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];

								if (pad_nb == 4)    (spork~play_hh( 1.*ratio_fact /*ratio*/, 1 /*contre_temp*/, 1 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 5)    (spork~play_hh( 2.*ratio_fact /*ratio*/, 1 /*contre_temp*/, 1 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 6)    (spork~play_hh( 4.*ratio_fact /*ratio*/, 0 /*contre_temp*/, 2 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								if (pad_nb == 7)    (spork~play_hh( 4.*ratio_fact /*ratio*/, 1 /*contre_temp*/, 2 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								
						 }
			       else if (group_no == 128 ) {
											shred_to_kill_a << pad_shred_id[pad_nb];
						 }
}

			    // POTARS
					fun void potar_ext (int group_no, int pad_nb, int val) {
						    if (group_no == 176) {

									if (pad_nb  == 1)      { val $ float / 64. => final.gain;}   
									else if (pad_nb  == 2) {
												val / (127 / WAV.size()) => wav_index;
												if (wav_index >= WAV.size() - 1) WAV.size() - 2 => wav_index;
												<<<wav_index, WAV[wav_index] >>>;
										}
									else if (pad_nb  == 3) {
										val / 16 + 1 => ratio_fact;
										<<<"ratio_fact", ratio_fact>>>;
										
										}
									else if (pad_nb  == 4) {}
									else if (pad_nb  == 5) {}
									else if (pad_nb  == 6) {}
									else if (pad_nb  == 7) {}
										}    
					}
}

lpd8_ext lpd;

while (1) 1::second => now; 
