class lpd8_ext extends lpd8 {
		string WAV[0];
		WAV<<"../_SAMPLES/AFRICAN_SET/AFRICAN_SET.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/BONGOLOW.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/CABASA.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/CLSHIHAT.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/COWBELL.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/CRSHCYM1.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/CRSHCYM2.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/HANDCLAP.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER01.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER02.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER05.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER06.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER09.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/INDPER13.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/KICKDRM1.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/OPNHIHAT.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/PDLHIHAT.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/RIDEBELL.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/RIDECYM1.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/RIDECYM2.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/SIDESTIK.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/SNARE1P.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/SNARE2P.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/SPLSHCYM.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/TAMBORIN.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/TMBALELO.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/VIBRSLAP.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/VIB_SLAP.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_02.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_05.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_06.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_07.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_08.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_10.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_12.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_13.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_14.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_16.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_17.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_18.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_21.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_29.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_30.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_31.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_32.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_33.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_34.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_35.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_37.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_38.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_39.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_43.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_46.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_49.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/_PERC_51.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/mystflute+2.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/mystflute+3.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/mystflute+4.wav";
		WAV<<"../_SAMPLES/AFRICAN_SET/mystflute.wav";



//		WAV << ;

		0 => int wav_index;


   0 => int last_pad;
   0 => int last_pad_up;
   0 => int pad_active_nb;
   0 => int pad_active_nb_up;

   0::ms => dur groove_offset;
   -1 => int grv_potar_init;

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
        
				groove_offset/ratio => dur offset;
		    if(offset != 0::ms) <<<"GROOVE OFFSET =", offset/1::ms, " ms">>>;

				data.tick/ratio + offset - ((now - data.wait_before_start) % ( data.tick / ratio )) => now;

				while (pad_active_nb > 0 && last_pad == pad){
					spork ~ f1 ();
				  data.tick/ ratio => now;
				}

	 }


   fun void play_hh_up(int pad){
				// sync
				Math.pow(2,pad - 4) => float ratio;

				groove_offset/ratio => dur offset;
		    if(offset != 0::ms) <<<"GROOVE OFFSET =", offset/1::ms, " ms">>>;

        data.tick/ratio + offset  - ((now - data.wait_before_start -  data.tick / (2 *ratio) ) % ( data.tick / ratio )) => now;

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

												0::ms => groove_offset;
												-1 => grv_potar_init;
										}
									else if (pad_nb  == 3) {}
									else if (pad_nb  == 4) {
										// GROOVE OFFSET
										if (grv_potar_init == -1) val => grv_potar_init;
										else (val - grv_potar_init)*data.tick/(127.*2.) => groove_offset;

										<<<"GROOVE OFFSET =", groove_offset/1::ms, " ms, ", groove_offset/data.tick, " tick">>>;

										}
									else if (pad_nb  == 5) {}
									else if (pad_nb  == 6) {}
									else if (pad_nb  == 7) {}
										}    
					}
}

lpd8_ext lpd;

while (1) 1::second => now; 
