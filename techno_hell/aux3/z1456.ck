TONE t;
40 => int n;
0 => int k;

t.reg(SERUM0 s0); s0.config(n, k);
t.reg(SERUM0 s1); s1.config(n, k);
t.reg(SERUM0 s2); s2.config(n, k);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

//B|8|c //// //// {c{c c|B|1

"

B|8|c //// ////  c|B|1
}c}c B|8|c // {c{c1|B|1 __  1|B| 1 //// }c}c c|B|1
}c}c 1|B|1 // {c{c B|8|c__  1|B| 1 //// }c}c c|B|1


" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFADEIN fadein;
fadein.connect(last, 8*data.tick);     fadein  $ ST @=>  last; 

STLPFN lpfn;
lpfn.connect(last $ ST , 22 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last;  


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
