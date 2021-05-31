
TONE t;
t.scale.size(0);
t.scale << 1 << 3 << 1 << 2 << 3 << 2;
t.reg(AMB0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); //
//t.mix();// 
//t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  {c
111_ ____
111_ ___ *4 ____ :4  
222_ ____
111_ ___ *4 ____ :4
" => t.seq;
0.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][6] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 
//<<<"POTAR 1.6 GAIN">>>; 

//STLPF lpf;
//lpf.connect(last $ ST , 10 * 10 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 
STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


STREV1 rev;
rev.connect(last $ ST, .22 /* mix */);     rev  $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
