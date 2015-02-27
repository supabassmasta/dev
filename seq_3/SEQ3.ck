public class SEQ3 {
  0::ms => dur sync_offset;
  time ref_time;
  dur duration;
  0 => int idx;
  0 => int exit;  


  ELEMENT elements[0];

  int sync_mode = 0;
  fun void no_sync() {sync_mode = 0;}
  fun void element_sync() {sync_mode = 1;}
  fun void full_sync() {sync_mode = 2;}


  fun void set_all_next_time_invalid() {
   for (0 => int i; i < elements.size(); i++) {
     elements[i].next_time_validity = 0;
   }
  }

  fun void _go() {
    
    // compute duration and rel_time
    0::ms => duration;
    for (0 => int i; i < elements.size      ; i++) {
        duration => elements[i].rel_time;
        elements[i].duration +=> duration;
    }

    // compute rel_pos
    for (0 => int i; i < elements.size      ; i++) {
        elements[i].rel_time /  duration => elements[i].rel_pos;
    }

    // initial SYNC
    if (sync_mode == 0) {
        // Start now and save ref_time
        now => ref_time;
    }
    else if (sync_mode == 1) {
        now - ((now - sync_offset)%duration) => ref_time;
        0=> int i;
        while (i < elements.size() && elements[i].rel_time + ref_time < now) {
            i++;
        }
        i => idx;
    }
    else if (sync_mode == 1) {
        now - ((now - sync_offset)%duration) => ref_time;
        // wait next ref_time to start
        duration + ref_time => ref_time;
    }
     

    // LOOP
    while (!exit) {
        // PRE
           for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                elements[idx].actions.pre[i];
           }
            
         // Manage next element time   
           if (elements[idx].next_time_validity == 0) {
                ref_time + (duration * elements[idx].rel_pos) => elements[idx].next_time;
                1 => elements[idx].next_time_validity;
           }

           if( elements[idx].next_time > now) {

             // wait next event
             elements[idx].next_time => now;   
        // ON_TIME

                for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                    elements[idx].actions.on_time[i];
                }
            }
        // POST
            for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                 elements[idx].actions.post[i];
            }

            if (idx == 0) {
               elements[idx].next_time => ref_time;   
            }
            
            elements[idx].next_time + duration => elements[idx].next_time;

            idx + 1 => idx;
            if (idx >= elements.size()){
                0=> idx;
            }



    }
    
  }

  
  fun void go() {
    spork ~ _go();    
  }


}
