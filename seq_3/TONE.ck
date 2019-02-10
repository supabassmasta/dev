  class freq_synt extends ACTION {
    Envelope @ e;
    float f;

    fun int on_time() {
      f => e.value;
    }
  }

  class off_adsr extends ACTION {
    PowerADSR @ a;

    fun int on_time() {
      a.keyOff();
    }
  }

  class on_adsr extends ACTION {
    PowerADSR @ a;

    fun int on_time() {
      a.keyOn();
    }
  }

  class gain_adsr extends ACTION {
    PowerADSR @ a;
    float g;

    fun int on_time() {
      g => a.gain;
    }
  }

  class pan_action extends ACTION {
    Pan2 @ p;
    float v;
    fun int on_time() {
      v => p.pan;
    }
  }

  class synt_on extends ACTION {
    SYNT @ s;
    fun int on_time() {
      s.on();
    }
  }

  class synt_off extends ACTION {
    SYNT @ s;
    fun int on_time() {
      s.off();
      //            <<<"synt_off">>>; 
    }
  }

  class synt_new_note extends ACTION {
    SYNT @ s;
    int index;
    fun int on_time() {
      s.new_note(index);
    }
  }

 class slide_act extends ACTION {
    Envelope @ e;
    float f;
    dur s_dur;

    fun int on_time() {
      f => e.target;
      s_dur => e.duration;
    }
  }

  class note_info_act extends ACTION {
    note_info_tx @ note_info_tx_p;
    ELEMENT @ e;

    fun int on_time() {
      note_info_tx_p.push_to_all( e.note_info_s );
    }

  }
  
  class index {
    // interal
    0=> int state;
    0=> int value_i;

    // public
    fun void up(){
      2 => state;
      value_i + 1 => value_i;
    }

    fun int value () {
      state - 1 => state;
      if (state <=0) {
        0=> value_i;
        0=> state;
      }

      return value_i;
    }


    fun void reset (){
      0=> state;
      0=> value_i;
    }
  }

  class END extends end { 
    SEQ3 @ s; 
    0=> int force_off_actions;
    0::ms => dur extra_end;

    fun void kill_me () {
      <<<"THE END">>>;	
      // Mute seq
      0 => s.on;
      if ( force_off_actions  ){
          s.play_off_actions(0);
      }
      // Wait seq duration before diing (not optimal)
      s.duration + extra_end => now;		
			// let "go" shred exit by herself 
		  1=>s.exit;
      s.duration => now;		

//      Machine.remove(s.id_go.id());
//      10::ms => now;
      <<<"THE real END">>>;		
    }
  }; 

public class TONE extends ST {

  SYNT synt[0];
  Envelope env[0];
  PowerADSR adsr[0];
  int on_state[0];
  float freq[0];
  float scale[0];

  // input for all env
  Step one;
  1. => one.next;

  // Output for all synt and adsr
  Gain out  => Pan2 pan ;
  pan.right => outr ; // got to dac via ST class
  pan.left => outl ;
  Gain raw_out;
//  .2 => raw_out.gain;

  fun void gain(float in) {
    in => out.gain => raw_out.gain;
  }

  data.ref_note => int base_note;
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

  0 => int note_offset;

  // Note information service
  note_info_tx note_info_tx_o;

  // PRIVATE
  0::ms => dur max_v;//private
  0::ms => dur remaining;//private
  0::ms => dur groove;

  SEQ3 s;
  MASTER_SEQ3.reg(s);
  data.wait_before_start => s.sync_offset;
  fun void no_sync()      {s.no_sync() ;}
  fun void element_sync() {s.element_sync();}
  fun void full_sync()    {s.full_sync();}
  fun void sync(dur d)    {s.sync(d);}

  0::ms => dur glide;

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
    PowerADSR @ a;

    synt << in;

    new Envelope @=> e;
    env << e;

    new PowerADSR @=> a;
    adsr << a;
    a.set(3::ms, 0::ms, 1., 3::ms);
    a.setCurves(2.0, 2.0, .5);
    init_gain => a.gain;

