TONE t;
t.reg(AMB1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();//
t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4
11__ ____

" => t.seq;
.3 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick*3 /* period */, 0.5 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "BPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 400  /* f_var */, 8::second / (2 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
