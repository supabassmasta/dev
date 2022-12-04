TONE t;
t.reg(MOD0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4
1___1___1__1__*4 1_1_1_1_:4
1___1_8____5__1_
1___3_5_*4 1_1_1_1_:4_8__1_
3__7__#4_3_#4_7___
*4 1_8_1_8_1_8_1_8_:41_1_1__1__1_
1___1_8_1__5__1_
1___3_5_1__*4 8_8_8_8_:4_1_
3__#4__#4_*4 3_7_3_7_3_7_3_7_:47___
" => t.seq;
.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STREV1 rev;
rev.connect(last $ ST, .2 /* mix */);     rev  $ ST @=>  last; 

STADSRC stadsrc;
stadsrc.connect(t $ ST, HW.launchpad.keys[16*3 + 1] /* pad 4:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last;

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 14 /* freq */); 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 2 / 4 , .95);  ech2 $ ST @=>  last; 
.3 => ech2.gain;

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;  
//////////////////////////////////////
// ECHO SECTION
///////////////////////////////////
STADSRC stadsrc2;
stadsrc2.connect(t, HW.launchpad.keys[16*3 + 2] /* pad 3:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 0  /* toggle */);  stadsrc2 $ ST @=> last;

STECHO ech;
ech.connect(last $ ST , data.tick * 6 / 4 , .8);  ech $ ST @=>  last; 
.7 => ech.gain;

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (3 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 





STREV1 rev2;
rev2.connect(last $ ST, .2 /* mix */);     rev  $ ST @=>  last; 

<<<"********************************************">>>;
<<<"** DUB LEAD FX  GLITCHED                   **">>>;
<<<"** z42 : ECHO FAST autopan                **">>>;
<<<"** z43 : ECHO SLOW autofilter             **">>>;
<<<"********************************************">>>;



while(1) {
	     100::ms => now;
}


