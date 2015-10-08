public class TONE {

		SYNT synt[0];
    Envelope env[0];
    ADSR adsr[0];

    float scale[0];

    // input for all env
    Step one;
		1. => one.next;

    // Output for all synt and adsr
		Gain out  => Pan2 pan => dac;
    Gain raw_out;
    .2 => raw_out.gain;

    data.tick =>  dur base_dur;
    0.05 => float groove_ratio;
    0.3 => float init_gain;
    0.03 => float gain_step;
    -1. => float gain_to_apply;

    0. => float init_pan;
    0.1 => float pan_step;
    -2. => float pan_to_apply;
    
    1. => float init_rate;
    0.1 => float rate_step;
    -10. => float rate_to_apply;
    
    1. => float proba_to_apply;
    // PRIVATE
    0::ms => dur max_v;//private
    0::ms => dur remaining;//private
    0::ms => dur groove;
    
    SEQ3 s;
    data.wait_before_start => s.sync_offset;
    fun void no_sync()      {s.no_sync() ;}
    fun void element_sync() {s.element_sync();}
    fun void full_sync()    {s.full_sync();}
    

    fun void max(dur in){
        in => max_v => remaining;
    }

    fun dur set_dur(dur in_dur){// private
        dur res;
        if (max_v == 0::ms)
            return in_dur;
        else {
            if (in_dur >= remaining){
                remaining => res;
                0::ms => remaining;
            }
            else {
                in_dur => res;
                remaining - in_dur => remaining;
            }

            return res;
        }
    }



		fun void reg(SYNT @ in) {
        Envelope @ e;
        ADSR @ a;

  			synt << in;
        
        new Envelope @=> e;
        env << e;
        
        new ADSR @=> a;
        adsr << a;
        a.set(3::ms, 0::ms, 1., 3::ms);
        .2 => a.gain;

				one => e => in => a => out;
        in => raw_out;
		}

    // function to get audio out of object
    // only one of this to use at a time
    Gain mono_out;
    fun UGen mono() {
					out =< pan;
					out => mono_out;

        return mono_out;
    }

    Gain left_out;
    fun UGen left() {
				pan =< dac;
				pan.left => left_out;
        return left_out;
    }
    Gain right_out;
    fun UGen right() {
				pan =< dac;
				pan.right => right_out;
        return right_out;
    }

		// raw signal, no adsr
    fun UGen raw() {
				out =< pan;
				raw_out=> mono_out;

        return mono_out;
    }

    // ACTIONS

    class freq_synt extends ACTION {
        Envelope @ e;
        float f;
      
        fun int on_time() {
          f => e.value;
        }
    }
    
    fun ACTION set_freq_synt (Envelope @ e, float f) {
      new freq_synt @=> freq_synt @ act;
      f => act.f;
      e @=> act.e;

      return act;
    }

    class off_adsr extends ACTION {
      ADSR @ a;

        fun int on_time() {
          a.keyOff();
        }
    }
    fun ACTION set_off_adsr (ADSR @ a) {
      new off_adsr @=> off_adsr @ act;
      a @=> act.a;

      return act;
    }

    class on_adsr extends ACTION {
      ADSR @ a;

        fun int on_time() {
          a.keyOn();
        }
    }

    fun ACTION set_on_adsr (ADSR @ a) {
      new on_adsr @=> on_adsr @ act;
      a @=> act.a;

      return act;
    }

  fun int is_note(int c) {
		 if (((c >= '0') && (c <= '9')) || 
			   ((c >= 'a') && (c <= 'z')) ||
				 ((c >= 'A') && (c <= 'Z')))
				return 1;
		else
				return 0;

  }

  fun int convert_note(int c) {
		 if ((c >= '0') && (c <= '9')) 
			 return  c - '0';
		else if	 ((c >= 'a') && (c <= 'z')) 
			 return  c - 'a' + 10;
		else if	((c >= 'A') && (c <= 'Z'))
				 return -1 - (c - 'A');
		else
				return 1;

  }

  fun float conv_to_freq (int rel_note, float sc[], int ref_note) {
        int j, k;
        float distance_i;
        float result_i;

        if (sc.size() != 0) {
          if (rel_note == 0)
          {
            0 => distance_i;
          }
          else if (rel_note > 0)
          {
            0 => distance_i;
            for (0 => j; j<rel_note; j++)
            {
              sc[ j % sc.size()] +=> distance_i;
            }
          }
          else /* rel_note < 0 */
          {
            0 => distance_i;
            for (0 => j; j< -rel_note; j++)
            {
              sc.size() - 1 - (j % sc.size()) => k;
              sc[ k ] -=> distance_i;
            }
          }

          /* Convert Note */
          ref_note + distance_i => result_i;
        }
        else {
          ref_note + rel_note => result_i;
        }

        return Std.mtof(result_i);  
  }


    // seq
    fun void seq(string in) {
        0=> int i;
        int c;
        "0" => string note_id;
        ELEMENT @ e;

        dur dur_temp;

        // reset remaining
        max_v => remaining;

        // Create next element of SEQ
        new ELEMENT @=> e;

        while(i< in.length() ) {
            in.charAt(i)=> c;
            //            		<<<"c", c>>>;	
            if (c == ' ' ){
                // do nothing
            }
            else if ( is_note(c)  ) {
                
                convert_note(c) => int rel_note;
            
                // SET NOTE
                e.actions << set_freq_synt(env[0], conv_to_freq(rel_note, scale, data.ref_note)); 

                e.actions << set_on_adsr(adsr[0]); // TODO: manage other synt adsr
            
                    if (groove == 0::ms){
                        set_dur(base_dur) => dur_temp;
                    }
                    else if( s.elements.size() == 0) {
                        set_dur(base_dur) => dur_temp;
                        <<<"Not supported:  groove on first note">>>; 
                    }
                    else {
//                        <<<"groove:", groove/1::ms>>>; 
                        // add groove to last event
//                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                        groove +=> s.elements[s.elements.size() - 1].duration;
                        groove -=> remaining; // correct remaining
//                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                        // substract it to next one
                        set_dur(base_dur - groove) => dur_temp;
//                        <<<"dur_temp:", dur_temp/1::ms>>>;
                        // reset it
                        0::ms => groove;
                    }
                    if (dur_temp != 0::ms) {

                        dur_temp => e.duration;
                        // Add element to SEQ
                        s.elements << e;
                        // Create next element of SEQ
                        new ELEMENT @=> e;

                    }

            
            }
            else if (c == '_') {

                set_dur(base_dur) => dur_temp;
								
								if (dur_temp != 0::ms) {
									dur_temp => e.duration;

									// KeyOff all adsr
									for (0 => int i; i < adsr.size() ; i++) {
										e.actions << set_off_adsr(adsr[i]);                
									}

									// Add element to SEQ
									s.elements << e;
									// Create next element of SEQ
									new ELEMENT @=> e;
								}
            }
 



            i++;
        }

    }
    fun void go(){
        s.go();
    }

}
/*
// TEST
TONE t;
t.reg(HORROR h);
t.scale << 2<< 1<<2<<2<<1<<2<<2;
data.tick * 4 => t.max;
t.seq("4ae7____");
t.go();

//t.mono() => NRev r => dac;
//.3 => r.mix;
//  1 => t.pan.pan;
//  t.right() => dac;
		// TODO : TO REMOVE
//		220 => t.env[0].value;
//		t.adsr[0].keyOn();
//t.raw() => dac;
while(1) {
	     100::ms => now;
}

*/
