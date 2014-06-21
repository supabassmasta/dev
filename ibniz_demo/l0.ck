4=> int granularity;
16 => int meas_nb;

class synt extends Chubgraph{

// ****  SYNT *****
	
	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	SinOsc s[synt_nb];
	Gain final => outlet; .1 => final.gain;

  1.002 => float inharm;
	inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1.011 => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1.021 => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    -.99 => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    -.98 => detune[i].gain;    .6 => s[i].gain; i++;  
//	inlet => detune[i] => s[i] => final;    (i + 1) * inharm => detune[i].gain;    .2 => s[i].gain; i++;  
//	inlet => detune[i] => s[i] => final;    (i + 1) * inharm => detune[i].gain;    .3 => s[i].gain; i++;  
//	inlet => detune[i] => s[i] => final;    (i + 1) * inharm => detune[i].gain;    .2 => s[i].gain; i++;  
		
		
		0 => int toggle_on;

    fun void on() {
	if (!toggle_on){
	    1=> toggle_on;	
            //<<<"synt on">>>;
	    
	    

	}
    }
    
    fun void off() {
	if (toggle_on){
	    0=> toggle_on;	
            //<<<"synt off">>>;
	    
	    
	    
	}    
    }

}
// ****  SLIDE *****


class slide extends Chubgraph{

		Step step => LPF lpf => outlet;
		0 => step.next;
		10 => lpf.freq;

		0 => int active;

		1 => int unknow_flag;
		0 => int ref_val;
		0 => int dif_val;
		0 => int delta_val;

		fun int set (int val, int note){
				if (active){
						if (unknow_flag) {
								0=>unknow_flag;
								val => ref_val;
						}
						else {
							  val => dif_val;
								dif_val - ref_val => delta_val;
								
								Std.mtof (note + delta_val) - Std.mtof(note) => step.next;
						}
				}
				else {
						val => ref_val;
				}

				return delta_val;
		}		

		fun void reset(){
				0 => step.next;
				dif_val => ref_val;
		}

		fun void activate(){1 => active;}
		fun void deactivate(){0 => active; reset();}



}

// ****  REQ *****

class RecSeqFREQ extends FREQ  {

// SYNC
    2 => sync_on;
    0 => int delta_slide;
    fun void play_n_rec (int n, int rec_mode) {
    
        // Play note
        Std.mtof (n) => freq.value;
        // <<<"note and freq:", n , Std.mtof(n)>>>;
        1. => adsr.gain;
        adsr.keyOn();        
        1 => suspend_control; // suspend control from freq sequencer
        // <<<"PLAY">>>;

				// Manage index
				0 => int index;
				if (idx()%2 == 0){
						// slide origin note case (duration == 0)
						idx() => index;
				}
				else {
						idx()-1 => index;
				}


        if (rec_mode == 0){
            // do nothing
        }
        else if (rec_mode == 1){
            // REC
            spork ~ spork_rec(n, index);
        }
        else if (rec_mode == 2){
            spork ~ spork_del(index);
        }
        else if (rec_mode == 3){
            <<<"toto">>>;
        
            spork ~ spork_rec_continuous(n, index);
        }
        else if (rec_mode == 4){
            spork ~ spork_del_continuous(index);
        }
    }

    fun void spork_rec (int n, int i) {
    
        if ((now % tick ()) > (tick() / 2)) 2+=>i;
        
        // wait 2 tick to avoid double play
        tick() * 2 => now;
        // Store note
        1. => g[i%g.size()];
        0 => slide[i%slide.size()];
         n => note[i%g.size()];
        1. => g[(i+1)%g.size()];
        0 => slide[(i+1)%slide.size()];
         n => note[(i+1)%g.size()];
     }

    fun void spork_del (int i) {
    
        if ((now % tick ()) > (tick() / 2)) 2+=>i;
        
        // wait 2 tick to avoid double play
        tick() * 2 => now;
        // Store note
        0. => g[i%g.size()];
        0 => slide[i%slide.size()];
        0. => g[(i+1)%g.size()];
        0 => slide[(i+1)%slide.size()];
      }

    
    0 => int rec_continuous;
    
