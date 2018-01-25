AMBIENT2 s1;
s1.load(8);

TONE t;
t.reg(s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c
____ ____  ____0000
____ ____  ____5555
____ ____  ____4444
____ ____  ____1111  
" => t.seq;
.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

//STAUTOPAN autopan;
//autopan.connect(t $ ST, .6 /* span 0..1 */, data.tick / 3 /* period */, 0.95 /* phase 0..1 */ );  

//STREV1 rev;
//rev.connect(autopan $ ST, .1 /* mix */); 


while(1) {
       100::ms => now;
}
 

