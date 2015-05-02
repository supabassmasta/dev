public class SEQ {
    // PUBLIC 
    string wav[0];
    300::ms =>  dur base_dur;

    // PRIVATE
    0::ms => dur max_v;//private
    0::ms => dur remaining;//private

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

        // reset remaining
        max_v => remaining;

        // Create next element of SEQ
        new ELEMENT @=> e;


        while(i< in.length()) {
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

                    e.actions << wav_o[note_id].play $ ACTION ;
                    set_dur(base_dur) => e.duration;
                    // Add element to SEQ
                    s.elements << e;
                    // Create next element of SEQ
                    new ELEMENT @=> e;

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

                    s.elements[s.elements.size() - 1].actions << wav_o[note_id].play $ ACTION ;

                }
                else {
                    <<<note_id, "Not registered">>>;
                }
             }


            1 +=> i;
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
