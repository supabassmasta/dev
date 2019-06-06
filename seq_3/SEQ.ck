class note_info_act extends ACTION {
    note_info_tx @ note_info_tx_p;
    ELEMENT @ e;

    fun int on_time() {
      note_info_tx_p.push_to_all( e.note_info_s );
    }

  }

   class END extends end { 
    SEQ3 @ s; 
    0::ms => dur extra_end;
    0::ms => dur fixed_end_dur;
    
    fun void kill_me () {
      <<<"THE END">>>;	
      // Mute seq
      0 => s.on;
      if ( fixed_end_dur != 0::ms  ){
          fixed_end_dur => now;
          1=>s.exit;
      }
      else {
        // Wait seq duration before diing (not optimal)
        s.duration +  extra_end => now;		
      }
      <<<"THE real END">>>;		
    }
  }; 
 
public class SEQ extends ST{
  // PUBLIC 
  string wav[0];
  ACTION @ action[0];
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

  // Note information service
  note_info_tx note_info_tx_o;

  // PRIVATE
  0::ms => dur max_v;//private
  0::ms => dur remaining;//private
  0::ms => dur groove;
  WAV wav_o[0]; // private
  WAV wav_o_byindex[0]; // use to access all wavs
  SEQ3 s;
  MASTER_SEQ3.reg(s);
  data.wait_before_start => s.sync_offset;
  fun void no_sync()      {s.no_sync() ;}
  fun void element_sync() {s.element_sync();}
  fun void full_sync()    {s.full_sync();}
  fun void sync(dur d)    {s.sync(d);}



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

  fun ACTION set_note_info_act(note_info_tx @ nitp, ELEMENT @ e) {
    new note_info_act @=> note_info_act @ act;
    
    e @=> act.e;
    nitp @=> act.note_info_tx_p;

    "note_info_act " + e.toString() + " ST " + nitp.toString()=> act.name;
    return act;
  }


