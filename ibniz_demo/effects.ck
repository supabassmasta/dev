     
 digit dig;

Gain dac_temp => Pan2 P;

P.left => Gain gain_left => dac.left;
P.right => Gain gain_right => dac.right;
gain_right.gain(1);
 
// DUCKING
Gain ducking;
ADSR duck;
4::ms => dur duck_attack;
120::ms => dur duck_release;
duck.set (duck_release, 0::ms, 1, duck_attack);
duck.keyOn();

ducking => Gain remaining => dac_temp;
remaining.gain (0.1);

// SAMPLER

1=> int last_sampler_group;


class nano_sampler extends Chubgraph {
    9 => int nb_sp;
    sampler sp[nb_sp];
    ADSR    a[nb_sp];
    dur length;

   1 =>  int bypass_connected;

   inlet => Gain in => Gain bypass => outlet;
    for (0=>int i; i< nb_sp; i++){
     in => sp[i].connect => a[i] => outlet;
    a[i].keyOn();
       a[i].set(3::ms, 0::ms, 1, 3::ms);
    }   

    fun void set_dur (dur in) {
            in => length;
        for (0=>int i; i< nb_sp; i++){
        in => sp[i].max;
        in => sp[i].length;
        }
    }

    fun void on(int group, int on){
    if (on == 0) a[group -1].keyOff();
    else a[group -1].keyOn();
   }

   fun void add (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
   
        sp[group - 1].add();

        // Disconnet bypass while sampling
        in =< bypass;
				0=> bypass_connected;


   }
 
   fun void close (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
       
        // reconnect bypass when smapling is over
		if (!bypass_connected){
	        in => bypass;
				1=> bypass_connected;
    }

   }

   fun void remove_last (int group) {
           sp[group - 1].remove_last ();
   }
}


// EFFECT PATH 
 
Gain dig_in => disto dist => dig.connect => Gain tampon_phaser => PRCRev rev1 => PRCRev rev2 => Gain tampon => Gain tampon_in => Gain tampon_out => Gain tampon_bpf => LPF filt=> Gain out_effect => nano_sampler sp =>  ducking => duck =>  dac_temp;

sp.set_dur(8 * data.tick);


Std.mtof(127)=> filt.freq;

// ECHO GENERAL
tampon_out => Delay feed_back => tampon_out;
feed_back.gain(0);
15::second => feed_back.max;
data.tick => feed_back.delay ;

// REVERB
0 => rev1.mix => rev2.mix;


// ECHO SNARE
/* Gain input_snare => Gain tampon_snare => dig_in;
tampon_snare => Delay feed_back_snare => tampon_snare ;
feed_back_snare.gain(0);
3::second => feed_back_snare.max;
rythm_o.tick_delay => feed_back_snare.delay ;
*/


// BPF
tampon_out => BPF bpf_0 => out_effect;
bpf_0.Q (1);
bpf_0.freq (400);
bpf_0.gain (0);

tampon_out => BPF bpf_1 => out_effect;
bpf_1.Q (4);
bpf_1.freq (400);
bpf_1.gain (0);

tampon_out => BPF bpf_2 => out_effect;
bpf_2.Q (6);
bpf_2.freq (400);
bpf_2.gain (0);


fun void duck_run () {
    // sync
    // 2*rythm_o.tick_delay - (now % (2*rythm_o.tick_delay)) => now;

    while(1) {
    
        global_mixer.duck_trig => now;
        duck.keyOff();
        duck_attack => now;
        duck.keyOn();
    
        // duck_attack => now;
        // duck.keyOn();
        // 2*rythm_o.tick_delay - duck_attack => now;
        // duck.keyOff();
    }
    
}

spork ~  duck_run ();

// INIT inputs to dac_temp
global_mixer.line1 => dac_temp; // DIRECT NO EFFECT
global_mixer.line2 => dac_temp; // DIRECT NO EFFECT
global_mixer.line3 => ducking; // 
global_mixer.line4 => ducking; // 
global_mixer.line5 => ducking; // 
global_mixer.line6 => ducking; // 
// Stereo
global_mixer.stereo1 => gain_left;
global_mixer.stereo2 => gain_right;


 
/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
	 if (bank == 1 && group == 1) {
		Std.mtof(val)   => filt.freq;          
          
           }
        if (bank == 1 && group == 2) {
           
               if (val == 0) 1::samp => dig.ech;
               else {
                    (1./Std.mtof(127-val))::second => dig.ech;
               }
           
           }
      if (bank == 1 && group == 3) {
          (val + 1) * data.tick /8.  => feed_back.delay ;
          
           }

  	// REV
         if (bank == 1 && group == 4) {
	 
	 	val $ float / 256. => rev2.mix;
	 
//          	(val/4 + 1) * rythm_o.tick_delay / 2 => feed_back_snare.delay ;
	}

	// SAMPLER DUR
         if (bank == 1 && group == 5) {
		Math.pow (2, (val/16)) $ int => int nb_tick;
		sp.set_dur(nb_tick * data.tick);
		<<<"sampler dur =", 	nb_tick	, "* rythm_o.tick_delay">>>;
	}



	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain_in;          
          
           }
	// BPF
	 if (bank == 1 && group == 7) {
		Std.mtof(val)   => bpf_0.freq;          
          
           }
	 if (bank == 1 && group == 8) {
		Std.mtof(val)   => bpf_1.freq;          
          
           }
	 if (bank == 1 && group == 9) {
		Std.mtof(val)   => bpf_2.freq;          
          
           }

       
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;

