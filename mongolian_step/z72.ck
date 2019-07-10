TONE t;
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //
60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c
2_4_ 6___ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____

____ ____ ____ ____
3_1_ 5___ ____ ____
____ ____ ____ ____
____ ____ ____ ____

____ ____ ____ ____
____ ____ ____ ____
4_2_ 0___ ____ ____
____ ____ ____ ____

____ ____ ____ ____
B_5_ 1___ ____ ____
____ ____ ____ ____
____ ____ ____ ____


" => t.seq;
1.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(10::ms, 3 * 10::ms, .7, 200::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 4::ms /* dur range */, 2 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 4::ms /* dur range */, 2.1 /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

