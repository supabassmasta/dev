TONE t;
t.reg(PSYBASS1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
__11___1__11 __1//8 __11___1__ 8// //1 __ 
__11___1__11 __1//8 __11___3__ 8// //1 __ 
" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 7 * 100 /* freq */  , 1.1 /* Q */  );       lpf $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .01 /* mix */, 6 * 10. /* room size */, .5::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 14);

while(1) {
       100::ms => now;
}
 
