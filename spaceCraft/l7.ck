TONE t;
t.reg(PLOC0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c
1__3 1___ 5_2_ 4_1_
____ ____ ____ 4___
____ 1___ 5___ __1_
1___ ____ ____ 4___

5__5 __2_ ____ 4___
____ ____ 1_3_ ____
1___ ____ ____ ____
1___ __6_ 4_3_ ____
" => t.seq;
1.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick

-1  * (t.s.duration - 4 *data.tick) => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STHPF hpf;
//hpf.connect(last $ ST , 13 * 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 2 * 1000 /* cutoff */  , 3. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 


//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 5 * 100 /* f_base */ , 4 * 100  /* f_var */, 13::second / (1 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STECHOC0 ech;
ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][2] /* Gain */ );      ech $ ST @=>  last;   

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
