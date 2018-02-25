TONE t;
t.reg(DUBBASS0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4  
1_1_ 1___
8_5_ 5_5_
__3_ 3___
____ ____

1_1_ 1___
A_4_ 4_4!4
__2_ 2___
____ __8//1

1_1_ 1___
8_5_ 5_5_
__3_ 3___
____ ____

1_1_ 1__B
A_4_ 46_4
__2_ 24_8
____ __8//1
" => t.seq;
.1 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

t.mono() => LPF lpf => dac;
300 => lpf.freq;
1.3 => lpf.Q;

while(1) {
	     100::ms => now;
}