if (bank == 1 ) {
        if (group == 1) {
          	(val $ float)/127   => out_effect.gain;
           }
        else if (group == 2) {
            (val $ float) / 1270. => dig.quant;
        }
        else  if (group == 3) {
            (val $ float) / 127. => feed_back.gain;
        }
	// REVERB
        else  if ( group == 4) {
	 	val $ float / 256. => rev1.mix;
//            (val $ float) / 127. => feed_back_snare.gain;
        }

        else  if (group ==5) {
        }
	

	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain;          
          
           }

	// BPF
        else  if (group == 7) {
            (val $ float) * 4 / 127. => bpf_0.gain;
        }
        else  if (group == 8) {
            (val $ float) * 4 / 127. => bpf_1.gain;
        }
        else  if (group == 9) {
            (val $ float) * 10 / 127. => bpf_2.gain;
		
        }
   }
   else if (bank == 2 ) {
	(val $ float)/127. * 4 => sp.a[group - 1].gain;

   }


   }
     

    fun void button_down_ext (int bank, int group, int val) {
        <<<"button down ", bank, group," : ",val>>>;
	if (bank == 1 && group == 1){
            // if (val != 0) {
                // global_mixer.line1 =< dac_temp; 
                // global_mixer.line1 => dig_in;  
            // }
            // else {
                // global_mixer.line1 =< dig_in; 
                // global_mixer.line1 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 2){
            // if (val != 0) {
                // global_mixer.line2 =< dac_temp; 
                // global_mixer.line2 => dig_in;  
            // }
            // else {
                // global_mixer.line2 =< dig_in; 
                // global_mixer.line2 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 3){
            if (val != 0) {
                global_mixer.line3 =< ducking; 
                global_mixer.line3 => dig_in;  
            }
            else {
                global_mixer.line3 =< dig_in; 
                global_mixer.line3 => ducking;  
            }
        }
        else if (bank == 1 && group == 4){
            if (val != 0) {
                global_mixer.line4 =< ducking; 
                global_mixer.line4 => dig_in;  
            }
            else {
                global_mixer.line4 =< dig_in; 
                global_mixer.line4 => ducking;  
            }
        }
        else if (bank == 1 && group == 5){
            if (val != 0) {
                global_mixer.line5 =< ducking; 
                global_mixer.line5 => dig_in;  
            }
            else {
                global_mixer.line5 =< dig_in; 
                global_mixer.line5 => ducking;  
            }
        }
        else if (bank == 1 && group == 6){
            if (val != 0) {
                global_mixer.line6 =< ducking; 
                global_mixer.line6 => dig_in;  
            }
            else {
                global_mixer.line6 =< dig_in; 
                global_mixer.line6 => ducking;  
            }
        }
        else if (bank == 2 ){
		sp.on(group, val);
	}
	

    }

// AUTO ECHO
0=> int echo_on_flag;

fun void echo_on (dur duration){
	//tampon_out => Delay feed_back => tampon_out;
	//feed_back.gain(0);
	
	feed_back.delay (1::ms);
	feed_back.gain(0);
	1::ms => now;

	1=> echo_on_flag;

	3 * data.tick => feed_back.delay ;
	feed_back.gain(.8);

	duration => now;

	if (echo_on_flag){
		feed_back.gain(1);
		tampon_in.gain(0);
	}
}

fun void echo_off (){

	0=> echo_on_flag;
	feed_back.gain(0);
	tampon_in.gain(1);
}


    fun void button_up_ext (int bank, int group, int val) {
/*       if (bank == 1 && group == 3){
            if (val != 0) {
                spork ~ echo_on(3::second);  
            }
	    else {
                spork ~ echo_off();  
            }
	}*/

        <<<"button up ", bank, group," : ",val>>>;
	if (bank == 1 || bank == 2){
	    if (val == 0) {
		sp.close (group);
	    }
	    else {
		 sp.add (group);
		// close last group to avoid simultaneous multi sampling
/*		if (last_sampler_group != 0 && last_sampler_group != group) {
		    <<< "FORCED CLOSE", last_sampler_group, group >>>;
		    sp.close (last_sampler_group);
		}
*/

		    group => last_sampler_group;


	    }
        }





    }     
    
    fun void button_rec_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
        	<<<"Add new buffer on sampler: ",last_sampler_group>>>;
	        sp.add (last_sampler_group);
        }
    }

    fun void button_loop_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
	      <<<"remove last buffer  on sampler: ",last_sampler_group>>>;
		sp.remove_last(last_sampler_group);
        } 
     }

// SAMPLE one meas

fun void stop_sample_meas (int g){
    sp.sp[0].length => now;       
        sp.close (g);
}


    fun void button_forward_ext (int val) {
         if (val != 0 && last_sampler_group!=0) {
                    <<<"Sample one meas on sampler: ", last_sampler_group>>>;
                sp.add (last_sampler_group);
                    spork ~ stop_sample_meas(last_sampler_group );
             }
            }

// STOP sampling

    fun void button_stop_ext (int val) {
			<<<"TOTO">>>;
            if (val != 0 && last_sampler_group!=0) {
                 <<<"Stop sampling on sampler:", last_sampler_group>>>;
                 sp.close (last_sampler_group);
             }           
        }

}


nanomidi_ext nano;
nano.start_midi_rcv();
<<<"Effects">>>;