    if (in.own_adsr) {
      one => e => in => out;
    }
    else {
      one => e => in => a => out;
    }
    in => raw_out;

    on_state << 0;
    freq << 0;
  }

  // function to get audio out of object
  // only one of this to use at a time
  /*
  0 => int mono_out_active; 
  Gain mono_out;
  fun UGen mono() {
    if (!mono_out_active) {
      1 => mono_out_active;
      out =< pan;
      out => mono_out;
    }

    return mono_out;
  }
*/
  //Now defined in ST
  /*
  0=> int left_out_active;
  Gain left_out;
  fun UGen left() {
    if (!left_out_active) {
      pan =< dac;
      pan.left => left_out;
      1 => left_out_active;
    }
    return left_out;
  }
  
  0 => int right_out_active;
  Gain right_out;
  fun UGen right() {
    if (!right_out_active) {
      pan =< dac;
      pan.right => right_out;
      1 => right_out_active; 
    }
    return right_out;
  }
*/

  // raw signal, no adsr
  0 => int raw_out_active;
  fun UGen raw() {
    if (!raw_out_active) {
      out =< pan;
//      raw_out=> mono_out;
      1 => raw_out_active;
    }

    return raw_out;
  }

  /////////// ACTIONS ////////////////

  fun ACTION set_freq_synt (Envelope @ e, float f) {
    new freq_synt @=> freq_synt @ act;
    f => act.f;
    e @=> act.e;
    "freq_synt" + "  " + e.toString() + "  " + f => act.name;

    return act;
  }

  fun ACTION set_off_adsr (PowerADSR @ a) {
    new off_adsr @=> off_adsr @ act;
    a @=> act.a;
    "off_adsr  " + a.toString() => act.name;
    return act;
  }

  fun ACTION set_on_adsr (PowerADSR @ a) {
    new on_adsr @=> on_adsr @ act;
    a @=> act.a;
    "on_adsr  " + a.toString() => act.name;

    return act;
  }

  fun ACTION set_gain_adsr (PowerADSR @ a, float g) {
    new gain_adsr @=> gain_adsr @ act;
    a @=> act.a;
    g => act.g;
    "gain_adsr  " + a.toString() + "  " + g => act.name;
    return act;
  }

  fun ACTION set_pan(Pan2 @ p, float v) {
    new pan_action @=> pan_action @ act;
    p @=> act.p;
    v => act.v;
    "pan_action  " + p.toString() + "  " + v => act.name;
    return act;
  }

  fun ACTION set_synt_on( SYNT @ s ) {
    new synt_on @=> synt_on @ act;
    s @=> act.s;

    "synt_on  " + s.toString() => act.name;
    return act;
  }

  fun ACTION set_synt_off( SYNT @ s ) {
    new synt_off @=> synt_off @ act;
    s @=> act.s;
    "synt_off  " + s.toString() => act.name;
    return act;
  }

  fun ACTION set_synt_new_note( SYNT @ s, int index ) {
    new synt_new_note @=> synt_new_note @ act;
    s @=> act.s;
    index => act.index;
    "synt_new_note  " + s.toString() + "  index " + index => act.name;

    return act;
  }

 
  fun ACTION set_slide(Envelope @ e, float f, dur s_dur) {
    new slide_act @=> slide_act @ act;
    e @=> act.e;
    f => act.f;
    s_dur => act.s_dur;
    "slide_act  " + e.toString() + "  dur " + s_dur/data.tick + " target " + f => act.name;
    return act;
  }

  fun ACTION set_note_info_act(note_info_tx @ nitp, ELEMENT @ e) {
    new note_info_act @=> note_info_act @ act;
    
    e @=> act.e;
    nitp @=> act.note_info_tx_p;

    "note_info_act " + e.toString() + " ST " + nitp.toString() => act.name;
    return act;
  }
  //////// NOTE MANAGEMENT ///////////////

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

  fun float conv_to_freq (int rel_note, float sc[], int ref_note, int offset /* for sharp and bemol*/) {
    int j, k;
    float distance_i;
    float result_i;

    // Set 1 as ref note to have classic scale notation: first, third, fifth etc...
    rel_note - 1 => rel_note;

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
      ref_note + distance_i + offset => result_i;
    }
    else {
      ref_note + rel_note => result_i;
    }

    return Std.mtof(result_i);  
  }




  ///////// seq ///////////////
  fun void seq(string in) {
    0=> int i;
    int c;
    "0" => string note_id;
    ELEMENT @ e;
    ELEMENT @ e_glide;

    dur dur_temp;
    index idx;
    index slide;
    int slide_nb;
    dur slide_dur;

    float temp_freq;
    0 => int force_new_note;

    int on_state_on_start[0];
    float first_note_freq;

    on_state.size() => on_state_on_start.size;

    // reset remaining
    max_v => remaining;

    // Create next element of SEQ

    while(i< in.length() ) {
      in.charAt(i)=> c;
      //            		<<<"c", c>>>;	
      if (c == ' ' ){
        // do nothing
      }
      else if ( is_note(c)  ) {
        // Get index
        idx.value() => int id;
        //                <<<"index:", id, "note", c>>>; 
        if (id >= synt.size()){
          <<<"Not enough synt registered, default synt 0 used">>>;
          0 => id;
        }
        // BRAND NEW element
        if (id == 0) {
          slide.value() => slide_nb;
          // if slide, dont create a new element we will increase the new one
          if (slide_nb ==0) {
            new ELEMENT @=> e;
            e.actions << set_note_info_act(note_info_tx_o ,e);
            // Search synt that are not on anymore
            for (0 => int i; i < on_state.size()      ; i++) {
              if (on_state[i] !=0) {
                on_state[i] - 1 => on_state[i];
                if (on_state[i] <= 0 ){
                  0 => on_state[i];
                  s.elements[s.elements.size() - 1].actions << set_off_adsr(adsr[i]);
                  s.elements[s.elements.size() - 1].actions << set_synt_off(synt[i]);
                }
              }
            }
          }

        }

        ///// PARAMS //////////////////
        // set new GAIN if needed
        if (gain_to_apply != -1) {
          e.actions << set_gain_adsr (adsr[id], gain_to_apply);
          -1. => gain_to_apply;
        }
        if (pan_to_apply != -2) {
          e.actions << set_pan(pan, pan_to_apply);
          -2. => pan_to_apply;
        }


        /////////// NOTE ////////////
        convert_note(c) => int rel_note;

        // SET NOTE
        conv_to_freq(rel_note, scale, base_note, note_offset) => temp_freq;
        
        // save firt note freq for last glide
        if (id == 0 && s.elements.size() == 0){
          temp_freq => first_note_freq;
        }
        
        0=> note_offset;

        if (slide_nb) {

          if (id == 0) {
            // Get current element size at least
            e.duration => slide_dur; 
            // add it remaining duration of the slide using set_dur()
            set_dur((slide_nb-1) * base_dur) + slide_dur => slide_dur;
            // update element duration
            slide_dur => e.duration;
            e.duration => e.note_info_s.d;
          }

          e.actions << set_slide(env[id], temp_freq, slide_dur); 
          temp_freq => freq[id];

        }
        else
        {
          e.actions << set_synt_new_note(synt[id], s.elements.size()); 
          s.elements.size() => e.note_info_s.idx;
          // Add freq_synt action every time in case SEQ3 start here
          e.actions << set_freq_synt(env[id], temp_freq ); 
          if (temp_freq != freq[id]) {
            temp_freq => freq[id];

            if (glide != 0::ms && on_state[id] != 0 && s.elements.size() != 0 ) {
              // only available for synt 0 for the moment
              if (id == 0) {
                // split element N-1
                if (glide < s.elements[s.elements.size() - 1].duration ) {
                  // Reduce N-1
                  s.elements[s.elements.size() - 1].duration - glide => s.elements[s.elements.size() - 1].duration;

                  // add new element for glide
                  new ELEMENT @=> e_glide;
                  e_glide.actions << set_slide(env[id], temp_freq , glide);
                  glide => e_glide.duration;
                  s.elements << e_glide;
                  // set on action if seq start by glide event
                  e_glide.on_actions << set_on_adsr(adsr[id]); 
                  e_glide.on_actions << set_synt_on(synt[id]); 
               }
                else {
                  <<<"Glide too long compared to note: discarded">>>;  
                }

              }

            }

          }

          // Managa note on for first note at the end, once we now the last note
          if(!( s.elements.size() == 0 ||
						  s.elements[0] == e) ){

            if (on_state[id] == 0) {
              e.actions << set_on_adsr(adsr[id]); 
              e.actions << set_synt_on(synt[id]); 
              1 => e.note_info_s.on;
            }
            else {
              // Manage on_actions
              // synt already on but we need to on it if the seq start here
              e.on_actions << set_on_adsr(adsr[id]); 
              e.on_actions << set_synt_on(synt[id]); 
              // also set freq and new note
              e.actions << set_freq_synt(env[id], freq[id] ); 
              e.actions << set_synt_new_note(synt[id], s.elements.size()); 
              s.elements.size() => e.note_info_s.idx;

            }
          }

          // Store that synt is on
          2 => on_state[id];

          // Remember it was on on first element
				  if( s.elements.size() == 0 ||
						  s.elements[0] == e){
            2 => on_state_on_start[id];
          }

          if (force_new_note != 0){
            e.actions << set_synt_new_note(synt[id], s.elements.size()); 
            s.elements.size() => e.note_info_s.idx;
            e.actions << set_on_adsr(adsr[id]); 
            e.actions << set_synt_on(synt[id]); 
            0 => force_new_note;
            1 => e.note_info_s.on;
          }


          if ( id == 0 ) {
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
            if (dur_temp != 0::ms ) {

              dur_temp => e.duration;
              e.duration => e.note_info_s.d;
              // Add element to SEQ
              s.elements << e;

            }
          }

        }

      }
      else if (c == '_') {

				if( s.elements.size() == 0){
            // Remember that all synt are off on start
            for (0 => int j; j < on_state_on_start.size() ; j++) {
              0 => on_state_on_start[j];
            }

				}

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
          new ELEMENT @=> e;
          e.actions << set_note_info_act(note_info_tx_o ,e);
          dur_temp => e.duration;
          e.duration => e.note_info_s.d;
          0 => e.note_info_s.on;

          // KeyOff all adsr
          for (0 => int j; j < adsr.size() ; j++) {
            if (on_state[j] != 0) {
              e.actions << set_off_adsr(adsr[j]);                
              e.actions << set_synt_off(synt[j]);                
              0 => on_state[j];
            }
          }

          // Restart on first synt for next action
          idx.reset();
          // no target: reset slide
          slide.reset();
          // Add element to SEQ
          s.elements << e;
        }
      }
      else if (c == '|') {
        // Next instruction is for synt+1
        idx.up();

      }
      else if (c == '/') {
        // increase slide value
        slide.up();

      }
      else if (in.charAt(i) == '*') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_dur / ( (c - '0') $ float) => base_dur;
        }
      }
      else if (in.charAt(i) == ':') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_dur * ( (c - '0') $ float) => base_dur;
        }
      }
      else if (in.charAt(i) == '+') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          if (gain_to_apply == -1.)
            init_gain + gain_step * (c -'0') $ float =>  gain_to_apply;
          else
            gain_step * (c -'0') $ float +=>  gain_to_apply;
        }
        else {
          if (gain_to_apply == -1.)
            init_gain + gain_step  =>  gain_to_apply;
          else
            gain_step  +=>  gain_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '-') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          if (gain_to_apply == -1.)
            init_gain - gain_step * (c -'0') $ float =>  gain_to_apply;
          else
            gain_step * (c -'0') $ float -=>  gain_to_apply;
        }
        else {
          if (gain_to_apply == -1.)
            init_gain - gain_step  =>  gain_to_apply;
          else
            gain_step  -=>  gain_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '<') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_dur * groove_ratio * (c -'0') $ float -=> groove;
        }
        else {
          base_dur * groove_ratio   -=> groove;
          i--;
        }
      }
      else if (in.charAt(i) == '>') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_dur * groove_ratio * (c -'0') $ float +=> groove;
        }
        else {
          base_dur * groove_ratio  +=> groove;
          i--;
        }
      }
      else if (in.charAt(i) == '(') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          if (pan_to_apply == -2.)
            init_pan - pan_step * (c -'0') $ float =>  pan_to_apply;
          else
            pan_step * (c -'0') $ float -=>  pan_to_apply;
        }
        else {
          if (pan_to_apply == -2.)
            init_pan - pan_step  =>  pan_to_apply;
          else
            pan_step  -=>  pan_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == ')') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          if (pan_to_apply == -2.)
            init_pan + pan_step * (c -'0') $ float =>  pan_to_apply;
          else
            pan_step * (c -'0') $ float +=>  pan_to_apply;
        }
        else {
          if (pan_to_apply == -2.)
            init_pan + pan_step  =>  pan_to_apply;
          else
            pan_step  +=>  pan_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '{') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_note - (c -'0') => base_note;
        }
        else if	 ((c >= 'a') && (c <= 'z')) {
          base_note - (c -'a') - 10 => base_note;
        }
        else {
          base_note - 1 => base_note;
          i--;
        }
      }
      else if (in.charAt(i) == '}') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          base_note + (c -'0') => base_note;
        }
        else if	 ((c >= 'a') && (c <= 'z')) {
          base_note + (c -'a') + 10 => base_note;
        }
        else {
          base_note + 1 => base_note;
          i--;
        }
      }
      else if (in.charAt(i) == '!') {
        1 => force_new_note;
      }
      else if (in.charAt(i) == '#') {
        // Sharp implemenation
        note_offset ++;
      }
      else if (in.charAt(i) == '^') {
        // bemol implemenation
        note_offset --;
      }



      i++;
    }

    // Manage last and first note
    for (0 => int j; j < adsr.size() ; j++) {
      if (on_state[j] != 0 && on_state_on_start[j] == 0) {
      // KeyOff all adsr that are not on in first element
        s.elements[0].actions << set_off_adsr(adsr[j]);                
        s.elements[0].actions << set_synt_off(synt[j]);                
        0 => on_state[j];
      }
      else if (on_state[j] == 0 && on_state_on_start[j] != 0) {
        // synt off on last, On on first
        s.elements[0].actions << set_on_adsr(adsr[j]);                
        s.elements[0].actions << set_synt_on(synt[j]);                
        1 => s.elements[0].note_info_s.on;
      }
      else if (on_state[j] != 0 && on_state_on_start[j] != 0) {
        // Manage on_actions
        // synt already on but we need to on it if the seq start here
        s.elements[0].on_actions << set_on_adsr(adsr[j]); 
        s.elements[0].on_actions << set_synt_on(synt[j]); 


        // Need to do a glide here
        // only available for synt 0 for the moment
        if (j== 0 && glide != 0::ms ) {
          // split element N-1
          if (glide < s.elements[s.elements.size() - 1].duration ) {
            // Reduce N-1
            s.elements[s.elements.size() - 1].duration - glide => s.elements[s.elements.size() - 1].duration;

            // add new element for glide
            new ELEMENT @=> e_glide;
            e_glide.actions << set_slide(env[j], first_note_freq , glide);
            glide => e_glide.duration;
            s.elements << e_glide;
            // set on action if seq start by glide event
            e_glide.on_actions << set_on_adsr(adsr[j]); 
            e_glide.on_actions << set_synt_on(synt[j]); 
          }
          else {
            <<<"Glide too long compared to note: discarded">>>;  
          }

        }

      }
    }



    // remaining
    if (remaining != 0::ms) {
      new ELEMENT @=> e;
      e.actions << set_note_info_act(note_info_tx_o ,e);
 
      remaining => e.duration;
      e.duration => e.note_info_s.d;


      s.elements << e;

    }

      // manage off actions
      for (0 => int j; j < s.elements.size() ; j++) {
        // if off seq is requested: off all synt 
				for (0 => int k; k < synt.size()     ; k++) {
          s.elements[j].off_actions << set_off_adsr(adsr[k]);                
          s.elements[j].off_actions << set_synt_off(synt[k]);                
				}
      }

  }

  fun void on(int in) {
    in => s.on;
  }

  END the_end;   
  s @=> the_end.s;

  fun void extra_end(dur in) {
    in => the_end.extra_end;
  }
  fun void force_off_action(){
    1=>the_end.force_off_actions;
  }

  fun void go(){
    // Get id from caller shred
    me.id() => the_end.shred_id;
    //  register end
    killer.reg(the_end);

    s.go();
  }

  fun void on(int in) {
		in => s.on;
	}

  fun void print() {
    s.print();
  }

  // Scales section
  fun void lyd () {
    // remove previous scale 
    0 => scale.size;
    scale << 2 << 2 << 2 << 1 << 2 << 2 << 1;
  }
  fun void ion () {
    // remove previous scale 
    0 => scale.size;
    scale <<2 << 2 << 1 << 2 << 2 << 2 << 1;
  }
  fun void mix () {
    // remove previous scale 
    0 => scale.size;
    scale << 2 << 2 << 1 << 2 << 2 << 1 << 2;
  }
  fun void dor () {
    // remove previous scale 
    0 => scale.size;
    scale <<2 << 1 << 2 << 2 << 2 << 1 << 2;
  }
   fun void aeo () {
    // remove previous scale 
    0 => scale.size;
    scale << 2 << 1 << 2 << 2 << 1 << 2 << 2;
  }
  fun void phr () {
    // remove previous scale 
    0 => scale.size;
    scale <<1 << 2 << 2 << 2 << 1 << 2 << 2;
  }
  fun void loc () {
    // remove previous scale 
    0 => scale.size;
    scale << 1 << 2 << 2 << 1 << 2 << 2 << 2;
  }










}
/*
// TEST

class synt0 extends SYNT{

    inlet => ADSR a_mod => SinOsc s => ADSR a_out =>   outlet;   
    a_out.set(10::ms, 10::ms, .8, 500::ms);
//    a_out.keyOff();
        .7 => s.gain;
    a_mod.set(80::ms, 80::ms, 0.5, 180::ms);
    a_mod.gain(2.);

            fun void on()  {a_out.keyOn();  
//            <<<"synt on iii">>>;
            }  
            
            fun void off() {
            a_out.keyOff();
//            a_mod.keyOff();
//           <<<"synt off iii">>>; 
           } 
            
            fun void new_note(int idx)  { a_mod.keyOn();  }
} 

class synt extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt s1);
t.reg(synt s2);
t.reg(synt s3);
//t.reg(synt0 s2);
//t.reg(synt0 s3);
t.scale << 2<< 1<<2<<2<<1<<2<<2;
//data.tick * 4 => t.max;
//t.seq("0|+0a0|-6a");
//t.seq("*8 {c (9 0_ )9 1_ (9 2_ )9 3_ (9 4_ )9 5_   (9 6_ )9 7_ ");
//t.seq(" }c (9 0_ )9 1_ (9 2_ )9 3_ (9 4_ )9 5_   (9 6_ )9 7_ ");
//t.seq(" }c (9 0_ )9 1_ (9 2_ )9 3_ (9 4_ )9 5_   (9 6_ )9 7_ ");
//t.seq("*4 }9}}} }9}}} (9 0_ )9 0_ ");
//t.seq("*4 7_7_0|4|7 0|4|7__  4___ }5 0|3|7 0|3|7_{5a");
//t.seq("*4 ____0|4|7 0|4|7__  ____ }5 0|3|7 0|3|7_{5_");
//t.seq("0|7//4|0_0//4_7//0_");
100::ms => t.glide;
t.seq("0a00/b00G5");
t.print();
//4* data.tick => t.max;
//t.seq("*4 0/q0/q0/q0/q0/q __ a\\0_ a\\0_ a\\0  491058FJANC3pdoa_________");
//t.seq("0|7//4_");
//t.seq("0//4");
//t.seq("7//0");
//t.raw() => dac;
t.element_sync();
//t.no_sync();
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
