TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(0 /* synt nb */ );
// s0.set_chunk(0); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_5_3_ 2_1_
//8_8_ 8_8_ 8_8_ 8_8_ ____ ____ ____ ____ 
//5_3_ 2_1_ 5_3_ 2_1_ 5_3_ 2_1_ 5_3_ ____
"*4*2 }c   
8_8_ 8_ 1_2_ 3_4_ F/f___ ____ F//// ////8 
8_8_ 8_ __F_ F_1_ f_f_ f//F__  ____ 8___ 
8_8_ 8_ 7_5_ 6_5_ F/f___ 1__1 __1_ __8_ 
8_8_ 8_ __f_ f___ f_f_ f//F__  f_f_ ____ 
" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  


SinOsc sin0 =>  s0.inlet;
//31.0 => sin0.freq;
//62 *10.0 => sin0.gain;

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 119/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .05 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

//STECHOC ech;
//ech.connect(last $ ST , HW.lpd8.potar[1][1] /* Period */ , HW.lpd8.potar[1][2] /* Gain */ );      ech $ ST @=>  last;  

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STGAINC gainc;
gainc.connect(stconvrev $ ST , HW.lpd8.potar[1][2] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 2 / 4 , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

<<<" oooooooooooooooooooo">>>;
<<<" oooooo PSY FM oooooo">>>;
<<<" ooo 1.2 ECHO gain oo">>>;
<<<" oooooooooooooooooooo">>>;

while(1) {

  s0.set_chunk(5); 1.0 => sin0.freq; 104 *10.0 => sin0.gain; 1.2 => s0.gain;
  data.tick * 2./1. => now;
  s0.set_chunk(4); 50.0 => sin0.freq; 220 *10.0 => sin0.gain; 1.5 => s0.gain;
  data.tick * 2./1. => now;
  s0.set_chunk(2); 22.0 => sin0.freq; 62 *10.0 => sin0.gain; 1.5 => s0.gain;
  data.tick * 2./1. => now;
}
 

while(1) {
       100::ms => now;
}
 
