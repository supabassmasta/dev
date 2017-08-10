public class MASTER_SEQ3 {
  static SEQ3 @  seqs[0];

  fun static  void reg (SEQ3 s) {
    seqs << s;
  }

  fun static  void update_ref_times (time r, dur duration) {
    time ref_test;
    float last_diff;
    int j; 
    // for future seqs
    r % data.tick => data.wait_before_start;


    for (0 => int i; i < seqs.size(); i++) {
       // find new ref time the closer to old one (modulo synchro sequence duration)
       0 => j; 
       if (r > seqs[i].ref_time) {
         r/1::samp - seqs[i].ref_time/1::samp => last_diff;  
         while ( Std.fabs ( (r - duration * (j+1))/1::samp - seqs[i].ref_time/1::samp ) < last_diff ) {
            Std.fabs ( (r - duration * (j+1))/1::samp - seqs[i].ref_time/1::samp ) => last_diff;
            1 +=> j;
         }
          
         r - (duration * j) => seqs[i].ref_time;

       }
       else {
         seqs[i].ref_time/1::samp - r/1::samp  => last_diff;  
         while ( Std.fabs ( (r + duration * (j+1))/1::samp - seqs[i].ref_time/1::samp ) < last_diff ) {
            Std.fabs ( (r + duration * (j+1))/1::samp - seqs[i].ref_time/1::samp )  => last_diff;
            1 +=> j;
         }

         r + (duration * j) => seqs[i].ref_time;
       }



       seqs[i].set_all_next_time_invalid();
    }
     
  }
  fun static  void update_durations (dur d, float nb_tick) {
    // for future seqs
    d / nb_tick => data.tick;

    for (0 => int i; i < seqs.size(); i++) {
       d * seqs[i].nb_tick / nb_tick  => seqs[i].duration;
       seqs[i].set_all_next_time_invalid();
    }
     
  }
  
  fun static  void update_tick(time ref_time, dur ref_seq_dur, float ref_seq_nb_tick) {
      update_durations (ref_seq_dur,ref_seq_nb_tick);
      update_ref_times (ref_time, ref_seq_dur);
  }
  
  
  }

SEQ3 bar[0] @=> MASTER_SEQ3.seqs;

while(1) 100000::ms => now;