    fun void spork_rec_continuous (int n, int i) {
    
           rec_continuous ++;
				0=>delta_slide;
	   rec_continuous => int ref_rec_cont;
           // Store first note (double play possible)
           if ((now % tick ()) > (tick() / 2)) {  
								1. => g[(i+2)%g.size()];n => note[(i+2)%note.size()]; 
		           // wait end of note N-1
							 tick() - now%tick() => now;
								// wait end of note N
								tick() => now;
  						1. => g[(i+3)%g.size()];
							n + delta_slide=> note[(i+3)%note.size()];
							if (delta_slide != 0) 1=> slide[(i+3)%slide.size()];
							else 0=> slide[(i+3)%slide.size()];
							}
           else     {
							 1. => g[i%g.size()];         n => note[i%note.size()]; 
							 // wait end of note N
							 tick() - now%tick() => now;
						   1. => g[(i+1)%g.size()];        
							 n + delta_slide => note[(i+1)%note.size()]; 
							if (delta_slide != 0) 1=> slide[(i+1)%slide.size()];
								else 0=> slide[(i+1)%slide.size()];
							 }

     
            // sync just before next tick: to force seq to play the correct note.
//            tick() - now%tick() - 1::ms => now;
        
            while (rec_continuous == ref_rec_cont){
                2+=>i;
                1. => g[i%g.size()];
                n+ delta_slide => note[i%note.size()];
			          if (delta_slide != 0) 1=> slide[i%slide.size()];
								else 0=> slide[i%slide.size()];
				 		    // wait end of note N
                 tick() => now;
 	              1. => g[(i+1)%g.size()];
                n+ delta_slide => note[(i+1)%note.size()];
							if (delta_slide != 0) 1=> slide[(i+1)%slide.size()];
						  else 0=> slide[(i+1)%slide.size()];

           }
    }

    0 => int del_continuous;
    
    fun void spork_del_continuous (int i) {
    
        del_continuous++;

	del_continuous => int ref_del_cont;
           // del first note (double play possible)
           if ((now % tick ()) > (tick() / 2)) {
								0. => g[(i+2)%g.size()];
								0 => slide[(i+2)%slide.size()];
								0. => g[(i+3)%g.size()];
								0 => slide[(i+3)%slide.size()];
					 }
           else {
								0. => g[i%g.size()];
								0 => slide[i%slide.size()];
								0. => g[(i+1)%g.size()];
								0 => slide[(i+1)%slide.size()];
						 }
     
            // sync to next tick
            tick() - now%tick() - 1::ms => now;
        
            while (del_continuous == ref_del_cont){
                i++;
                0. => g[i%g.size()];
                0 => slide[i%slide.size()];
                 0. => g[(i+1)%g.size()];
                0 => slide[(i+1)%slide.size()];
                 tick() => now;
            }
    }

    fun void stop(){
    
        adsr.keyOff();

        0 => suspend_control; // reset control to freq sequencer
       // <<<"STOP">>>;
    }
}




class lpd8_ext extends lpd8 {
 
//    rythm rythm_o;
//    rythm_o.constructor();
// rythm_o.bpm;


   
    0 => int rec_mode;
    
// NOTE
    data.scale.my_string => string scale;
   ( (data.ref_note $ int) /12 +2 ) *12  => int octave;
    data.ref_note % 12 => int note_offset;
    0 => int note;

 

// SYNT
    RecSeqFREQ f;
    f.freq => synt s1 => f.adsr => Gain g => global_mixer.line6;
    .48 => g.gain;

   f.adsr.set(2::ms, 15::ms, 0.85,10::ms);

// SLIDE
		slide sl => s1;


    fun void call_on() {
        while (1){
	    f.start_ev => now;
	    spork ~ s1.on();	
	}
    }
    
    fun void call_off() {
        while (1){
	    f.stop_ev => now;
	    spork ~ s1.off();	
	}
    }
    
    spork ~ call_on();
    spork ~ call_off();

