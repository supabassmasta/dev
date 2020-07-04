public class POLYSEQ {

  SEQ @ s[0];
  string  sseq[0];
  STGAIN stout;

  fun void size(int si) {
    for (0 => int i; i < si      ; i++) {
      s << new SEQ;
      sseq << new string;
    }
  }

  fun void max(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].max;
    }
  }

  fun void extra_end(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].extra_end;
    }
  }

  /////////////////////
  fun void sync(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].sync;
    }
  }
  
  fun void element_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].element_sync();
    }
  }

  fun void no_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].no_sync();
    }
  }

  fun void full_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].full_sync();
    }
  }
  /////////////////////
  float gain_common;

  fun void stout_connect() {
    for (0 => int i; i <    s.size()   ; i++) {
      stout.connect(s[i] $ ST , gain_common /* static gain */  );      
    }
  }

  fun void go(){
    for (1 => int i; i <    s.size()   ; i++) {
      s[0].the_end.fixed_end_dur => s[i].the_end.fixed_end_dur; 
    }

    for (0 => int i; i <    s.size()   ; i++) {
      sseq[i] => s[i].seq;
    }
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].go();
    }
  }

}

