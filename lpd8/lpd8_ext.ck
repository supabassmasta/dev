class lpd8_ext extends lpd8 {
 
    8 => int nb_snd;
    SndBuf snd[nb_snd];
    
    Gain final => dac;

    "../_SAMPLES/Tom Velo07 High.wav"=> snd[0].read;   0.2 => snd[7].gain;  snd[7] => final;
    "../_SAMPLES/Tom Velo07  Mid.wav"=> snd[1].read;   0.4 => snd[1].gain;  snd[1] => final;
    "../_SAMPLES/KICK_01.WAV"=> snd[2].read;   0.2 => snd[5].gain;  snd[5] => final;
    "../_SAMPLES/amen-hit.wav"=> snd[3].read;   0.2 => snd[0].gain;  snd[0] => final;
    "../_SAMPLES/amen-hat.wav"=> snd[4].read;   0.2 => snd[4].gain;  snd[4] => final;
    "../_SAMPLES/RIDE_03.WAV"=> snd[5].read;   0.2 => snd[6].gain;  snd[6] => final;
     "../_SAMPLES/Crash  Dub1.wav"=> snd[6].read;   0.4 => snd[2].gain;  snd[2] => final;
    "../_SAMPLES/amen-snare.wav"=> snd[7].read;   0.15 => snd[3].gain;  snd[3] => final;
       
    // ""=> snd[].read;   0.2 => snd[].gain;  snd[] => final;
    
    for (0=> int i; i< nb_snd; i++) {
        snd[i].samples() => snd[i].pos; // Set to the end to avoid unwanted play
    }



 
    // PADS
    fun void pad_ext (int group_no, int pad_nb, int val) {

        if (group_no == 144) {
	    36-=> pad_nb;

            if (pad_nb  == 0)      {0=>snd[0].pos;}   
            else if (pad_nb  == 1) {0=>snd[1].pos;}
            else if (pad_nb  == 2) {0=>snd[2].pos;0=>snd[3].pos;}
            else if (pad_nb  == 3) {0=>snd[3].pos;}
            else if (pad_nb  == 4) {0=>snd[4].pos;}
            else if (pad_nb  == 5) {0=>snd[5].pos;}
            else if (pad_nb  == 6) {0=>snd[6].pos;}
            else if (pad_nb  == 7) {0=>snd[7].pos;0=>snd[3].pos;}
        
        
        }

    
    
    
    }

    // POTARS
    fun void potar_ext (int group_no, int pad_nb, int val) {
    
    
    }
}

lpd8_ext lpd;

while (1) 1::second => now;

