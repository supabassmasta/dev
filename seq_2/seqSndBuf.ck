    // class seq_ext extends seq {
    // }
    // seq_ext seq_int;


public class seqSndBuf extends SndBuf  {
    seq int_seq;
    
    // Interface adapt
    int_seq.g @=> float g[];
//    int_seq.note @=> float note[]; // No note for SndBuf
    int_seq.rel_dur @=> float rel_dur[];
    fun void sync_on(int in) {in => int_seq.sync_on ;}
    fun float bpm(){return int_seq.bpm();}
    fun float bpm(float in){return int_seq.bpm(in);}
    fun dur tick () { return int_seq.tick;}
    fun dur tick (dur in) { in => int_seq.tick; return int_seq.tick;}

    fun int idx () {return int_seq.idx;}
    fun int idx (int in) {in => int_seq.idx; return int_seq.idx;}
    
    fun dur timing_offset () {return int_seq.timing_offset;}
    fun dur timing_offset (dur in) {in => int_seq.timing_offset; return int_seq.timing_offset;}

    // internal
    float r[0];
 
    fun void go(){
        // set pos at the end to avoid unwanted start
        samples() => pos;
        int_seq.go();
        }

  fun void stop(){
        int_seq.stop();
        }

    
    fun void __play(){
    
        0 => int next_pos;
        while (1) {
           int_seq.start_ev => now;
           
           if (r.size() != 0 ) { 
                r[int_seq.idx % r.size()] => rate;
                
                if (rate() < 0) samples() => next_pos;
                else 0 => next_pos;
                }
           
           if (g.size() !=0){
                if (g[int_seq.idx % g.size()] == 1.){
                    next_pos => pos;
                }
                else if (g[int_seq.idx % g.size()] == 0.){
                    // do nothing
                }
                else {
                    g[int_seq.idx % g.size()] => gain;
                    next_pos => pos;
                }
           }
           // <<<"play wav">>>;
        }
    }
    
    spork ~ __play();
       
        // fun void start_note(int i){<<<"sndbuf", i>>>; 0 => pos;}
        // fun void stop_note(int i){}


}
