TONE t;
t.reg(SERUM0 s0); s0.config(50,0);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 
{7 1111 

" => t.seq;
.32 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 1 * 1::second/ (2*data.tick) /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1* 100 /* f_base */ , 8 * 100  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
//stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 18 * 100 /* freq var */, data.tick * 1 / 16 /* modulation period */, 3 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, 4*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
