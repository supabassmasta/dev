2 => int k;
TONE t;
t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, k /* FILE */, 100::ms /* UPDATE */);
s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, k /* FILE */, 100::ms /* UPDATE */);
// s0.pos s0.rate s0.lastbuf 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
/*
2_|2_2_|2_ 2_|2_2_|2_
5_|5_5_|5_ 5_|5_5_|5_
1_|1_1_|1_ 1_|1_1_|1_
1_|1_1_|1_ 1_|1_1_|1_
*/
"}c
2_|2_2_|2_ 
5_|5_5_|5_ 
1_|1_1_|1_ 
1_|1_1_|1_ 

2_|2_2_|2_ 
5_|5_5_|5_ 
1_|1_1_|1_ 
1_|1_0_|0_ 

" => t.seq;

.9 * data.master_gain => t.gain;
8 * data.tick => t.the_end.fixed_end_dur;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STCONVREV stconvrev;
stconvrev.connect(last $ ST , 15/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 4. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
