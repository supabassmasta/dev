TONE t;
t.reg(PLOC3 s0);  //data.tick * 8 => t.max; //
40::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 }c }c
_111 _111 _111 _111  _111 _111 _111 _111  
_111 _111 _111 _111  _111 _111 _111 _111  
}7
_111 _111 _111 _111  _111 _111 _111 _111  
_111 _111 _111 _111  _111 _111 _111 _111  
{4
_111 _111 _111 _111  _111 _111 _111 _111  
_111 _111 _111 _111  _111 _111 _111 _111  
}4
_111 _111 _111 _111  _111 _111 _111 _111  
_111 _111 _111 _111  _111 _111 _111 _111  


" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 25 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
