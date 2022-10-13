
TONE t;
t.reg(FROG0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();//
t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4  
{c__ P//f___
____ __f//P

" => t.seq;
2.6 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  8::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  7::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 2 * 100 /* freq base */, 4 * 100 /* freq var */, data.tick * 5 / 2 /* modulation period */, 3 /* order */, 2 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STBELL stbell0; 
stbell0.connect(last $ ST , 105 * 10 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 2.0 /* Gain */ );       stbell0 $ ST @=>  last;   

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 7 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 4 / 4 , .3);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
