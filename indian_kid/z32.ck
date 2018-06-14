TONE t; t.scale.size(0);
 t.scale << 1;

t.reg(MOD1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); //
//t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  


// Bb B Bb B   C B C B

" *2

{5 
 b___ ____ ____ __6_
 c___ ____ ____ __7_ 
 b___ ____ ____ __6_
 c___ ____ ____ __7_ 

 d___ ____ ____ __8_
 c___ ____ ____ __7_
 d___ ____ ____ __8_
 c___ ____ ____ __7_ 
" => t.seq;
.9 => t.gain;
t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STLPF lpf;
//lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
