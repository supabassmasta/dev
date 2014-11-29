class lpd8_ext extends lpd8 {
	    
			now => time prev;
			100. => float mean_bpm;

			
			// PADS
			fun void pad_ext (int group_no, int pad_nb, int val) {
				   if (group_no == 144) {
						 36-=> pad_nb;

						 if (pad_nb  == 0)      {}   
						 else if (pad_nb  == 1) {
							 now => time t_now;
							 t_now - prev => dur tick;
							 
							 if (tick < 2::second) {
										60::second / tick => float instant_bpm;
										mean_bpm * 0.7 + instant_bpm*.3 => mean_bpm;
											<<<"instant_bpm: ", instant_bpm, " mean_bpm: ", mean_bpm>>>;
							  }
								else {
										<<<"Timeout">>>;
								}
								t_now => prev;
							 
							 }
						 else if (pad_nb  == 2) {}
						 else if (pad_nb  == 3) {}
						 else if (pad_nb  == 4) {}
						 else if (pad_nb  == 5) {}
						 else if (pad_nb  == 6) {}
						 else if (pad_nb  == 7) {}
						     }
			}

			    // POTARS
					fun void potar_ext (int group_no, int pad_nb, int val) {
						    if (group_no == 176) {

									if (pad_nb  == 0)      {}   
									else if (pad_nb  == 1) {}
									else if (pad_nb  == 2) {}
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
