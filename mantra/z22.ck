TONE t;
t.reg(PSYBASS0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.scale.size(0);
t.scale << 1 << 3 << 1 << 2 << 3 << 2;
//t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2  
_1_1 _1_1 
_1_1 _1__ 
_1_1 _1_1 
_1_1 _1!3!1 

_2_2 _2_2 
_2_2 _2__ 
_1_1 _1_1 
_1_1 _1!3!1 


" => t.seq;
.8 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();// 
//t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 4 * 100 /* freq */  , 1.5 /* Q */  );       lpf $ ST @=>  last; 

//STREV1 rev;
//rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
