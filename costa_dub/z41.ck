TONE t;
t.reg(MOD0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *8
1_1_1_1_1_1_1_1_
1_1_5_0_1_9_C_1_
3_3_1_7_0_a_3_1_
1_1___1_1__1__1_

1_1_1_1_1_1_1_1_
1_1_4_A_0_8_B_1_
2_2_0_6_A_9_2_1_
1_1___1_1__1__1_
" => t.seq;
.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*3 + 1] /* pad 4:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc $ ST @=> last;

STREV1 rev;
rev.connect(last $ ST, .2 /* mix */);     rev  $ ST @=>  last; 

//////////////////////////////////////
// ECHO SECTION
///////////////////////////////////
STADSRC stadsrc2;
stadsrc2.connect(t, HW.launchpad.keys[16*3 + 2] /* pad 3:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 0  /* toggle */);  stadsrc2 $ ST @=> last;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (3 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 



STREV1 rev2;
rev2.connect(last $ ST, .2 /* mix */);     rev  $ ST @=>  last; 

while(1) {
	     100::ms => now;
}


