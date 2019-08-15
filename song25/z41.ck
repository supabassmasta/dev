TONE t;
t.reg(SERUM0 s0); s0.config(47, 0);
t.reg(SERUM0 s1); s1.config(47, 0);
t.reg(SERUM0 s2); s2.config(47, 0);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 1|5|8" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(20::ms, 160::ms, .001, 400::ms);
//t.adsr[0].setCurves(1.0, 0.3, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.adsr[1].set(20::ms, 160::ms, .001, 400::ms);
//t.adsr[1].setCurves(1.0, 0.3, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.adsr[2].set(20::ms, 160::ms, .001, 400::ms);
//t.adsr[2].setCurves(1.0, 0.3, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  5::ms /* dur base */, 1::ms /* dur range */, .2 /* freq */); 

STLPF lpf;
lpf.connect(last $ ST , 500 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 28);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
