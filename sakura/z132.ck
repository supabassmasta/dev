TONE t;
t.reg(PSYBASS1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// 5_5_ 6___ 5_5_ 6___ 
//5_6_ 7_6_ 5_6!5 !3___
//2_0_ 2_3_ 2_0_ A___
//2_0_ 2_3_ 2_0_ A___


"}c *4
!5__5 __5_ 5__5 __5_ 66__ ____ ____ 5!6!5!6 
!5__5 __5_ 5__5 __5_ 66__ ____ ____ 5!6!5!6 
!555_ ___5 !666_ ____ 7!6!7!5 __7_ 666_ ____ 5555 ____6666!5555 !3333 ____ ____ ____


2__2 __2_ 0__0 __0_ 2__2 __2_ 3_3_ 3___ 2_2_ __2_ 0__0  __0_ A__A __A_ A_A_ A___
2__2 __2_ 0__0 __0_ 2__2 __2_ 3_3_ 3___ 2_2_ __2_ 0__0  __0_ A__A __A!0 !A!0!A_ A___

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23* 10.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
