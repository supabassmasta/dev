TONE t;
t.reg(DUBBASS1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.mix();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
1_1_ 1___
____ ____
8_1_ 1_1_
____ ____

5_5_ 5___
__8_ ____
8_5_ 5_5_
__5_ ____

1_1_ 1___
____ ____
8_1_ 1_1_
____ ____

B_B_ B___
__8_ ____
5_B_ B_B_
__8_ ____

" => t.seq;
//____ ____
.5 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 4*100 /* freq */  , 1.3 /* Q */  );       lpf $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
