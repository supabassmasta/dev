public class FREQ  {

    seq int_seq;
    
    // Interface adapt
    int_seq.g @=> float g[];
   int_seq.note @=> float note[]; 
    int_seq.rel_dur @=> float rel_dur[];
    int_seq.rel_note @=> int rel_note[];
    int_seq.param @=> float param[][];
    fun void sync_on(int in) {in => int_seq.sync_on ;}
    fun float bpm(){return int_seq.bpm();}
    fun float bpm(float in){return int_seq.bpm(in);}
    fun dur tick () { return int_seq.tick;}
    fun dur tick (dur in) { in => int_seq.tick; return int_seq.tick;}

    fun int idx () {return int_seq.idx;}
    fun int idx (int in) {in => int_seq.idx; return int_seq.idx;}
    
    fun dur timing_offset () {return int_seq.timing_offset;}
    fun dur timing_offset (dur in) {in => int_seq.timing_offset; return int_seq.timing_offset;}

		fun float get_param(int i) { return int_seq.get_param (i); }

//    int_seq.start_ev @=> Event start_ev;
//    int_seq.stop_ev @=> Event stop_ev;
  Event start_ev;
  Event stop_ev;
	Event new_ev;

    // internal

    64 => int base_note;
    "PENTA_MAJ" => string scale;
    int slide[0];
    
    0::ms => dur glide;
    
    // <<<scales.conv_to_note(0, scale, base_note)>>>;

    // freq
    Step step => Envelope freq;
    step.next(1);
    
    // suspend control: to allow manual control of synth
    0 => int suspend_control;
    
    // ADSR
    ADSR adsr;
    adsr.set(3::ms, 0::ms, 1, 3::ms);
 
    fun void go(){
        adsr.keyOff();
        int_seq.go();
        }
 
    fun void __play(){
        
	      0 => int toggle_on;
        0=> int slide_on;
        440 => float target_freq;
        while (1) {
           int_seq.start_ev => now;
            
            if (!suspend_control) {
                // ADSR & GAIN
                if (g.size() != 0) {
                    if (g[int_seq.idx % g.size()] == 0.){
												if (toggle_on) {
                            adsr.keyOff();
												    0=> toggle_on;
														stop_ev.broadcast();
												}
                        }
                    else {
                        g[int_seq.idx % g.size()] => adsr.gain;
												new_ev.broadcast();
												if (!toggle_on) {
                             adsr.keyOn();
														 1=> toggle_on;
														start_ev.broadcast();
												}
                    }
                }
                else adsr.keyOn();
                
                // Target freq
                if ( rel_note.size() != 0 ) {
                    Std.mtof (scales.conv_to_note(rel_note[int_seq.idx % rel_note.size()], scale, base_note)) => target_freq;
                }
                else if (note.size() != 0 ) {
                    Std.mtof (note[int_seq.idx % note.size()]) => target_freq;
                }
                
                // slides
                if (slide.size() == 0) 0=>slide_on; 
                else if (slide[int_seq.idx % slide.size()] == 1) 1=>slide_on; 
                else 0=>slide_on; 
                
                if (!slide_on) {
                    if (glide != 0::ms) {
                        target_freq => freq.target;
                        glide => freq.duration;
                    }
                    else {
                        // directly set the value
                       target_freq => freq.value;
                       // <<<"target_freq",target_freq>>>;
                    }
                }
                else {
                        target_freq => freq.target;
                        if (rel_dur.size() == 0) int_seq.tick => freq.duration;
                        else rel_dur[int_seq.idx%rel_dur.size()] * int_seq.tick => freq.duration;
                    
                }
        
            }
        
        }
    }

    spork ~ __play();


}
