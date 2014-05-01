public class seq {

// ARRAYS
    float g[0];
    float note[0];
    float rel_dur[0];
    int rel_note[0];
    float param[10][0];

    Event start_ev;
    Event stop_ev;
    
    0 => int idx;
    
    0::ms => dur timing_offset;

		0=> int play_on;
    
// BPM
    500::ms => dur tick;
    fun float bpm(){
        return 60::second / tick;
    }
    fun float bpm(float in){
        60::second / in => tick;
        return 60::second / tick;
    }
    // maybe read rythm_inf.txt or find a smarter way

// TICK Mode
    0 => int tick_mode; // off by default

// SYNC
    1 => int sync_on;

    fun void sync(int sync_mode){
        if (sync_mode==1) { // sync on full part
            if (rel_dur.size() != 0) {
                0 => float total_dur;
                for (0=>int i; i<rel_dur.size(); i++) rel_dur[i] +=> total_dur;
                total_dur * tick - (now + timing_offset - data.wait_before_start) % (total_dur * tick) => now;
            }
            else if (note.size() != 0) {
                note.size() * tick - (now + timing_offset - data.wait_before_start) % (note.size() * tick) => now;
            }
            else if (rel_note.size() != 0) {
                rel_note.size() * tick - (now + timing_offset - data.wait_before_start) % (rel_note.size() * tick) => now;
            }
            else if (g.size() != 0) {
                g.size() * tick - (now + timing_offset - data.wait_before_start) % (g.size() * tick) => now;
            }
        }
        else if (sync_mode == 2) { //<<<"sync on correct note">>>;
            if (rel_dur.size() != 0) {
                0 => float total_dur;
                dur remaining_dur;
                for (0=>int i; i<rel_dur.size(); i++) rel_dur[i] +=> total_dur;
                
                total_dur * tick - (now + timing_offset - data.wait_before_start) % (total_dur * tick) => remaining_dur;
                0=> int j;
                0::ms => dur cumulated_dur;
                
                // Find note index to start
                while (rel_dur[j]* tick + cumulated_dur < (total_dur * tick) - remaining_dur) {
                    rel_dur[j] * tick  + cumulated_dur => cumulated_dur;
                    j++;
                }
               
                // index is the next
                j+1 => idx;
               
               cumulated_dur + rel_dur[j] * tick - (now + timing_offset - data.wait_before_start) % (total_dur * tick) => now;
               
               // total_dur * tick - now % (total_dur * tick) => now;
            }
            else if (rel_note.size() != 0) {
            // <<<"rel_note sync">>>;
                0=> int j;
                (now + timing_offset - data.wait_before_start) % (rel_note.size() * tick) => dur elapsed_dur;
                while (j*tick < elapsed_dur) j++;
                
                // index is j
                j => idx;

                (j)*tick - elapsed_dur => now;
                
            }
            else if (note.size() != 0) {
                0=> int j;
                (now + timing_offset - data.wait_before_start) % (note.size() * tick) => dur elapsed_dur;
                while (j*tick < elapsed_dur) j++;
                
                // index is j
                j => idx;

                (j)*tick - elapsed_dur => now;
                
            }
            else if (g.size() != 0) {
                0=> int j;
                (now + timing_offset - data.wait_before_start) % (g.size() * tick) => dur elapsed_dur;
                while (j*tick < elapsed_dur) j++;
                
                // index is j
                j => idx;

                (j)*tick - elapsed_dur => now;

                
            }
        }
    }

    
// PLAY 


    fun void start_note(int i){
        start_ev.broadcast();
//        <<<"start_note", i>>>;
        }
    fun void stop_note(int i){
        stop_ev.broadcast();
//        <<<"stop_note",i>>>;
        }
    
    fun void play() {
        while (play_on) {
            spork ~ start_note(idx);
            
            if (rel_dur.size() !=0) rel_dur[idx%rel_dur.size()] * tick => now;
            else tick => now;
            
            spork ~ stop_note(idx);
						me.yield();
            idx++;
        }
//				<<<"STOOOP PLAYING 0">>>; 
    }

    fun void go() {
            sync(sync_on); // to remove sync overload it as an empty function
            // <<<"sync">>>;
						1=> play_on;
        spork ~ play();
    }

		fun void stop() {
				0 => play_on;
//				<<<"STOOOP PLAYING 1">>>;
		}

    // PARAMS
		fun float get_param(int i) {
				if (i>9){
//				    <<<"ERROR only 10 params available">>>;
						return 0.;
				}
				else if (param[i].size() == 0){
//						<<<"ERROR param [",i,"] IS EMPTY" >>>;
						return 0.;
				}
				else {
						return param [i][idx%param[i].size()];
				}

		}

}


// TEST
/*seq s;
s.rel_dur << 2. << 1. << 1. ;
133 => s.bpm;
<<<"SYNC", s.bpm()>>>;
while(1) 1000::ms=>now;
*/
