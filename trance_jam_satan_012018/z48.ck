TONE t;
t.reg(NOISE1 s1);
t.reg(NOISE1 s2);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2  
}c }c  
___1|8 ____ ____ ____ 
___1|8/G/|P ____ ____ ____ 
" => t.seq;

3.87 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 4 * 10::ms, .4, 2400::ms);
t.adsr[0].setCurves(.4, .4, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 4 * 10::ms, .4, 3400::ms);
t.adsr[1].setCurves(.4, .4, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STREV2 rev; // DUCKED
rev.connect(last $ ST, .5 /* mix */);      rev $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 

