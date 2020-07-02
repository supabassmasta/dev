

TONE t;
t.reg(CELLO1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(CELLO1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(CELLO1 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(CELLO1 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
__
__
__
__

5|^7|a|c 5|^7|a|c
5|^7|a|c 5|^7|a|c
5|^7|a|c 5|^7|a|c
5|^7|a|c_

" => t.seq;
0.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
2 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
2 * data.tick => dur a;
5 * data.tick => dur r;
//10::ms => dur a;
//10::ms => dur r;
t.adsr[0].set(a, 0::ms, 1., r);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set( a, 0::ms, 1.,  r);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set( a, 0::ms, 1.,  r);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[3].set( a, 0::ms, 1.,  r);
t.adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//STGVERB stgverb;
///stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 7::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 
STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 8 * 10. /* room size */, 7::second /* rev time */, 0.4 /* early */ , 0.8 /* tail */ ); stgverb $ ST @=>  last; 

STFADEIN fadein;
fadein.connect(last, 4*16*data.tick);     fadein  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
