class synt0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 
0.978363 => bwg.bowRate;
0.373116 => bwg.bowPressure;
0.853088 => bwg.strikePosition;
0 => bwg.preset;

124 => bwg.bowMotion;
//    bwg.controlChange( 11, 4 /* vibratoFreq */); 
//    bwg.controlChange( 128, 1 /*bowVelocity*/);
//    bwg.controlChange( 64, .1 /*setStriking*/);

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bwg.freq;
      2.8 => bwg.pluck;
       } 
       
        

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { spork ~ f1 ();} 0 => own_adsr;
}

TONE t;
t.reg(synt0 s1);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
1 * data.tick => t.the_end.fixed_end_dur; 

"}c }c *4
566_ 5__6 ____ ____ ____ ____ ____ ____
5__5 756_ 5___ ____ 3_2_ ____ 22__ ____

323_ 0___ BA__ ____ ____ ____ ____ ____
BA0_ 0___ AB__ 2__3 2_3_ ____ ____ ____

" => t.seq;
2.4 * data.master_gain => t.gain;
8 * data.tick => t.the_end.fixed_end_dur; 
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//STAUTOPAN autopan2;
//autopan2.connect(last $ ST, .3 /* span 0..1 */, 3*data.tick /* period */, 0.15 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 


STREV2 rev; // DUCKED
rev.connect(last $ ST, .2 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
