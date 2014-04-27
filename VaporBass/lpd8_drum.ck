

class RecSeqSndBuf extends seqSndBuf  {

// SYNC
    2 => sync_on;
    
    fun void play_n_rec (int rec_mode) {
    
        0=> pos;
        
				<<<"inedx:", idx()>>>;

        if (rec_mode == 0){
            // do nothing
        }
        else if (rec_mode == 1){
            // REC
            spork ~ spork_rec(idx ());
        }
        else if (rec_mode == 2){
            spork ~ spork_del(idx ());
        }
        else if (rec_mode == 3){
        }
    
    
    }

    fun void spork_rec (int i) {
    
        if (((now- data.wait_before_start) % tick ()) > (tick() / 2)) { i++;<<<"over">>>;}
        
        // wait 2 tick to avoid double play
        tick() * 2 => now;
        // Store note
        1. => g[i%g.size()];
				<<<"store in:", i%g.size()>>>;
    }

    fun void spork_del (int i) {
    
        if (((now - data.wait_before_start) % tick ()) > (tick() / 2)) i++;
        
        // wait 2 tick to avoid double play
        tick() * 2 => now;
        // Store note
        0. => g[i%g.size()];
    }

}





class lpd8_ext extends lpd8 {
 
    8 => int granularity;
    8 => int meas_nb;


    
    0 => int rec_mode;
    
    8 => int seq_nb;
    
    RecSeqSndBuf s[seq_nb];
    Gain g[seq_nb];
    0 => int i;

    Gain final => global_mixer.line3;    

    "../_SAMPLES/DMD-FR909/FR909 Snares/FR9 hghsnrs/f9hsnr01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;
    "../_SAMPLES/DMD-FR909/FR909 Snares/FR9 lwsnrs/f9lsnr01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;

    "../_SAMPLES/DMD-FR909/FR909 Kicks/FR9 distkck/f9dstk01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;    
    "../_SAMPLES/DMD-FR909/FR909 Kicks/FR9 hrdrkck/f9hrdk01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;    

    "../_SAMPLES/DMD-FR909/FR909 Snares/FR9 softsnrs/f9sfsn01.wav"=> s[i].read; .3 => g[i].gain; s[i] => g[i] => final; i++;
    "../_SAMPLES/DMD-FR909/FR909 Snares/FR9 tightsnrs/f9tsnr01.wav"=> s[i].read; .3 => g[i].gain; s[i] => g[i] => final; i++;
    
		"../_SAMPLES/DMD-FR909/FR909 Kicks/FR9 medkck/f9medk01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;    
		"../_SAMPLES/DMD-FR909/FR909 Kicks/FR9 sftrkck/f9sftk01.wav"=> s[i].read; .2 => g[i].gain; s[i] => g[i] => final; i++;    
    
		
		for (0=> int j; j<seq_nb; j++){
        data.bpm  * granularity=> s[j].bpm;
        granularity * meas_nb => s[j].g.size;
	 s[j].samples() => s[j].pos;       
    }

    for (0=> int j; j<seq_nb; j++){
        s[j].go();
    }
    
     // for (0=> int j; j<s[0].g.size(); j++){
        // <<<s[0].g[j]>>>;
    
    // }
    
    
    // HOLD Mode management	
    0 => int hold_mode;
    me.id() => int mother_shred_id;
    
    fun void manage_hold() {
    	while (1){
	    global_event.hold_event => now;
	    if (global_event.hold_shred_id == mother_shred_id){
	        if (hold_mode) 0=> hold_mode; else 1=> hold_mode;	
	    }
	}
    }    
    spork ~  manage_hold();
    
    
    // PADS
    fun void pad_ext (int group_no, int pad_nb, int val) {

        if (!hold_mode) {
     	   if (group_no == 144) {
     	       36-=> pad_nb;

     	   s[pad_nb].play_n_rec (rec_mode);	   
     	   
     	   }
	}

    
    
    
    }

    // POTARS
    fun void potar_ext (int group_no, int pad_nb, int val) {
    
        if (!hold_mode) {
            if (group_no == 176) {
//            0-=> pad_nb

		if (pad_nb  == 1) {
 			val $ float / 32. => final.gain;
 		}
                else if (pad_nb  == 2) {
                
                    if (val < 40) {
                        2 => rec_mode;
                        <<<"DELETE">>>;
                    }
                    else if (val<80){
                        0 => rec_mode;
                        <<<"No rec Standby">>>;
                    }
                    else {
                        1 => rec_mode;
                        <<<"REC">>>;
                    }
                
                }
                
            } 
	    
	 }   
    }
}

lpd8_ext lpd;

while (1) 1::second => now;

