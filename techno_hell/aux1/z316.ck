TONE t;
t.reg(SERUM0 s0); s0.config(6, 0);

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

/*
1_1_ 5__5 __5_ 8_1_ 
____ _5 _1__8_ ____
1_1_ 5___ ____ 8_1_ 
_0__ _5 _1____ ____



*/
"*8 }c
1_1_ 1_1_ 1_1_ 1_1_
1_1_ 1_1_ 11__ 11__

1_1_ 1_1_ 1_1_ 1_1_
1__1 __1_ _1_1 1_1_

" => t.seq;
0.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

SinOsc sin => s0.inlet;
SinOsc sin2 => s0.inlet;
//6::second / data.tick => sin.freq;
5 => sin.freq;
300 => sin.gain;
3 => sin2.freq;
600 => sin2.gain;

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 3000  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .2);  ech $ ST @=>  last; 

STCOMPRESSOR stcomp;
11. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

while(1) {
       100::ms => now;
}
 
