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
"*8*2 }c
11__ ____ 11__ 11__ 8___ ____ 1_1_ 1_1_
11__ 11__ ____ 11__ __88 __11 __88 ____
8__5 ____ 8__5 _B__ 8__5 _B__ 8__5 _B__   
11_1 11_1 _1__ 18G_ 8_F5 _B__ r_1_ 1_1_
" => t.seq;
0.31 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
3 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(1::ms, 10::ms, 1, 1::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

SinOsc sin => s0.inlet;
SinOsc sin2 => s0.inlet;
//6::second / data.tick => sin.freq;
5 => sin.freq;
300 => sin.gain;
3.002 => sin2.freq;
600 => sin2.gain;

STDIGIT dig;
dig.connect(last $ ST , 1::samp /* sub sample period */ , .01 /* quantization */);      dig $ ST @=>  last; 

fun void f1 (){ 
  while(1) {

    Std.rand2f( 0 , 0.029 ) => dig.digl.quant => dig.digr.quant;
    Std.rand2(5, 50) * 1::samp => dig.digl.ech => dig.digr.ech;


    Std.rand2(1, 8) * .125 * data.tick => now;
  }


} 
spork ~ f1 ();

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 
    
STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

 
STCOMPRESSOR stcomp;
9. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 4::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 6 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
