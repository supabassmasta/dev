TONE t;
t.reg(SERUM0 s0); s0.config(22,0);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3 
___ ___
1__ 1_8 
___ ___
5__ 5_c

" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(8::ms, 35::ms, .6, 400::ms);
t.adsr[0].setCurves(0.8, 1.2, 1.4); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 2 / 6 , .8);  ech $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
