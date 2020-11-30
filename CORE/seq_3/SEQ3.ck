public class SEQ3 {
  time ref_time;
  dur duration;
  float nb_tick;
  0 => int idx;
  -1 => int last_idx;
  0 => int exit;  
  1 => int on_flag;
  0=> int just_on;
  0=> int just_off;

  Shred @ id_go;
  ELEMENT elements[0];
		
	0::ms => dur dur_sync;	

  1 => int sync_mode;
  fun void no_sync()      {0=>sync_mode ;}
  fun void element_sync() {1 => sync_mode ;}
  fun void full_sync()    {2 => sync_mode ;}
  fun void sync(dur d)    {3 => sync_mode ; d => dur_sync;}


  fun void set_all_next_time_invalid() {
   for (0 => int i; i < elements.size(); i++) {
     0 => elements[i].next_time_validity;
   }
  }

  fun void compute_ref_time() {
    now - ((now - data.wait_before_start)%duration)  => ref_time;
  }

  fun time set_element_next_time(int i) {
    elements[i].rel_pos * duration + ref_time => elements[i].next_time => time ret;
    // As we just compute it next time is valid
    1 =>  elements[i].next_time_validity;

    return ret;
  }

  fun int find_next_to_play() {
        -1 => int res;
        time next;
        while (res == -1 ) {
          for (0 => int i; i < elements.size() ; i++) {
            set_element_next_time(i) => next;
            if ( next > now && res == -1 ){
              i => res; 
            }
          } 

          if(res == -1) {
            // We dont find next, in current sequence period
            // Try in next one
            ref_time + duration => ref_time;
          }
        }
        
        // update next time of element before res as we know there are invalid
        // They will happen in next sequence period
        ref_time + duration => ref_time;

        for (0 => int i; i <  res     ; i++) {
          set_element_next_time(i);
        }

        // <<<"OUTPUT find_next_to_play">>>;
        // <<<"res idx", res, "now", now, "ref_time", ref_time>>>;
        // for (0 => int i; i < elements.size() ; i++) {
        //   <<<"elt", i , elements[i].next_time>>>;
        // }

        return res;
  }

  fun void _go() {
    
    // compute duration and rel_time
    0::ms => duration;
    for (0 => int i; i < elements.size()      ; i++) {
        duration => elements[i].rel_time;
        elements[i].duration +=> duration;
    }
    
    duration / data.tick => nb_tick;
    // <<<"nb_tick", nb_tick>>>; 
    // compute rel_pos
    for (0 => int i; i < elements.size()      ; i++) {
        elements[i].rel_time /  duration => elements[i].rel_pos;
    }

    // initial SYNC
    // NO SYNC
    if (sync_mode == 0) {
        // Start now (+ 10::ms for processing) and save ref_time
        now + 10::ms => ref_time;
    }
    // ELEMENT SYNC
    else if (sync_mode == 1) {
        compute_ref_time();
        find_next_to_play () => idx;
        // <<<"SYNC on Element ", idx>>>;
    }
    // FULL SYNC
    else if (sync_mode == 2) {
        compute_ref_time();
        // wait next ref_time to start
        duration + ref_time => ref_time;
    }
    // DUR SYNC
    else if (sync_mode == 3) {
        now - ((now - data.wait_before_start)%dur_sync) => ref_time;
        // wait next ref_time to start
        dur_sync + ref_time => ref_time;
    }
     
    //    <<<"SEQ3 dur: ",duration," ref_time:",ref_time>>>;
     

    // LOOP
    while (!exit) {
           if (elements[idx].next_time_validity == 0) {
             // Maybe bpm change, recompute duration
             nb_tick * data.tick => duration;
             
             // Maybe ref time change too
             compute_ref_time();

             // Maybe next element is not the good one anymore
             find_next_to_play() => idx;

             if ( idx == last_idx ){
               // We already just played this index (probably a short time adjustemnet backward
               //==>  Don't play it again

               // Update its next_time 
               elements[idx].next_time + duration => elements[idx].next_time;
               // skip to next
               (idx + 1) %  elements.size() => idx;
               // <<<"DISCARD DOUBLE PLAY">>>;
             }
          }

           if(elements[idx].next_time > now) {

               // wait next event
               elements[idx].next_time => now;   

               if (on_flag) {
                   // ON_TIME
                   // <<<"SEQ3 Execute element: ", idx>>>; 
                   for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                       elements[idx].actions[i].on_time();
                       //  <<<"action ", i>>>; 
                   }

                   if (just_on) {
                      0 => just_on;
                      for (0 => int i; i < elements[idx].on_actions.size()      ; i++) {
                        elements[idx].on_actions[i].on_time();
                      }
                   }
               }
               else {
                 if (just_off) {
                   0 => just_off;
                   for (0 => int i; i < elements[idx].off_actions.size()      ; i++) {
                     elements[idx].off_actions[i].on_time();
                   }
                 }
               }
            }
            else {
                <<<"SKIPED element ", idx, ", time",  elements[idx].next_time, "<", now>>>; 

                // <<<"ref_time", ref_time, "duration", duration>>>;
                // for (0 => int i; i < elements.size()      ; i++) {
                //   <<<"elt", i , elements[i].next_time>>>;
                // }
                 
            }
            
            elements[idx].next_time + duration => elements[idx].next_time;

            idx => last_idx;
            (idx + 1) %  elements.size() => idx;
    }
  }

  
  fun void go() {
    1=> just_on;
    spork ~ _go() @=> id_go;    
  }

  fun void on(int in) {
    if (in != on_flag){
      in => on_flag;
      if (on_flag){
        1 => just_on;
      }
      else {
        1 => just_off;
      }
    }
  }

  fun void print() {
   0::ms => dur total_dur; 
    
   for (0 => int i; i < elements.size() ; i++) {
      <<<"ELEMENT ", i, "  dur: ", elements[i].duration / data.tick>>>;   
      elements[i].duration +=>  total_dur; 
      for (0 => int j; j < elements[i].actions.size()      ; j++) {
        <<<"    ", j , " " , elements[i].actions[j].name >>>;

      }
      <<<"ON ACTIONS">>>;  
      for (0 => int j; j < elements[i].on_actions.size()      ; j++) {
        <<<"    ", j , " " , elements[i].on_actions[j].name >>>;
      }

      <<<"OFF ACTIONS">>>;  
      for (0 => int j; j < elements[i].off_actions.size()      ; j++) {
        <<<"    ", j , " " , elements[i].off_actions[j].name >>>;
      }


   }
    
    <<<"\nSEQ TOTAL DURATION: ", total_dur / 1000::ms, " s, ", total_dur / data.tick, " ticks\n">>>;



  }


fun void play_off_actions(int element_idx) {
  if (element_idx < elements.size()   ){
    for (0 => int i; i < elements[element_idx].off_actions.size()      ; i++) {
      elements[element_idx].off_actions[i].on_time();
    }
  }
  else {
    <<<"ERROR: SEQ3: off_actions index too high">>>;
  }
}


}
