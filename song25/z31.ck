TONE t;
t.reg(PLOC0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *2 }c }c
____ ____ ____ ____ 
____ ____ __8_ _3_1 
____ 8___ ____ 1___ 
____ ____  ___ __3_ 
____ ____ ____ ____ 
5___ ____ ____ ____ 
____ 1___  3__ ____ 
____ ____ ____ 8_8_ 
" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  //
//-31 * data.tick => t.extra_end;   //
//t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, .2*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 3  , .8);  ech $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 28);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
