TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(6 /* synt nb */ );
s0.config(0 /* synt nb */ );
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4 }c }c
13581358135813581358135813581358
#034#7#034#7#034#7#034#7#034#7#034#7#034#7#034#7
1358135813{c58135813}c58135813581358
#034#7#034#734#7#03#034#7#04#7#034#7#034#7#034#7
1358135813{c58135813}c58135813581358
#034#7#034#734#7#03#034#7#04#7#034#7#034#7#034#7
13581358135813581358135813581358
#034#7#034#7#034#7#034#7#034#7#034#7#034#7#034#7

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
.25 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 78* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STCUTTER stcutter;
"*4*4 11__" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 6 / 4 , .3);  ech $ ST @=>  last; 


[6,6, 14, 15] @=> int a[];
while(1) {
//       s0.config (a [ Std.rand2(0, a.size() -1) ]);
       s0.set_chunk (a [ Std.rand2(0, a.size() -1) ]);
       .25 * data.tick => now;
}


