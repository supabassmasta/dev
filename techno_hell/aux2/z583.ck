TONE t;
t.reg(SERUM0 s0); s0.config( 6, 2);  //data.tick * 8 => t.max; //
//t.reg(SERUM0 s0); s0.config( 4, 1);  //data.tick * 8 => t.max; //
11::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
//t.dor();// t.aeo(); // 
t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c 
85643201
01485892
17206845
58921720

85201643
01892485
17845206
58720921
" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .5 /* span 0..1 */, 12*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 7 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][3] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 


STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][5] /* freq */  , HW.lpd8.potar[1][6] /* Q */  );       lhpfc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
