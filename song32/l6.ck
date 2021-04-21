//  class SERUM00 extends SYNT{
//  
//    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
//    .5 => w.gain;
//    .5 => factor.gain;
//  
//    1. => p.gain;
//  
//  
//    1 => w.sync;
//    1 => w.interpolate;
//    //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//    //[-1.0,  1] @=> float myTable[];
//    float myTable[0];
//  
//    SndBuf s => blackhole;
//    
//  
//    fun void config(int wn /* wave number */) {
//  
//  
//  
//    list_SERUM0.get(wn) => string wstr;
//      
//     if ( wstr == ""  ){
//      list_SERUM0.get(0) => wstr;
//     }
//     else {
//        <<<"serum wavtable :", wn, wstr>>>;
//     }
//  
//     wstr => s.read;
//  
//  
//      0 => int start;
//  
//      for (start => int i; i < s.samples() ; i++) {
//        myTable << s.valueAt(i);
//      }
//  
//      if ( myTable.size() == 0  ){
//         <<<" SERUM ERROR: Empty wavtable !!!!!">>>;
//  
//         myTable << 0; 
//      }
//  
//      w.setTable (myTable);
//    }
//  
//    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
//  } 

TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(456 /* synt nb */  ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
