TONE t;
t.reg(PLOC0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); //
t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2*2 {c{c
 {c{c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c
1357 }c

" => t.seq;
3.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 1500 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 7 / 4 , .6);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

last.mono() => Dyno d => dac;

d.limit();

.2 =>d.gain;


while(1) {
       100::ms => now;
}
 
