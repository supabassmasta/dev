public class POLYTONE {

  TONE @ t[0];
  string  tseq[0];
  STGAIN stout;

  fun void size(int s) {
    for (0 => int i; i < s      ; i++) {
      t << new TONE;
      tseq << new string;
    }
  }

  fun void max(dur in){
    for (0 => int i; i <    t.size()   ; i++) {
      in => t[i].max;
    }
  }

  fun void extra_end(dur in){
    for (0 => int i; i <    t.size()   ; i++) {
      in => t[i].extra_end;
    }
  }

  //////////////////////

  fun void dor(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].dor();
    }
  }

  fun void lyd(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].lyd();
    }
  }

  fun void ion(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].ion();
    }
  }

  fun void mix(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].mix();
    }
  }

  fun void aeo(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].aeo();
    }
  }

  fun void phr(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].phr();
    }
  }

  fun void loc(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].loc();
    }
  }

  fun void double_harmonic(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].double_harmonic();
    }
  }

  fun void gypsy_minor(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].gypsy_minor();
    }
  }
  /////////////////////
  fun void sync(dur in){
    for (0 => int i; i <    t.size()   ; i++) {
      in => t[i].sync;
    }
  }
  
  fun void element_sync(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].element_sync();
    }
  }

  fun void no_sync(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].no_sync();
    }
  }

  fun void full_sync(){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].full_sync();
    }
  }
  /////////////////////
  fun void adsr0_set(dur a, dur d, float s, dur r){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].adsr[0].set(a, d, s, r);
    }
  }

  fun void adsr0_setCurves(float a, float d,  float r){
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].adsr[0].setCurves(a, d, r);
    }
  }

  /////////////////////
  float gain_common;

  fun void stout_connect() {
    for (0 => int i; i <    t.size()   ; i++) {
      stout.connect(t[i] $ ST , gain_common /* static gain */  );      
    }
  }

  fun void go(){
    for (1 => int i; i <    t.size()   ; i++) {
      t[0].glide => t[i].glide;
      t[0].the_end.fixed_end_dur => t[i].the_end.fixed_end_dur; 
      //    t[0].extra_end => t[i].extra_end;
    }

    for (0 => int i; i <    t.size()   ; i++) {
      tseq[i] => t[i].seq;
    }
    for (0 => int i; i <    t.size()   ; i++) {
      t[i].go();
    }
  }
}


