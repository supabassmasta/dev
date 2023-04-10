TONE t;
t.reg(SUPERSAW2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 F/aa////k" => t.seq;
1.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync();  
t.force_off_action();
//2 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

// mod
SinOsc sin0 =>  s0.inlet;
5.5 => sin0.freq;
23.0 => sin0.gain;
.25 => sin0.phase;

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(0 /* 0 : left, 1: right 2: both */, .5 /* delay line gain */,  35::ms /* dur base */, 3::ms /* dur range */, 5 /* freq */); 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .5 /* delay line gain */,  33::ms /* dur base */, 2::ms /* dur range */, 4 /* freq */); 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STCUTTER stcutter;
"1111 1111 *8 1_1_ 1_1_ 1_1_ 1_1_  *2 1_1_ 1_1_ 1_1_ 1_1_ *2 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_ 1_1_" => stcutter.t.seq;
stcutter.t.no_sync();
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 1 * 10. /* room size */, 30::ms /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1.5 /* static gain */  );       gainc $ ST @=>  last; 
while(1) {
       100::ms => now;
}

