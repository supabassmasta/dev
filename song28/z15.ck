class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class synt1 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .2 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


class POLYTONE {

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

POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
 //pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
 //pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

 pt.t[0].reg(synt0 s0); 
 pt.t[1].reg(synt0 s1); 
 pt.t[2].reg(synt0 s2); 

 pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
 pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"" +=> pt.tseq[0];
"" +=> pt.tseq[1];
"" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last;

//STGVERB stgverb;
//stgverb.connect(last $ ST, .5 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
