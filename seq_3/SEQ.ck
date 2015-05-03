public class SEQ {
    // PUBLIC 
    string wav[0];
    300::ms =>  dur base_dur;
    0.05 => float groove_ratio;
    0.3 => float init_gain;
    0.03 => float gain_step;
    -1. => float gain_to_apply;

    0. => float init_pan;
    0.1 => float pan_step;
    -2. => float pan_to_apply;
    
    // PRIVATE
    0::ms => dur max_v;//private
    0::ms => dur remaining;//private
    0::ms => dur groove;
    WAV wav_o[0]; // private
    SEQ3 s;
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



    fun void seq(string in) {
        0=> int i;
        int c;
        "0" => string note_id;
        ELEMENT @ e;
        WAV @ w0;

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
            else if ( ((c >= 'a') && (c <= 'z')) || ((c >= 'a') && (c <= 'z')) ) {
                note_id.setCharAt(0, c); 
                if ( wav[note_id] != NULL ){
                    if (wav_o[note_id] == NULL) {
                        // Create a new wav and initilize it
                        new WAV @=> wav_o[note_id];
                        wav[note_id] =>  wav_o[note_id].read;
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

                        // set new GAIN if needed
                        if (gain_to_apply != -1) {
                             e.actions << wav_o[note_id].set_gain(gain_to_apply) ;
//                             <<<" e.actions[e.actions.size() - 1]", e.actions[e.actions.size() - 1]>>>; 
                             -1. => gain_to_apply;
                        }
                        // set new PAN if needed
                        if (pan_to_apply != -2) {
                             e.actions << wav_o[note_id].set_pan(pan_to_apply) ;
                             -2. => pan_to_apply;
                        }

                        dur_temp => e.duration;
                        e.actions << wav_o[note_id].play $ ACTION ;
                        // Add element to SEQ
                        s.elements << e;
                        // Create next element of SEQ
                        new ELEMENT @=> e;
                    }

                }
                else {
                    <<<note_id, "Not registered">>>;
                }
            }
            else if (c == '_') {
                if ( s.elements.size() == 0 ){
                    // first event: Add one with no WAV
                    set_dur(base_dur) => e.duration;
                    // Add element to SEQ
                    s.elements << e;
                    // Create next element of SEQ
                    new ELEMENT @=> e;
                }
                else {
                    // increse duration of last element
                    set_dur(base_dur) +=> s.elements[s.elements.size() - 1].duration;
                }

            }
            else if (c == '~') {
                // special pause : Add an empty element (permit to manage pre() better)
                set_dur(base_dur) => e.duration;
                // Add element to SEQ
                s.elements << e;
                // Create next element of SEQ
                new ELEMENT @=> e;

            }
			else if (in.charAt(i) == '|') {
                // Add note to current element
				i++;
				in.charAt(i)=> c;
                note_id.setCharAt(0, c); 
               
                if ( wav[note_id] != NULL ){
                    if (wav_o[note_id] == NULL) {
                        // Create a new wav and initilize it
                        new WAV @=> wav_o[note_id];
                        wav[note_id] =>  wav_o[note_id].read;
                    }
                        // set new GAIN if needed
                        if (gain_to_apply != -1) {
                             s.elements[s.elements.size() - 1].actions << wav_o[note_id].set_gain(gain_to_apply) ;
                             -1. => gain_to_apply;
                        }
                        // set new PAN if needed
                        if (pan_to_apply != -2) {
                             s.elements[s.elements.size() - 1].actions << wav_o[note_id].set_pan(pan_to_apply) ;
                             -2. => pan_to_apply;
                        }

                    // Add NOTE to ACTIONS
                    s.elements[s.elements.size() - 1].actions << wav_o[note_id].play $ ACTION ;

                }
                else {
                    <<<note_id, "Not registered">>>;
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
            


             i++;
        }
        
        // Fill sequence regarding max if needed
        if (max_v != 0::ms){
            if (remaining > 0::ms) {
                remaining => e.duration;
                // Add element to SEQ
                s.elements << e;
            }
        
        }

    } 

    fun void go(){
        s.go();
    }
}