  fun void seq(string in) {
    0=> int i;
    int c;
    "0" => string note_id;
    ELEMENT @ e;
    WAV @ w0;
    0 => int autonomous;

    dur dur_temp;

    // reset remaining
    max_v => remaining;

    // Create next element of SEQ
    new ELEMENT @=> e;
    e.actions << set_note_info_act(note_info_tx_o ,e);

    while(i< in.length() ) {
      in.charAt(i)=> c;
      //            		<<<"c", c>>>;	
      if (c == ' ' ){
        // do nothing
      }
      else if ( ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z')) ) {
        note_id.setCharAt(0, c); 
        if ( wav[note_id] != NULL ){
          if (!autonomous) {
            // Normal case
            if (wav_o[note_id] == NULL) {
              // Create a new wav and initilize it
              new WAV @=> wav_o[note_id];
              wav[note_id] =>  wav_o[note_id].read;
              // store another reference to object in indexed array
              wav_o_byindex << wav_o[note_id];
            }
            wav_o[note_id] @=> w0;
          }
          else {
            // This note has a dedicated wav
            new WAV @=> w0;
            wav[note_id] => w0.read;
            0=> autonomous;
            // store reference to object in indexed array
            wav_o_byindex << w0;
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
            s.elements[s.elements.size() - 1].duration => s.elements[s.elements.size() - 1].note_info_s.d;
            groove -=> remaining; // correct remaining
            //                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
            // substract it to next one
            set_dur(base_dur - groove) => dur_temp;
            //                        <<<"dur_temp:", dur_temp/1::ms>>>;
            // reset it
            0::ms => groove;
          }
          if (dur_temp != 0::ms) {

            // set new GAIN if needed
            if (gain_to_apply != -1) {
              e.actions << w0.set_gain(gain_to_apply) ;
              //                             <<<" e.actions[e.actions.size() - 1]", e.actions[e.actions.size() - 1]>>>; 
              -1. => gain_to_apply;
            }
            // set new PAN if needed
            if (pan_to_apply != -2) {
              e.actions << w0.set_pan(pan_to_apply) ;
              -2. => pan_to_apply;
            }
            // set new RATE if needed
            if (rate_to_apply != -10) {
              e.actions << w0.set_rate(rate_to_apply) ;
              -10. => rate_to_apply;
            }
            if (proba_to_apply != 1.) {
              e.actions << w0.set_play_proba(proba_to_apply) ;
              1. => proba_to_apply;
              1 => e.note_info_s.on;
            }
            else {
              e.actions << w0.play $ ACTION ;
              1 => e.note_info_s.on;
            }  
            dur_temp => e.duration;
            e.duration => e.note_info_s.d;
            // Add element to SEQ
            s.elements << e;
            // Create next element of SEQ
            new ELEMENT @=> e;
            e.actions << set_note_info_act(note_info_tx_o ,e);
          }

        }
        else {    
          // No wav registered add a silence like with '~', to do not break the beat
          // And allow to add actions
          set_dur(base_dur) => dur_temp;
          if (dur_temp != 0::ms) {
            dur_temp => e.duration;
            e.duration => e.note_info_s.d;
            // Add element to SEQ
            s.elements << e;
            // Create next element of SEQ
            new ELEMENT @=> e;
            e.actions << set_note_info_act(note_info_tx_o ,e);
          }


        }

        ////////////////////
        ///// ACTIONS //////
        ////////////////////
        if ( action[note_id] != NULL ) {
          // Add ACTION to last ELEMENT actions
          s.elements[s.elements.size() - 1].actions << action[note_id] ;
        }
      }
      else if (c == '_') {
        if ( s.elements.size() == 0 ){
          // first event: Add one with no WAV
          set_dur(base_dur) => e.duration;
          0 => e.note_info_s.on;
          e.duration => e.note_info_s.d;
          // Add element to SEQ
          s.elements << e;
          // Create next element of SEQ
          new ELEMENT @=> e;
          e.actions << set_note_info_act(note_info_tx_o ,e);
        }
        else {
          // increse duration of last element
          set_dur(base_dur) +=> s.elements[s.elements.size() - 1].duration;
          s.elements[s.elements.size() - 1].duration => s.elements[s.elements.size() - 1].note_info_s.d;
        }

      }
      else if (c == '~') {
        // special pause : Add an empty element (permit to manage pre() better)
        set_dur(base_dur) => dur_temp;
        if (dur_temp != 0::ms) {
          dur_temp => e.duration;
          0 => e.note_info_s.on;
          e.duration => e.note_info_s.d;
          // Add element to SEQ
          s.elements << e;
          // Create next element of SEQ
          new ELEMENT @=> e;
          e.actions << set_note_info_act(note_info_tx_o ,e);
        }
      }
      else if (in.charAt(i) == '|') {
        // Add note to current element
        i++;
        in.charAt(i)=> c;
        note_id.setCharAt(0, c); 

        if ( wav[note_id] != NULL ){
          if (!autonomous) {
            // Normal case
            if (wav_o[note_id] == NULL) {
              // Create a new wav and initilize it
              new WAV @=> wav_o[note_id];
              wav[note_id] =>  wav_o[note_id].read;
              // store another reference to object in indexed array
              wav_o_byindex << wav_o[note_id];
            }
            wav_o[note_id] @=> w0;
          }
          else {
            // This note has a dedicated wav
            new WAV @=> w0;
            wav[note_id] => w0.read;
            0=> autonomous;
            // store reference to object in indexed array
            wav_o_byindex << w0;
          }

          // set new GAIN if needed
          if (gain_to_apply != -1) {
            s.elements[s.elements.size() - 1].actions << w0.set_gain(gain_to_apply) ;
            -1. => gain_to_apply;
          }
          // set new PAN if needed
          if (pan_to_apply != -2) {
            s.elements[s.elements.size() - 1].actions << w0.set_pan(pan_to_apply) ;
            -2. => pan_to_apply;
          }
          // set new RATE if needed
          if (rate_to_apply != -10) {
            s.elements[s.elements.size() - 1].actions << w0.set_rate(rate_to_apply) ;
            -10. => rate_to_apply;
          }

          // PROBA
          if (proba_to_apply != 1.) {
            s.elements[s.elements.size() - 1].actions << w0.set_play_proba(proba_to_apply) ;
            1. => proba_to_apply;
            1 => s.elements[s.elements.size() - 1].note_info_s.on;
          }
          else {

            // Add NOTE to ACTIONS
            s.elements[s.elements.size() - 1].actions << w0.play $ ACTION ;
              1 => s.elements[s.elements.size() - 1].note_info_s.on;
          }
        }
        ////////////////////
        ///// ACTIONS //////
        ////////////////////
        if ( action[note_id] != NULL ) {

          // Add ACTION to ACTIONS
          s.elements[s.elements.size() - 1].actions << action[note_id] ;
        }
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
          if (rate_to_apply == -10.)
            init_rate - rate_step * (c -'0') $ float =>  rate_to_apply;
          else
            rate_step * (c -'0') $ float -=>  rate_to_apply;
        }
        else {
          if (rate_to_apply == -10.)
            init_rate - rate_step  =>  rate_to_apply;
          else
            rate_step  -=>  rate_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '}') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') {
          if (rate_to_apply == -10.)
            init_rate + rate_step * (c -'0') $ float =>  rate_to_apply;
          else
            rate_step * (c -'0') $ float +=>  rate_to_apply;
        }
        else {
          if (rate_to_apply == -10.)
            init_rate + rate_step  =>  rate_to_apply;
          else
            rate_step  +=>  rate_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '?') {
        i++;
        in.charAt(i)=> c;
        if ('0' <= c && c <= '9') 
          proba_to_apply * (c -'0') $ float / 10. =>  proba_to_apply;
        else {
          proba_to_apply * .5 =>  proba_to_apply;
          i--;
        }
      }
      else if (in.charAt(i) == '$') {
        // Next note will be autonomous
        1 => autonomous;
      }



      i++;
    }

