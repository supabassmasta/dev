class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

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

fun void stout_connect() {
  for (0 => int i; i <    t.size()   ; i++) {
    stout.connect(t[i] $ ST , 1. /* static gain */  );      
  }
}

fun void go(){
  for (1 => int i; i <    t.size()   ; i++) {
//    t[0].max() => t[i].max;
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

//4 => pt.t.size => pt.tseq.size;
3 => pt.size;

//data.tick * 8 => pt.t[0].max; //60::ms => pt.t[0].glide;  
 // 1 * data.tick => pt.t[0].the_end.fixed_end_dur;  // 16 * data.tick => pt.t[0].extra_end;   //pt.t[0].print(); //pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;


 pt.t[0].reg(synt0 s0); 
 pt.t[0].dor(); // pt.t[0].lyd(); // pt.t[0].ion(); // pt.t[0].mix(); //pt.t[0].dor();// pt.t[0].aeo(); // pt.t[0].phr();// pt.t[0].loc(); pt.t[0].double_harmonic();
 //pt.t[0].sync(4*data.tick);// pt.t[0].element_sync();//  pt.t[0].no_sync();//  pt.t[0].full_sync();
 pt.t[0].adsr[0].set(1500::ms, 1000::ms, .6, 3000::ms);
 pt.t[0].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
 .6 * data.master_gain => pt.t[0].gain;
 
 pt.t[1].reg(synt0 s1); 
 pt.t[1].dor(); 
 pt.t[1].adsr[0].set(1500::ms, 1000::ms, .6, 3000::ms);
 pt.t[1].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
 .6 * data.master_gain => pt.t[1].gain;
 pt.t[2].reg(synt0 s2); 
 pt.t[2].dor(); 
 pt.t[2].adsr[0].set(1500::ms, 1000::ms, .6, 3000::ms);
 pt.t[2].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
 .6 * data.master_gain => pt.t[2].gain;

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 1___ ____  1___ 5___" +=> pt.tseq[0];
":4 __3_ ____  3___ 7___" +=> pt.tseq[1];
":4 ____ 5___  5___ 9___" +=> pt.tseq[2];

"2___ 1___" +=> pt.tseq[0];
"4___ 3___" +=> pt.tseq[1];
"6___ 7___" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last;

STGVERB stgverb;
stgverb.connect(last $ ST, .5 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
