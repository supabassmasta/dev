TONE t;
t.reg(PSYBASS6 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.scale.size(0);
//t.scale << 1 << 3 << 1 << 2 << 3 << 2;
t.mix();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4  
__1!1 


" => t.seq;
1.0 => t.gain;
t.sync(1*data.tick);// t.element_sync();//  t.no_sync();// 
//t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STHPF hpf;
hpf.connect(last $ ST , 48 /* freq */  , 2.0 /* Q */  );       hpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .05 /* mix */);     rev  $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 190 /* freq */  , 1.1 /* Q */  );       lpf $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
