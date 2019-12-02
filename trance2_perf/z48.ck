TONE t;
t.reg(PLOC3 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8
1__1 _1__ 8_0_ 5_3_
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//////////////////////////////////////////////////////////

STEPC stepc; stepc.init(HW.lpd8.potar[1][5], 0 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc.out => Gain mult => s0.inlet;
3 => mult.op;

SinOsc s => mult;

STEPC stepc1; stepc1.init(HW.lpd8.potar[1][6], .1 /* min */, 60 /* max */, 50::ms /* transition_dur */);
stepc1.out =>  blackhole;

fun void f1 (){ 
while(1) {
  stepc1.out.last() => s.freq;
  1::samp => now;
}
 
   } 
   spork ~ f1 ();
    


//////////////////////////////////////////////////

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 14 * 10. /* room size */, 5::second /* rev time */, 0.3 /* early */ , 0.7 /* tail */ ); stgverb $ ST @=>  last; 


STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][8] /* gain */  , 1.5 /* static gain */  );       gainc $ ST @=>  last; 

// FLANGER PART

STFLANGER flang;
flang.connect(stgverb $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  data.tick / 16 /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STGAINC gainc2;
gainc2.connect(last $ ST , HW.lpd8.potar[1][7] /* gain */  , 1. /* static gain */  );       gainc2 $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 
ech.connect(gainc $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
