TONE t;
t.reg(FROG2 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ __h/1_

____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ h/4 _5/h_

____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ __F/g_

____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ __g/f_

" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
