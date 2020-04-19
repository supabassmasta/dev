TONE t;
7 => int n;
1 => int r;
t.reg(SERUM0 s0); s0.config(n, r);  //data.tick * 8 => t.max; //
80::ms => t.glide;  // t.lyd(); // t.ion(); //
//t.double_harmonic();//
 0 =>t. scale.size;
 t.scale << 2 << 1 << 3 << 1 << 1 << 3 << 1 ;
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//1324 3546 5768 798a
//8978 6756 4534 2312
" *4 }c 
____ ____ ____ __31 
____ ____ ____ ___1/8 
____ ____ ____ __12 
____ ____ ____ ___f/G 
____ ____ ____ ___h/A 
____ ____ ____ __0121 
____ ____ ____ ___G/f 
" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 3 * 10. /* room size */, 3::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
