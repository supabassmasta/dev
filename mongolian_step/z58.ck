// BRIDGE

class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

 

 TONE t;
 t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
 t.dor();// t.aeo(); // t.phr();// t.loc();
 // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
 "*4 {c
 2223 3355
 2223 33 9 8
 " => t.seq;
 .9 * data.master_gain => t.gain;
 //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
 // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
 t.adsr[0].set(2::ms, 10::ms, 1., 400::ms);
 t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
 t.go();   t $ ST @=> ST @ last; 

 while(1) {
        100::ms => now;
 }
  