    // Fill sequence regarding max if needed
    if (max_v != 0::ms){
      if (remaining > 0::ms) {
        remaining => e.duration;
        e.duration => e.note_info_s.d; 
         // Add element to SEQ
        s.elements << e;
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

  fun void go(){
    // Get id from caller shred
    me.id() => the_end.shred_id;
    // register end
    killer.reg(the_end);

    s.go();
  }

  // function to get audio out of object
  // only one of this to use at a time
  /*
  Gain mono_out => blackhole;
  0 => int mono_out_active; 
  fun UGen mono() {
    if (!mono_out_active) {
      for (0 => int i; i < wav_o_byindex.size() ; i++) {
        <<<"Unchuck wav ", i>>>; 
        wav_o_byindex[i].mono() => mono_out;
      }
      1 => mono_out_active;
    }

    return mono_out;
  }
*/

//  Gain left_out;
//  0=> int left_out_active;
  fun UGen left() {
    if (!left_out_active) {
      for (0 => int i; i < wav_o_byindex.size() ; i++) {
        wav_o_byindex[i].left() => left_out;
      }
      1 => left_out_active;
    }

    return left_out;
  }

//  0 => int right_out_active;
//  Gain right_out;
  fun UGen right() {
    if (!right_out_active) {
      for (0 => int i; i < wav_o_byindex.size() ; i++) {
        wav_o_byindex[i].right() => right_out;
      }
      1 => right_out_active; 
    }

    return right_out;
  }

  fun void print() {
    s.print();
  }

  // update all wavs
  fun void gain (float in) {
      for (0 => int i; i < wav_o_byindex.size() ; i++) {
        in =>  wav_o_byindex[i].gain;
      }
  }

  fun void gain (string s, float in) {
    if (wav_o[s] != NULL){
      in => wav_o[s].gain;
    }
  }
}

