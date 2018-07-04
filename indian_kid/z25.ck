TONE t;
t.reg(PLOC0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); //
t.dor();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2*2 }c}c 
7531 {c
7531 {c
7531 {c
7531 }c
1357 }c
1357 }c
1357 }c
1357 }c

" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 
 
<<<"PLOC* : lpd8 1.2: Gain">>>;

while(1) {
       100::ms => now;
}
 
