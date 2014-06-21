class lpd8_ext extends lpd8 {
		string WAV[0];
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBAgogo9.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap10.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap11.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap8.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClap9.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClaves1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClaves2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClaves3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClaves4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClaves5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBClsHat8.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBCrash1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBCrash2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBCrash3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBCrash4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBCrash5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBKick8.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBOpHat1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBOpHat2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBOpHat3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBPerc1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBPerc8.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBPop1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBPop2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBPop3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBShaker1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBShaker2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBShaker3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBShaker4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBShaker5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare10.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare11.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare12.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare8.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBSnare9.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom1.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom2.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom3.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom4.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom5.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom6.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom7.wav";
		WAV <<"../_SAMPLES/Volca_Beast/VBTom8.wav";
//		WAV << ;

		0 => int wav_index;

    1 => int ratio_fact;

		Gain final => global_mixer.line4;

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

	<<<"shred_to_kill[i];">>>;

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

								if (pad_nb < 4)     (spork~play_hh( (1.+ pad_nb)*ratio_fact /*ratio*/, 0 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];
								else (spork~play_hh( (1.+ pad_nb-4)*ratio_fact /*ratio*/, 1 /*contre_temp*/, 0 /* wav_offset */ )).id() => pad_shred_id[pad_nb];

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
