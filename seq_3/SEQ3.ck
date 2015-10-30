public class SEQ3 {
  0::ms => dur sync_offset;
  time ref_time;
  dur duration;
  0 => int idx;
  0 => int exit;  
  1 => int on_flag;
  0=> int just_on;
  0=> int just_off;

  Shred @ id_go;
  ELEMENT elements[0];

  0 => int sync_mode;
  fun void no_sync()      {0=>sync_mode ;}
  fun void element_sync() {1 => sync_mode ;}
  fun void full_sync()    {2 => sync_mode ;}


  fun void set_all_next_time_invalid() {
   for (0 => int i; i < elements.size(); i++) {
     0 => elements[i].next_time_validity;
   }
  }

  fun void _go() {
    
    // compute duration and rel_time
    0::ms => duration;
    for (0 => int i; i < elements.size()      ; i++) {
        duration => elements[i].rel_time;
        elements[i].duration +=> duration;
    }

    // compute rel_pos
    for (0 => int i; i < elements.size()      ; i++) {
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
        if (idx >= elements.size()){
            0=> idx;
        }


    }
    else if (sync_mode == 2) {
        now - ((now - sync_offset)%duration) => ref_time;
        // wait next ref_time to start
        duration + ref_time => ref_time;
    }
     
//    <<<"SEQ3 dur: ",duration," ref_time:",ref_time>>>;
     

    // LOOP
    while (!exit) {
        // PRE
           if (on_flag) {
               for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                   elements[idx].actions[i].pre();
               }
           }
         // Manage next element time   
           if (elements[idx].next_time_validity == 0) {
                if (idx == 0 && ref_time <= now) {
                    // recompute ref_time
                    ref_time + duration => ref_time;
//                  <<<"New ref_time ", ref_time>>>;
                }

                ref_time + (duration * elements[idx].rel_pos) => elements[idx].next_time;
                1 => elements[idx].next_time_validity;
           }

           if(elements[idx].next_time > now) {

               // wait next event
               elements[idx].next_time => now;   
               if (on_flag) {
                   // ON_TIME

                   for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                       elements[idx].actions[i].on_time();
                   }

                   if (just_on) {
                      0 => just_on;
                      for (0 => int i; i < elements[idx].on_actions.size()      ; i++) {
                        elements[idx].on_actions[i].on_time();
                      }

                   }

                   // POST
                   for (0 => int i; i < elements[idx].actions.size()      ; i++) {
                       elements[idx].actions[i].post();
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
                <<<"element ", idx, "skiped, time",  elements[idx].next_time, ">", now>>>; 
                0 => elements[idx].next_time_validity;
            }

            if (idx == 0 && elements[0].next_time_validity) {
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
   for (0 => int i; i < elements.size() ; i++) {
      <<<"ELEMENT ", i, "  dur: ", elements[i].duration / data.tick>>>;   
        
      for (0 => int j; j < elements[i].actions.size()      ; j++) {
        <<<"    ", j , " " , elements[i].actions[j].name >>>;

      }
       

   }
    


  }
}
