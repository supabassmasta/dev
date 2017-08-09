public class MASTER_SEQ3 {
  static SEQ3 @  seqs[0];

  fun static  void reg (SEQ3 s) {
    seqs << s;
  }

  fun static  void update_ref_times (time r) {
    for (0 => int i; i < seqs.size(); i++) {
       r => seqs[i].ref_time;
       seqs[i].set_all_next_time_invalid();
    }
     
  }
  fun static  void update_durations (dur d) {
    for (0 => int i; i < seqs.size(); i++) {
       d => seqs[i].duration;
       seqs[i].set_all_next_time_invalid();
    }
     
  }
}

SEQ3 bar[0] @=> MASTER_SEQ3.seqs;

while(1) 100000::ms => now;