    // Config seq and start it
    data.bpm  * granularity=> f.bpm;
    granularity * meas_nb * 2 => f.g.size  => f.note.size => f.slide.size; 
		f.rel_dur << 0. << 1.;

    f.go();


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

    0 => int play_on;	

    // PADS
    fun void pad_ext (int group_no, int pad_nb, int val) {
    	
	if (!hold_mode) {
	       36-=> pad_nb;
    	   // <<<"hey1", group_no, pad_nb, val>>>;
    	   if (group_no == 144) 
    	   {
    	       // <<<"hey2", group_no, pad_nb>>>;

    	       scales.conv_to_note(pad_nb, scale, octave + note_offset) => note;
    	   
    	       play_on ++;
    	       f.play_n_rec (note, rec_mode);	     
					   sl.activate();
    	       spork ~ s1.on();
    	   
    	   }
    	   else {
    		   
    		 play_on --;

    	       if (play_on < 1) {		   
    		   0=> f.rec_continuous;
    		   0=> f.del_continuous;
    		   f.stop();
					 sl.deactivate();
					// 0=> f.delta_slide;
    		   spork ~ s1.off();
    	       }
    	   }
       }
    }

    // POTARS
    fun void potar_ext (int group_no, int pad_nb, int val) {
    
	if (!hold_mode) {
        // <<<"hey3", group_no, pad_nb>>>;
            if (group_no == 176) {
        // <<<"hey4", group_no, pad_nb>>>;
//            0-=> pad_nb
                if (pad_nb  == 1) {
                    (val $ float) / 256. => g.gain; 
                
                }
                else if (pad_nb  == 2) {
                
                    if (val == 0) {
                        2 => rec_mode;
                        <<<"DELETE">>>;
                    }
                    else if (val < 40) {
                        4 => rec_mode;
                        <<<"DELETE CONTINUOUS">>>;                    
                    }
                    else if (val<80){
                        0 => rec_mode;
                        <<<"No rec Standby">>>;
                    }
                    else if (val < 126) {
                       3 => rec_mode;
                        <<<"REC CONTINUOUS">>>;                    
                    }
                    else {
                        1 => rec_mode;
                        <<<"REC">>>;
                    }
                
                }
                else if (pad_nb  == 3) {
                    (val / 12) * 12 => octave;
                    <<<"octave", octave, "offset", note_offset>>>;
                }
                else if (pad_nb  == 4) {
                    (val / 10)  => note_offset;
                    <<<"octave", octave, "offset", note_offset>>>;
                }
                else if (pad_nb  == 5) {
										sl.set(val, note) => f.delta_slide;
                }
								else if (pad_nb  == 6) {
                }

								else if (pad_nb  == 7) {
                }

								else if (pad_nb  == 8) {
                }
                  
                
            }
	    
	 }       
    }
}

lpd8_ext lpd;

// TEST
/*
    rythm rythm_o;
    rythm_o.constructor();


lpd.potar_ext (176, 2, 90); // rec continuous
rythm_o.tick_delay * .3 => now;

fun void test_note (int offset, float d){
lpd.pad_ext(144, 36+ offset , 127);
<<<"on">>>;
rythm_o.tick_delay * d => now;
lpd.pad_ext(0, 36+ offset , 0);
<<<"off">>>;
}

test_note (0, 2.);
rythm_o.tick_delay * 1 => now;

test_note (0, 1.);
rythm_o.tick_delay * 1 => now;

test_note (0, 1.);
rythm_o.tick_delay * 3 => now;

test_note (1, .5);
rythm_o.tick_delay * 1 => now;

test_note (3, .5);
rythm_o.tick_delay * 1 => now;

test_note (4, 1);
rythm_o.tick_delay * 1 => now;

rythm_o.tick_delay * 12.5 => now;
test_note (6, .5);

lpd.potar_ext (176, 2, 30); // delete continuous

rythm_o.tick_delay * 15.5 => now;
test_note (3, .5);


for(0=> int i; i< lpd.f.g.size(); i++){

<<<lpd.f.g[i], lpd.f.note[i]>>>;

}
*/

while (1) 1::second => now;

